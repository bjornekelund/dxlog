#!/usr/bin/env bash
NAMEFILE=n1mmlatest.txt

set -euo pipefail

BASE="https://n1mmwp.hamdocs.com"

if [[ $# -ne 1 ]]; then
    echo "Usage: $0 name" >&2
    exit 1
fi

name="$1"
search="$BASE/mmfiles/categories/callhistory/?CMDsearch=$name&view=list&sort=post_modified"

# Find the most recently modified matching file.
#
# N1MM returns the results newest first when sorted by post_modified.
#
# Only accept filenames where the requested name is followed by
# ".", "_" or "-". This prevents, for example:
#
#   ./download.sh CWOPS
#
# from matching CWOPSOPEN.
#
# Do not exit from awk after finding the first match. It must continue
# consuming curl's output, otherwise curl can fail with error 23 because
# the receiving end of the pipe has been closed.
page=$(
    curl -fsSL "$search" |
    awk -v name="$name" '
        BEGIN {
            IGNORECASE=1
            found=0
        }

        /<a href="[^"]*\/mmfiles\// {
            if (match($0, /href="[^"]+"/)) {
                candidate = substr($0, RSTART+6, RLENGTH-7)
            }
            next
        }

        /cmdm-list-item-title/ && candidate != "" {
            title = $0
            gsub(/<[^>]*>/, "", title)
            gsub(/^[ \t]+|[ \t]+$/, "", title)

            if (!found && title ~ "^" name "[._-]") {
                print candidate
                found=1
            }

            candidate = ""
        }
    '
)

if [[ -z "$page" ]]; then
    echo "No file matching '$name' found" >&2
    exit 1
fi

# Get the individual file page
html=$(curl -fsSL "$page")

# Extract the download form action.
# The action also contains the actual filename.
action=$(
    printf '%s\n' "$html" |
    grep -oE 'action="[^"]*/mmfile/get/file/[^"]+"' |
    head -1 |
    sed 's/^action="//; s/"$//'
)

if [[ -z "$action" ]]; then
    echo "Could not determine download URL" >&2
    exit 1
fi

# Get the actual filename from the download URL
filename=${action##*/}

echo "Most recent file: $filename"
echo "$filename" > $NAMEFILE

# Don't download if the most recent file already exists
if [[ -f "$filename" ]]; then
    echo "$filename is already downloaded"
    exit 1
fi

# Extract the nonce required by the download form
nonce=$(
    printf '%s\n' "$html" |
    grep -oE 'name="cmdm_nonce" value="[^"]+"' |
    head -1 |
    sed 's/.*value="//; s/"$//'
)

# Extract the file ID required by the download form
id=$(
    printf '%s\n' "$html" |
    grep -oE 'name="id" value="[0-9]+"' |
    head -1 |
    sed 's/.*value="//; s/"$//'
)

if [[ -z "$nonce" || -z "$id" ]]; then
    echo "Could not extract download information" >&2
    exit 1
fi

echo "Downloading $filename"

# Download the file
curl -fsSL \
    --connect-timeout 10 \
    --max-time 30 \
    --retry 3 \
    -d "cmdm_nonce=$nonce" \
    -d "id=$id" \
    "$action" \
    -o "$filename"

echo "Downloaded $filename"
exit 0