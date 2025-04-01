#!/bin/bash
FILE=Mitglieder.csv
OUTFILE=AGCW_db.txt

echo Downloading $FILE

curl -sS https://www.agcw.de/wp-content/persist/Mitglieder.csv -o $FILE

dos2unix -q $FILE

cat $FILE | sed 's/Ø/0/g' | gawk -f agcw.awk | sort | sed 's/#. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
