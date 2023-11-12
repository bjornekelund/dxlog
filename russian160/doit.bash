#!/bin/bash
FILE=rgx_oblast.txt
OUTFILE=r160mult.txt

echo Parsing $FILE
dos2unix -q $FILE

cat $FILE | gawk '
BEGIN {
  FS="="
  printf("#0 Explicit Oblast multipliers\n");
}
{
  if ($0 ~ /^\^/) {
    printf("MULT1_EXCEPTION=DEST->CALL:%s;VALUE:%s\n", $1, $2);
  }
}' | sed 's/#. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
