#!/bin/bash
FILE=Mitglieder.csv
OUTFILE=AGCW_db.txt

echo Downloading $FILE

wget --no-hsts https://www.agcw.de/wp-content/persist/Mitglieder.csv -O $FILE

dos2unix -q $FILE

gawk -f agcw.awk $FILE | sort | sed 's/#. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
