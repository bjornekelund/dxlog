#!/bin/bash

INFILE=List_Members_MC.csv
OUTFILE=MCD_db.txt

echo Downloading $INFILE

curl -sS https://www.marconiclub.it/List_Members_MC.csv -o $INFILE

dos2unix -q $INFILE

sed 's/ //g' $INFILE |\
  iconv -f ISO-8859-1 -t ASCII//TRANSLIT |\
  gawk -f mcdqp.awk | sort | sed 's/#. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
