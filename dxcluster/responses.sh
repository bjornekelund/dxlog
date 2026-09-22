#!/usr/bin/env bash

set -u
set -o pipefail

INPUT="n1mm_live_clusters.csv"
OUTPUT="n1mm_cluster_responses.txt"

TIMEOUT=15
PARALLEL=20
CALLSIGN="SK7CE"

# TMPDIR="$(mktemp -d)"
# trap 'rm -rf "$TMPDIR"' EXIT
rm -rf temp
mkdir temp
TMPDIR=temp

connect_node()
{
    local host="$1"
    local port="$2"
    local index="$3"

    local fifo
    local raw
    local telnet_pid

    fifo="$TMPDIR/fifo_$index"
    raw="$TMPDIR/response_$(printf '%08d' "$index").txt"

    mkfifo "$fifo"

    {
        echo "============================================================"
        echo "HOST: $host"
        echo "PORT: $port"
        echo "============================================================"

        # Start telnet with its stdin connected to the FIFO.
        telnet "$host" "$port" < "$fifo" 2>&1 &
        telnet_pid=$!

        # Open the FIFO for writing. This keeps telnet's stdin open.
        exec 3>"$fifo"

        # Give the server a moment to establish the connection.
        sleep 3

        # Send the callsign.
        printf '%s\n' "$CALLSIGN" >&3

        # Keep the session alive while collecting the response.
        sleep 3

        # Close telnet's stdin.
        exec 3>&-

        # Don't leave telnet processes behind.
        wait "$telnet_pid" 2>/dev/null || true
    } > "$raw"

    rm -f "$fifo"
}

export CALLSIGN TMPDIR
export -f connect_node

index=0

while IFS=',' read -r field1 host port rest; do
    index=$((index + 1))

    # Remove CR and surrounding whitespace.
    host="${host//$'\r'/}"
    port="${port//$'\r'/}"

    host="$(printf '%s' "$host" | xargs)"
    port="$(printf '%s' "$port" | xargs)"

    [[ -z "$host" || -z "$port" ]] && continue

    # Limit the number of simultaneous connections.
    while (( $(jobs -rp | wc -l) >= PARALLEL )); do
        wait -n 2>/dev/null || true
    done

    connect_node "$host" "$port" "$index" &
done < "$INPUT"

wait

# Combine responses in input-file order.
: > "$OUTPUT"

for file in "$TMPDIR"/response_*.txt; do
    [[ -f "$file" ]] || continue
    cat "$file" >> "$OUTPUT"
done

echo
echo "Responses saved to $OUTPUT"