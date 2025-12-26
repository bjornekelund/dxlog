#!/bin/bash
WEBFILE=Mitglieder.csv
OUTFILE=AGCW_db.txt

rm -f $WEBFILE
echo Downloading $WEBFILE

curl -sS https://www.agcw.de/wp-content/persist/Mitglieder.csv -o $WEBFILE

if [ ! -s "$WEBFILE" ]; then
    echo "ERROR! Web file is empty or doesn't exist"
    exit 1
fi

dos2unix -q $WEBFILE

cat $WEBFILE | sed 's/Ø/0/g' | sed 's/ //g' | gawk -f agcw.awk | sort | sed 's/#. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
