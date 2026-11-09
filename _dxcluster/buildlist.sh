#!/usr/bin/env bash

set -u
set -o pipefail

URL="https://www.n1mm-lib.hamdocs.com/_getfromclusterratings.php"
OUTPUT="n1mm_live_clusters.csv"
TIMEOUT=5
PARALLEL=20

TMPDIR="$(mktemp -d)"
#TMPDIR=.
trap 'rm -rf "$TMPDIR"' EXIT

RAW="$TMPDIR/.raw.txt"
NODES="$TMPDIR/.nodes.csv"
RESULTS="$TMPDIR/results.csv"
BAD="$TMPDIR/bad.txt"

echo "Downloading N1MM Live Cluster List..."
if ! curl -fsSL --connect-timeout 10 --max-time 30 "$URL" | sed 's/<br[[:space:]]*\/\{0,1\}>/\n/gI' > "$RAW"; then
    echo "ERROR: Could not download $URL" 
    exit 1
fi

# Verify that this looks like the expected N1MM response.
if ! grep -q '^STARTOFDATA$' "$RAW"; then
    echo "ERROR: Unexpected response from N1MM endpoint." 
    exit 1
fi

#echo "Parsing cluster list..."

# Output:
# continent,host,port,n1mm_reports,n1mm_success_pct
#
# Example input:
# EU - cluster.gautxori.com... (229 / 86%), cluster.gautxori.com:7300
#
# We deliberately use the LAST comma-separated field because the
# first displayed hostname may be truncated by the N1MM server/UI.

echo "Parsing cluster list..."

awk -v badfile="$BAD" '
BEGIN {
    OFS = ","
}

/^[A-Z][A-Z][[:space:]]*-[[:space:]]*/ {

    line = $0
    continent = substr(line, 1, 2)

    # The final comma separates the N1MM statistics/display text
    # from the complete host:port returned by the server.
    last_comma = 0
    for (i = length(line); i >= 1; i--) {
        if (substr(line, i, 1) == ",") {
            last_comma = i
            break
        }
    }

    if (last_comma == 0) {
        print line > badfile
        next
    }

    info = substr(line, 1, last_comma - 1)
    address = substr(line, last_comma + 1)

    gsub(/^[[:space:]]+/, "", address)
    gsub(/[[:space:]]+$/, "", address)
    gsub(/[[:space:]]*:[[:space:]]*/, ":", address)

    # Find the last statistics block, e.g. "(335 / 91%)"
    p1 = 0
    for (i = length(info); i >= 1; i--) {
        if (substr(info, i, 1) == "(") {
            p1 = i
            break
        }
    }

    reports = ""
    success = ""

    if (p1 > 0) {
        tail = substr(info, p1 + 1)
        p2 = index(tail, ")")

        if (p2 > 0) {
            stats = substr(tail, 1, p2 - 1)
            slash = index(stats, "/")

            if (slash > 0) {
                reports = substr(stats, 1, slash - 1)
                success = substr(stats, slash + 1)

                gsub(/[[:space:]]/, "", reports)
                gsub(/[[:space:]%]/, "", success)
            }
        }
    }

    # Split host and port on the final colon.
    colon = 0
    for (i = length(address); i >= 1; i--) {
        if (substr(address, i, 1) == ":") {
            colon = i
            break
        }
    }

    if (colon == 0) {
        print line > badfile
        next
    }

    host = substr(address, 1, colon - 1)
    port = substr(address, colon + 1)

    gsub(/[[:space:]]/, "", host)
    gsub(/[[:space:]]/, "", port)

    if (host == "" || port !~ /^[0-9]+$/) {
        print line > badfile
        next
    }

    print continent, host, port, reports, success
}
' "$RAW" |
awk -F, '
{
    key = $2 ":" $3

    # Keep only the first occurrence of each host:port.
    if (!(key in seen)) 
    {
        seen[key] = 1
        print
    }
}
' > "$NODES"

# echo
# echo "N1MM records:"
# grep -c '^[A-Z][A-Z] - ' "$RAW"

# echo
# echo "Parsed records:"
# wc -l < "$NODES"

# echo
# echo "Unique host:port nodes:"
# cut -d, -f2-3 "$NODES" | sort -u | wc -l

# echo
# echo "Malformed records:"
# wc -l < "$BAD"

# echo
# echo "First 20 parsed nodes:"
# head -20 "$NODES"

# echo
# echo "Parsed node count:"
# wc -l "$NODES"
# echo

NODE_COUNT="$(wc -l < "$NODES" | tr -d ' ')"
echo "Found $NODE_COUNT unique host:port nodes."

# CSV header
echo "continent,host,port,n1mm_reports,n1mm_success_pct,dns,tcp_connect" > "$RESULTS"

check_node() {
    local continent="$1"
    local host="$2"
    local port="$3"
    local reports="$4"
    local success="$5"

    local dns="NO"
    local tcp="NO"

    # Check DNS first.
    if getent ahosts "$host" >/dev/null 2>&1; then
        dns="YES"

        # TCP connect test.
        #
        # Bash /dev/tcp is used because it is widely available and
        # does not require nc or telnet to be installed.
        if timeout "$TIMEOUT" bash -c "</dev/tcp/$host/$port" \
            >/dev/null 2>&1; then
            tcp="YES"
        fi
    fi

    printf '%s,%s,%s,%s,%s,%s,%s\n' \
        "$continent" "$host" "$port" "$reports" "$success" "$dns" "$tcp"
}

export -f check_node
export TIMEOUT

echo "Testing TCP connectivity (timeout ${TIMEOUT}s, parallelism ${PARALLEL})..."

# xargs starts multiple independent checks in parallel.
#
# Input fields are tab-separated to avoid problems with commas.
awk -F, 'BEGIN { OFS="\t" } { print $1,$2,$3,$4,$5 }' "$NODES" |
    xargs -P "$PARALLEL" -n 5 bash -c '
        check_node "$1" "$2" "$3" "$4" "$5"
    ' _ |
    sort -t, -k1,1 -k2,2 -k3,3n >> "$RESULTS"

mv "$RESULTS" "$OUTPUT"

ALIVE="$(awk -F, 'NR > 1 && $7 == "YES" { count++ } END { print count+0 }' "$OUTPUT")"
DEAD="$(awk -F, 'NR > 1 && $7 == "NO" { count++ } END { print count+0 }' "$OUTPUT")"

echo "Done."
echo "CSV: $OUTPUT"
echo "TCP reachable: $ALIVE"
echo "TCP not reachable: $DEAD"

if [ -s "$BAD" ]; then
    echo
    echo "Malformed endpoint records:"
    cat "$BAD"
fi

awk '
BEGIN {
    FS = ",";
    printf("0#\n1# DXLog.net default cluster list\n2#\n");
}
{
    url = $2;
    port = $3;
    if (url ~ /^[A-Za-z]/) 
    {
        printf("%s=%s;%s;YES;;\n", url, url, port);
    }
}' "$OUTPUT" | sort | sed 's/[0-9]#/#/g' > dxlist.txt
