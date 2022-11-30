#!/bin/bash
OUTFILE=R4W-CHAMP_db.txt
RDAFILE=RDAC_huge_csv.txt
GRIDFILE=Russian_cup_db.txt

echo Parsing $RDAFILE $GRIDFILE
dos2unix -q $GRIDFILE $RDAFILE

grep -v -F 4W $GRIDFILE > .grids
grep -e ",UD[0-9[0-9]" $RDAFILE | sed 's/,/=/g' > .rdas

cat .rdas .grids | gawk '
BEGIN {
  printf("#0 Udmurtia open championship database\n");
  printf("#1 Last updated %s\n", strftime("%Y-%m-%d"));
}
{
  printf("%s\n", $0);
}
END { }' $FILE | sort | sed 's/#. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
