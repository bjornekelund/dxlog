#!/usr/bin/env bash
set -euo pipefail

if [ $# -ne 1 ]; then
    echo "Usage: $0 <subdirectory>" >&2
    exit 1
fi

subdir="${1%/}"   # strip a trailing slash, if any

if [ ! -d "$subdir" ]; then
    echo "Error: '$subdir' is not an existing directory" >&2
    exit 1
fi

printf '%s' "$(basename "$subdir")" > "$subdir/n1mmfile.txt"
