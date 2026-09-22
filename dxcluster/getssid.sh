#!/usr/bin/env bash

set -u
set -o pipefail

INPUT="n1mm_live_clusters.csv"
OUTPUT="n1mm_live_cluster_ssids.csv"

TIMEOUT=10
PARALLEL=20

if [[ $# -lt 1 ]]; then
    echo "Usage: $0 CALLSIGN" >&2
    exit 1
fi

CALLSIGN="$(printf '%s' "$1" | tr '[:lower:]' '[:upper:]')"

TMPDIR="$(mktemp -d)"
trap 'rm -rf "$TMPDIR"' EXIT

RESULTS="$TMPDIR/results"
mkdir -p "$RESULTS"

check_node()
{
    local line="$1"
    local index="$2"

    local host port raw
    host="$(printf '%s\n' "$line" | cut -d',' -f2 | tr -d '\r' | xargs)"
    port="$(printf '%s\n' "$line" | cut -d',' -f3 | tr -d '\r' | xargs)"

    [[ -z "$host" || -z "$port" ]] && return

    raw="$TMPDIR/raw_$index.txt"

    # Give the cluster our callsign and then collect whatever it sends.
    timeout "$TIMEOUT" telnet "$host" "$port" >"$raw" 2>&1 <<EOF
$CALLSIGN
EOF

    local ssid=""

    #
    # Normalize the response:
    #   - remove CR
    #   - uppercase everything
    #   - remove ANSI escape sequences
    #
    local response
    response="$(
        sed -E \
            -e 's/\x1B\[[0-9;?]*[ -\/]*[@-~]//g' \
            -e 's/\r//g' \
            "$raw" |
        tr '[:lower:]' '[:upper:]'
    )"
    echo "$response" >> /dev/stderr
    #
    # Look for callsign-like strings with an SSID:
    #
    #   SM7IUN-1
    #   GB7DJK-2
    #   OZ1LAP-10
    #   EA5ELX-5
    #
    # Permit 1-3 characters before the first digit, followed by any
    # legal callsign characters and then -SSID.
    #
    # We deliberately don't assume anything about the surrounding text.
    #
    mapfile -t candidates < <(
        printf '%s\n' "$response" |
        grep -Eo '\b[A-Z0-9]{3,8}(-[0-9]{1,2})?\b' |
        sort |
        uniq -c |
        sort -nr |
        awk '{print $2}'
    )

    #
    # Choose a candidate.
    #
    # Exclude:
    #   - our own callsign
    #   - things that clearly aren't cluster identifiers
    #
    for candidate in "${candidates[@]}"; do

        [[ "$candidate" == "$CALLSIGN" ]] && continue

        #
        # The SSID-bearing part is the important characteristic.
        # Require the part before -N to contain at least one letter.
        #
        if [[ "$candidate" =~ ^[A-Z/0-9]*[A-Z][A-Z/0-9]*-[0-9]{1,2}$ ]]; then
            ssid="$candidate"
            break
        fi
    done

    if [[ -n "$ssid" ]]; then
        printf '%s,%s,%s\n' "$ssid" "$host" "$port" > "$RESULTS/$index"
    else
        echo "No SSID found: $host:$port" >&2
    fi
}

export CALLSIGN TIMEOUT TMPDIR RESULTS
export -f check_node

awk 'NF { print NR "\t" $0 }' "$INPUT" |
    xargs -P "$PARALLEL" -n 1 bash -c '
        record="$0"
        index="${record%%	*}"
        line="${record#*	}"
        check_node "$line" "$index"
    '

{
    echo "SSID,host,port"

    for file in "$RESULTS"/*; do
        [[ -f "$file" ]] || continue
        cat "$file"
    done
} > "$OUTPUT"

echo
echo "Done."
echo "Output: $OUTPUT"
echo "Nodes found: $(($(wc -l < "$OUTPUT") - 1))"