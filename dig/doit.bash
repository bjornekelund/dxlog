#!/bin/bash
INFILE=DIGLISTE.csv
OUTFILE=DIG_db.txt

rm -f $INFILE
curl -sS https://diplom-interessen-gruppe.info/fileadmin/downloads/DIGLISTE.csv -o $INFILE

if [ ! -s $INFILE ]; then
    echo "ERROR! Download of $INFILE failed"
    exit 1
else
    echo Downloaded $INFILE, parsing...

    dos2unix -q $INFILE
    cat $INFILE | sed 's/\"//g' | gawk -f dig.awk | sort | sed 's/=0*/=/g' | sed 's/^\#. /\# /g' > $OUTFILE

    unix2dos -q $OUTFILE
    echo Created $OUTFILE

    ../copytosourcetree.bash $OUTFILE
fi

exit
