#!/bin/bash
FILE=multipliers.txt
OUTFILE=regex.txt

echo Using file \"$FILE\"

dos2unix -q $FILE

cat $FILE | gawk '
BEGIN {
  FS = "=";
  printf("^(");
}
{
  printf("%s|", $1);
}
END {
  printf(")$");
}' | sed 's/|)/)/g' > $OUTFILE

unix2dos -q $OUTFILE

echo Created $OUTFILE
exit
