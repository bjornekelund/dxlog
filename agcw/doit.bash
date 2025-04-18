#!/bin/bash
INFILE=Mitglieder.csv
OUTFILE=AGCW_db.txt

echo Downloading $INFILE

curl -sS https://www.agcw.de/wp-content/persist/Mitglieder.csv -o $INFILE

dos2unix -q $INFILE

cat $INFILE | sed 's/Ø/0/g' | gawk -f agcw.awk | sort | sed 's/#. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
