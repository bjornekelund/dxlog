#!/bin/bash
WEBFILE=agb-list.txt
OUTFILE=AGB_db.txt

rm -f $WEBFILE
echo Downloading $WEBFILE

curl -sS http://ev5agb.com/club/agb-list.txt -o $WEBFILE

if [ ! -s "$WEBFILE" ]; then
    echo "ERROR! Web file is empty or doesn't exist"
    exit 1
fi

dos2unix -q $WEBFILE

gawk -f agb.awk $WEBFILE | sort | sed 's/#. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
