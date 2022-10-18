#!/bin/bash
FILE=`ls JARTSWW* | tail -1 2> /dev/null`
OUTFILE=JARTSNEXTYEAR.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk '
BEGIN {
  FS=","
  printf("# JARTS WW RTTY database for next year\n");
  col = 2;
}
{
  if ($0 ~ /^!!Order!!/) {
    printf("%s\n", $0);
    if ($2 == "Exch1") col = 1;
    if ($3 == "Exch1") col = 2;
    if ($4 == "Exch1") col = 3;
    if ($5 == "Exch1") col = 4;
    printf("%s --> col=%d\n", $0, col) > "/dev/stderr";
  } else {
    if ($1 ~ /^[0-9,A-Z,\/]+$/ && $col ~ /^[1-9][0-9]?$/)
      printf("%s,%s\n", $1, $col + 1);
    else if ($0 !~ /^(!|#|$)/)
      printf("Invalid exchange: \"%s\"\n", $0) > "/dev/stderr";
  }  
}
END { }' $FILE > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
