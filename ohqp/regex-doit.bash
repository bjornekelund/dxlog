#!/bin/bash
INFILE=ohcounties.txt
OUTFILE=oh-regex.txt

echo Parsing $INFILE...
dos2unix -q $INFILE


gawk '
BEGIN {
  FS="=";
  notfirst = 0;
  count = 0;
  printf("^(");
}
{
    if (notfirst) printf("|");
    notfirst = 1;
    printf("%s", $1);
}
END {
  printf(")$\n");
}' $INFILE > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit

