#!/bin/bash
FILE=`ls JARTSWW* | tail -1 2> /dev/null`
OUTFILE=JARTSNEXTYEAR.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk '
BEGIN {
  FS=","
  col = 2;
}
{
  if ($1 ~ /^[0-9,A-Z,\/]+$/ && $col ~ /^[1-9][0-9]?$/)
    printf("%s,%s,\n", $1, $col + 1);
  else if ($0 !~ /^(!|#|$)/)
    printf("Invalid exchange: \"%s\"\n", $0) > "/dev/stderr";
  else
    printf("%s\n", $0);
}
END { }' $FILE > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
