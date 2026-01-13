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
    cat $INFILE | sed 's/\"//g' | sed 's/\\N//g' | gawk -f dig.awk | sort | sed 's/=0*/=/g' | sed 's/^#0. /# /g' > $OUTFILE

    unix2dos -q $OUTFILE
    echo Created $OUTFILE

    if [ -s ../copytosourcetree.bash ]; then
        ../copytosourcetree.bash $OUTFILE
    fi
fi

exit
