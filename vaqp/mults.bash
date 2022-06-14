#!/bin/bash
FILE=vqp-raw.txt
OUTFILE=multipliers.txt

echo Parsing $FILE
dos2unix -q $FILE

cat $FILE | sed 's/* //g' | gawk '
BEGIN {
  odd = 1;
  mult = "";
}
{
  if (odd) {
    mult = $1;
  }
  else {
    printf("%s=%s\n", $1, mult)
  }
  odd = !odd;
}
END { }' | sort > $OUTFILE

unix2dos -q $OUTFILE
echo Created $OUTFILE

exit
