#!/usr/bin/env bash
# Usage: ./remove_lines.sh <subdirectory>
set -euo pipefail

dir="${1:?Usage: $0 <subdirectory>}"
file="$dir/filter.awk"

[[ -f "$file" ]] || { echo "Error: $file not found" >&2; exit 1; }

cp -p "$file" "$file.bak"          # backup, remove if you don't want it

tmp=$(mktemp)
trap 'rm -f "$tmp"' EXIT

# -F = fixed strings (no regex escaping needed), -v = drop matching lines
grep -vF \
  -e 'printf("#01 Based on data from https://supercheckhistory.com/\n");' \
  -e 'printf("#02 Last updated %s\n", strftime("%Y-%m-%d"));' \
  "$file" > "$tmp" || true         # grep exits 1 if nothing is left to output

cat "$tmp" > "$file"               # overwrite in place, keeping permissions
echo "Done: cleaned $file (backup at $file.bak)"
