#!/bin/bash

WEBFILE=List_Members_MC.csv
OUTFILE=MCD_db.txt

rm -f $WEBFILE
curl -sS https://www.marconiclub.it/List_Members_MC.csv -o $WEBFILE

if [ ! -s $WEBFILE ]; then
    echo "ERROR! Download of $WEBFILE failed"
    exit 1
else
    echo Downloaded $WEBFILE
    dos2unix -q $WEBFILE
    echo Parsing $WEBFILE

  sed 's/ //g' $WEBFILE |\
    iconv -f ISO-8859-1 -t ASCII//TRANSLIT |\
    gawk -f mcdqp.awk | sort | sed 's/#. /# /g' > $OUTFILE

  echo Created $OUTFILE
  unix2dos -q $OUTFILE

  if [ -s ../copytosourcetree.bash ]; then
      ../copytosourcetree.bash $OUTFILE
  fi
fi

exit
