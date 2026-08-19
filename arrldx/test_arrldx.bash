#!/bin/bash
# Tests for arrldx.awk
# Usage: bash test_arrldx.bash

PASS=0
FAIL=0
AWK=arrldx.awk
DIR="$(cd "$(dirname "$0")" && pwd)"

run_awk() {
    echo "$1" | gawk -f "$DIR/$AWK" 2>/dev/null | grep -v '^#' | sort
}

run_awk_stderr() {
    echo "$1" | gawk -f "$DIR/$AWK" 2>&1 1>/dev/null
}

assert_output() {
    local desc="$1"
    local input="$2"
    local expected="$3"
    local actual
    actual=$(run_awk "$input")
    if [ "$actual" = "$expected" ]; then
        PASS=$((PASS + 1))
    else
        FAIL=$((FAIL + 1))
        echo "FAIL: $desc"
        echo "  expected: '$expected'"
        echo "  actual:   '$actual'"
    fi
}

assert_stderr_contains() {
    local desc="$1"
    local input="$2"
    local pattern="$3"
    local actual
    actual=$(run_awk_stderr "$input")
    if echo "$actual" | grep -q "$pattern"; then
        PASS=$((PASS + 1))
    else
        FAIL=$((FAIL + 1))
        echo "FAIL: $desc"
        echo "  expected stderr to contain: '$pattern'"
        echo "  stderr was: '$actual'"
    fi
}

HEADER='!!Order!!,Call,Name,State,Power,UserText,'

# --- DX stations (power exchange) appear in output ---

assert_output "DX station with numeric power" \
    "$HEADER
3V8SS,,,100," \
    "3V8SS=100"

assert_output "DX station with K power" \
    "$HEADER
3Z0X,,,K," \
    "3Z0X=K"

assert_output "DX station with KW power" \
    "$HEADER
4O3A,,,KW," \
    "4O3A=KW"

assert_output "DX station with W suffix power" \
    "$HEADER
9A1A,,,500W," \
    "9A1A=500W"

assert_output "DX station with 1KW power" \
    "$HEADER
LZ1A,,,1KW," \
    "LZ1A=1KW"

assert_output "DX station with slash prefix" \
    "$HEADER
5B/RN3QO,,,100," \
    "5B/RN3QO=100"

assert_output "DX station with slash suffix" \
    "$HEADER
RN3QO/5,,,100," \
    "RN3QO/5=100"

# --- US stations (state exchange) appear in output ---

assert_output "US station K prefix with state" \
    "$HEADER
K3CT,,PA," \
    "K3CT=PA"

assert_output "US station W prefix with state" \
    "$HEADER
W1AW,,CT," \
    "W1AW=CT"

assert_output "US station N prefix with state" \
    "$HEADER
N5RZ,,TX," \
    "N5RZ=TX"

assert_output "US station AA prefix with state" \
    "$HEADER
AA1K,,CT," \
    "AA1K=CT"

assert_output "US station KA prefix" \
    "$HEADER
KA2D,,NY," \
    "KA2D=NY"

assert_output "4U1WB with DC" \
    "$HEADER
4U1WB,,DC," \
    "4U1WB=DC"

assert_output "KH6/ prefix with state" \
    "$HEADER
KH6/W1AW,,HI," \
    "KH6/W1AW=HI"

assert_output "KL7/ prefix with state" \
    "$HEADER
KL7/N7AA,,AK," \
    "KL7/N7AA=AK"

# --- Canadian stations are excluded from output ---

assert_output "Canadian VE station excluded" \
    "$HEADER
VE2FK,,QC," \
    ""

assert_output "Canadian VA station excluded" \
    "$HEADER
VA3RKM,,ON," \
    ""

assert_output "Canadian CY station excluded" \
    "$HEADER
CY9SS,,NS," \
    ""

# --- Comments, blanks, and bangs are silently ignored ---

assert_output "Comment line ignored" \
    "$HEADER
# this is a comment" \
    ""

assert_output "Blank line ignored" \
    "$HEADER
" \
    ""

assert_output "Bang line ignored" \
    "$HEADER
!something" \
    ""

# --- Multiple stations ---

assert_output "Multiple DX stations" \
    "$HEADER
LZ1A,,,KW,
9A1A,,,500," \
    "9A1A=500
LZ1A=KW"

assert_output "Mix of DX and US stations" \
    "$HEADER
K3CT,,PA,
3V8SS,,,100," \
    "3V8SS=100
K3CT=PA"

assert_output "Mix with Canadian station excluded" \
    "$HEADER
K3CT,,PA,
VE2FK,,QC,
3V8SS,,,100," \
    "3V8SS=100
K3CT=PA"

# --- Duplicate detection ---

assert_stderr_contains "Duplicate callsign warns on stderr" \
    "$HEADER
3V8SS,,,100,
3V8SS,,,200," \
    "Repeated entry"

# --- Invalid lines warn on stderr ---

assert_stderr_contains "Invalid line warns on stderr" \
    "$HEADER
INVALID_CALL,,,BADPOWER," \
    "Ignored"

assert_stderr_contains "US call with invalid state warns" \
    "$HEADER
K3CT,,ZZ," \
    "Ignored"

# --- Alternate column order ---

assert_output "Alternate column order for DX" \
    '!!Order!!,Name,Call,Power,State,UserText,
,3V8SS,100,,' \
    "3V8SS=100"

assert_output "Alternate column order for US station" \
    '!!Order!!,Name,Call,State,Power,UserText,
,W1AW,CT,,' \
    "W1AW=CT"

# --- Column order detection logged to stderr ---

assert_stderr_contains "Order line logged to stderr" \
    "$HEADER" \
    "call=1 pcol=4 scol=3"

# --- Header comments in output ---

assert_output "Header comment lines present" \
    "$HEADER" \
    ""

# --- Power validation ---

assert_stderr_contains "Power 0 is invalid" \
    "$HEADER
LZ1A,,,0," \
    "Ignored"

assert_output "Power with 4 digits" \
    "$HEADER
LZ1A,,,1500," \
    "LZ1A=1500"

assert_stderr_contains "Power with 5 digits is invalid" \
    "$HEADER
LZ1A,,,15000," \
    "Ignored"

# --- W0/ prefix treated as US ---

assert_output "W0/ prefix with state" \
    "$HEADER
W0/DL1A,,CO," \
    "W0/DL1A=CO"

# --- /W0 suffix treated as US ---

assert_output "/W0 suffix with state" \
    "$HEADER
DL1A/W5,,TX," \
    "DL1A/W5=TX"

# --- Summary ---
echo ""
echo "Results: $PASS passed, $FAIL failed"
[ "$FAIL" -eq 0 ] && exit 0 || exit 1
