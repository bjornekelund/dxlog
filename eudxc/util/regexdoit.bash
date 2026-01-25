#!/bin/bash
OUTFILE=regex.txt
INFILE="EUDX CONTEST 2022 MULTIPLIERS.txt"
echo $INFILE

dos2unix -q $INFILE

cat "$INFILE" |\
gawk '
BEGIN {
  FS = " ";
  printf("^(");
  notfirst = 0;
}
{
  if ($2 != "")
  {
    if (notfirst) printf("|");
    notfirst = 1;
    printf("%s", $1);
  }
}
END {
  printf(")$");
}' | sed 's/= /=/g' > $OUTFILE
echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
