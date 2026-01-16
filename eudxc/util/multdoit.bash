#!/bin/bash
TMP=.mults.txt
OUTFILE=multipliers.txt
INFILE="EUDX CONTEST 2022 MULTIPLIERS.txt"
echo $INFILE

dos2unix -q $INFILE

cat "$INFILE" |\
gawk '
BEGIN {
  FS = " ";
}
{
  if ($2 == "")
    printf("# %s\n", $1)
  else 
  {
    printf("%s=", $1);
    $1 = "";
    printf("%s\n", $0);
  }
}' | sed 's/= /=/g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
