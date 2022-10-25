#!/bin/bash
FILE=`ls K1USNSST-* | tail -1 2> /dev/null`

echo Scrubbing $FILE
dos2unix -q $FILE

gawk '
BEGIN {
  FS=","
  col = 2;
}
{
  if ($0 ~ "^!!Order!!") {
    if ($2 ~ /Name/) col = 1;
    if ($3 ~ /Name/) col = 2;
    if ($4 ~ /Name/) col = 3;
    if ($5 ~ /Name/) col = 4;
    # printf("%s --> col=%d\n", $0, col);
  } else {
    nm = toupper($col)
    if ($1 !~ /^(A[A-L]|K|N|W|V[A-Y])/) {
      if ($3 != "DX" && $0 !~ /^(!|#|$)/) {
        printf("Exchange should be DX: \"%s\"\n", $0) > "/dev/stderr";
      }
    }
    if ($1 ~ /^[0-9,A-Z]/ && nm ~ /^[A-Z ]+$/) {
      if (call[$1] != "")
        printf("\"%s\" reappears as \"%s\"\n", line[$1], $0);
      line[$1] = $0;
      call[$1] = $1;
      name[$1] = nm;
    }
    else if ($0 !~ /^(!|#|$)/ && nm != "")
      printf("Invalid exchange: \"%s\"\n", $0) > "/dev/stderr";
  }
}
END { }' $FILE

exit
