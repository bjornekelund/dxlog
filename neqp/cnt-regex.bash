#!/bin/bash
FILE=multipliers.txt
OUTFILE2=regex-counties.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk '
BEGIN {
  FS="=";
  printf("^(");
}
{
  cnt = $1
  printf("%s|", cnt);
}
END {
  printf(")$\n");
}' $FILE | sed 's/|)/)/g' > $OUTFILE2

echo Created $OUTFILE2
unix2dos -q $OUTFILE2

exit
