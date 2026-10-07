#!/usr/bin/env bash
# Remove all LF and CRLF line endings from every dbfile.txt in all subfolders.
# Usage: ./strip_eol.sh [start_dir]   (defaults to current directory)

start_dir="${1:-.}"

find "$start_dir" -type f -name 'dbfile.txt' -print0 |
while IFS= read -r -d '' file; do
    tmp="$(mktemp "${file}.XXXXXX")" || continue
    if tr -d '\r\n' < "$file" > "$tmp"; then
        mv "$tmp" "$file"
        echo "Processed: $file"
    else
        rm -f "$tmp"
        echo "Failed: $file" >&2
    fi
done
