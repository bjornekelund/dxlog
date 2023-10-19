#!/bin/bash

FILE=List_Members_MC.csv
OUTFILE=MCD_db.txt

echo Downloading $FILE

wget -q http://www.ariloano.it/marconiclub/List_Members_MC.csv -O $FILE

dos2unix -q $FILE

sed 's/ //g' $FILE |\
  iconv -f ISO-8859-1 -t ASCII//TRANSLIT |\
  gawk -f mcdqp.awk | sort | sed 's/#. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
