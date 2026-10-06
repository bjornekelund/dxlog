#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <subdirectory>" >&2
    exit 1
fi

subdir="${1%/}"   # strip any trailing slash

if [[ ! -d "$subdir" ]]; then
    echo "Error: '$subdir' is not a directory" >&2
    exit 1
fi

name="$(basename "$subdir")"

if [[ -f "$subdir/webfiles.txt" ]]; then
    mv -- "$subdir/webfiles.txt" "$subdir/schfile.txt"
else
    printf '%s.txt' "$name" > "$subdir/schfile.txt"
fi
