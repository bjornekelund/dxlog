#!/bin/bash
WEBFILE=agb-list.txt
OUTFILE=AGB_db.txt

rm -f $WEBFILE
curl -sS http://ev5agb.com/club/$WEBFILE -O

if [ ! -s $WEBFILE ]; then
    echo "ERROR! Download of $WEBFILE failed. Aborting."
    exit 1
else
    echo Downloaded $WEBFILE
    dos2unix -q $WEBFILE

    gawk -f agb.awk $WEBFILE | sort | sed 's/#. /# /g' > $OUTFILE

    echo Created $OUTFILE
    unix2dos -q $OUTFILE

    ../copytosourcetree.bash $OUTFILE
fi
exit
