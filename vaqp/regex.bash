#!/bin/bash
FILE=vqp-raw.txt
OUTFILE=regex.txt

echo Using file \"$FILE\"

dos2unix -q $FILE

cat $FILE | sed 's/* //g' | gawk '
BEGIN {
  even = 0;
}
{
  if (even)
    printf("%s\n", $1)
  even = !even;
}' | sort | gawk '
BEGIN {
  printf("^(")
}
{
  printf("%s|", $1)
}
END {
  printf(")$")
}' | sed 's/|)/)/g' > $OUTFILE
unix2dos -q $OUTFILE
echo Created $OUTFILE
exit
