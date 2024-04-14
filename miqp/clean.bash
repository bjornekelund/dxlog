#!/bin/bash
FILE=QSOP_MI-2024-002.txt
OUTFILE=QSOP_MI-2024-003.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk '
BEGIN {
  FS=","
  col = 2;
}
{
  if ($0 ~ "!!Order!!") {
    if ($3 ~ /Exch1/) col = 2;
    if ($4 ~ /Exch1/) col = 3;
    if ($5 ~ /Exch1/) col = 4;
    printf("%s --> col=%d\n", $0, col) > "/dev/stderr";
  } 
  if ($0 ~ /^(!|#|$)/ || $col != "") {
      printf("%s\n", $0);
  }
  else { 
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}' $FILE > $OUTFILE

unix2dos -q $OUTFILE
echo Created $OUTFILE

exit
