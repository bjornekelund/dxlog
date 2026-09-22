#!/usr/bin/env bash

set -u
set -o pipefail

INPUT="${1:-n1mm_cluster_responses.txt}"
OUTPUT="${2:-dxcluster_nodes.txt}"

if [[ ! -f "$INPUT" ]]; then
    echo "ERROR: input file not found: $INPUT" >&2
    exit 1
fi

LC_ALL=C awk -v output="$OUTPUT" '

function trim(s) {
    gsub(/^[ \t]+|[ \t]+$/, "", s)
    return s
}

# Remove everything except printable 7-bit ASCII plus tab.
# Because LC_ALL=C is used, this operates byte-by-byte and is safe
# even if the input contains malformed UTF-8 or arbitrary high bytes.
function ascii_only(s) {
    gsub(/[^\t\x20-\x7E]/, "", s)
    return s
}

# Amateur-radio callsign with optional -1 .. -99 SSID.
function valid_call(s) {
    return s ~ /^[A-Z0-9]{1,3}[0-9][A-Z]{1,4}(-[0-9]{1,2})?$/
}

function extract_call(s, x) {

    s = ascii_only(s)

    # DXSpider:
    #   Hello SK7CE, this is F6GCP-3 ...
    if (match(s,
        /[Tt]his is [A-Z0-9]{1,3}[0-9][A-Z]{1,4}(-[0-9]{1,2})?([^A-Z0-9-]|$)/)) {

        x = substr(s, RSTART, RLENGTH)
        sub(/^[Tt]his is /, "", x)
        sub(/[^A-Z0-9-].*$/, "", x)

        if (valid_call(x))
            return x
    }

    # Prompt:
    #   SK7CE de F6GCP-3 ...
    if (match(s,
        /[A-Z0-9]{1,3}[0-9][A-Z]{1,4}(-[0-9]{1,2})? de [A-Z0-9]{1,3}[0-9][A-Z]{1,4}(-[0-9]{1,2})?([^A-Z0-9-]|$)/)) {

        x = substr(s, RSTART, RLENGTH)
        sub(/^.* de /, "", x)
        sub(/[^A-Z0-9-].*$/, "", x)

        if (valid_call(x))
            return x
    }

    # AR-Cluster:
    #   Welcome to the BH4HKZ AR-Cluster node ...
    if (match(s,
        /[Ww]elcome to (the )?[A-Z0-9]{1,3}[0-9][A-Z]{1,4}(-[0-9]{1,2})? AR-[Cc]luster node/)) {

        x = substr(s, RSTART, RLENGTH)
        sub(/^[Ww]elcome to /, "", x)
        sub(/^the /, "", x)
        sub(/ AR-[Cc]luster.*$/, "", x)

        if (valid_call(x))
            return x
    }

    # CC Cluster:
    #   Welcome to LZ7A cluster
    if (match(s,
        /[Ww]elcome to [A-Z0-9]{1,3}[0-9][A-Z]{1,4}(-[0-9]{1,2})? [Cc]luster/)) {

        x = substr(s, RSTART, RLENGTH)
        sub(/^[Ww]elcome to /, "", x)
        sub(/[ \t]+[Cc]luster.*$/, "", x)

        if (valid_call(x))
            return x
    }

    # CC Cluster:
    #   Greetings from JG1VGX-7 DX/RBN Cluster
    # Also tolerate the "Greetngs" typo seen on some nodes.
    if (match(s,
        /[Gg]reet[a-z]* from [A-Z0-9]{1,3}[0-9][A-Z]{1,4}(-[0-9]{1,2})?/)) {

        x = substr(s, RSTART, RLENGTH)
        sub(/^[Gg]reet[a-z]* from /, "", x)

        if (valid_call(x))
            return x
    }

    # Another common form:
    #   Welcome to Node DH8WR-1
    if (match(s,
        /[Ww]elcome to [Nn]ode [A-Z0-9]{1,3}[0-9][A-Z]{1,4}(-[0-9]{1,2})?/)) {

        x = substr(s, RSTART, RLENGTH)
        sub(/^[Ww]elcome to [Nn]ode /, "", x)

        if (valid_call(x))
            return x
    }

    return ""
}

function process_record() {
    if (host == "" || port == "")
        return

    ssid = extract_call(text)

    if (ssid != "" && valid_call(ssid))
        print ssid "=" host ";" port ";YES;;" >> output
}

BEGIN {
    in_record = 0
    host = ""
    port = ""
    text = ""

    printf "%s", "" > output
    close(output)
}

{
    # Sanitize each line BEFORE doing any parsing.
    line = ascii_only($0)

    if (line ~ /^=START=/) {
        if (in_record)
            process_record()

        in_record = 1
        host = ""
        port = ""
        text = ""
        next
    }

    if (line ~ /^=STOP=/) {
        if (in_record)
            process_record()

        in_record = 0
        host = ""
        port = ""
        text = ""
        next
    }

    if (!in_record)
        next

    if (line ~ /^HOST:/) {
        host = line
        sub(/^HOST:[ \t]*/, "", host)
        host = trim(host)

        if (host == "host")
            host = ""

        next
    }

    if (line ~ /^PORT:/) {
        port = line
        sub(/^PORT:[ \t]*/, "", port)
        port = trim(port)

        if (port !~ /^[0-9]+$/)
            port = ""

        next
    }

    text = text "\n" line
}

END {
    if (in_record)
        process_record()
}

' "$INPUT"

# Remove exact duplicates while preserving order.
LC_ALL=C awk '!seen[$0]++' "$OUTPUT" > "$OUTPUT.tmp" &&
    mv "$OUTPUT.tmp" "$OUTPUT"

echo "Wrote $(wc -l < "$OUTPUT") nodes to $OUTPUT"