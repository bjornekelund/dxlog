#!/bin/bash
TMP=.mults.txt
OUTFILE=multipliers.txt
cp 'EUDX CONTEST 2022 MULTIPLIERS.txt' $TMP
echo Parsing EUDX CONTEST 2022 MULTIPLIERS.txt

dos2unix -q $TMP
gawk '
BEGIN {
  FS=" ";
}
{
  if ($2 == "")
    printf("# %s\n", $1)
  else {
    printf("%s=", $1);
    $1 = "";
    printf("%s\n", $0);
  }
}' $TMP | sed 's/= /=/g' > $OUTFILE
echo Created $OUTFILE
unix2dos -q $OUTFILE
exit
