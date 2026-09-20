#!/bin/bash
INFILE=multipliers-in.txt
OUTFILE=list-in.txt

echo Parsing $INFILE
dos2unix -q $INFILE

gawk 'BEGIN {
  FS = " ";
}
{
  name = $2;
  if ($3 != "") name = name " " $3;
  if ($4 != "") name = name " " $4;
  if ($1 ~ /^[A-Z]{5}$/)
    printf("%s=Indiana %s\n", $1, name);
}
END {
}' $INFILE > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
