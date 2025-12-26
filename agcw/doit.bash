#!/bin/bash
WEBFILE=Mitglieder.csv
OUTFILE=AGCW_db.txt

rm -f $WEBFILE
curl -sS https://www.agcw.de/wp-content/persist/$WEBFILE -O

if [ ! -s $WEBFILE ]; then
    echo "ERROR! Download of member roster failed. Aborting."
    exit 1
else
    echo Downloaded $WEBFILE
    dos2unix -q $WEBFILE

    cat $WEBFILE | sed 's/Ø/0/g' | sed 's/ //g' | gawk -f agcw.awk | sort | sed 's/#. /# /g' > $OUTFILE

    echo Created $OUTFILE
    unix2dos -q $OUTFILE

    ../copytosourcetree.bash $OUTFILE
fi

exit
