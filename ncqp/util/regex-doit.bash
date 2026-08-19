#!/bin/bash
INFILE=mult-counties.txt
OUTFILE=regex-counties.txt

echo Parsing $INFILE
dos2unix -q $INFILE

gawk '
BEGIN {
  FS = "=";
  printf("^(");
}
{
  cnt = $1
  printf("%s|", cnt);
}
END {
  printf(")$\n");
}' $INFILE | sed 's/|)/)/g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
