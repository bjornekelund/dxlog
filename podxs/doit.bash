#!/bin/bash
INFILE=data.csv
OUTFILE=PODXS_db.txt

rm -f $INFILE
curl -sS "https://docs.google.com/spreadsheets/d/1s7RS8T4twf4-hNsI5uiGEsTiUnqQ51xU1Lne5B5GIUI/gviz/tq?tqx=out:csv&sheet=Member_shortlist" -o $INFILE

if [ ! -s $INFILE ]; then
    echo "ERROR! Download of $INFILE failed"
    exit 1
else
    echo Downloaded $INFILE, parsing...

    dos2unix -q $INFILE

    sed 's/\"//g' $INFILE | gawk -f podxs.awk | sort | sed 's/#. /# /g' > $OUTFILE

    unix2dos -q $OUTFILE
    echo Created $OUTFILE

    if [ -s ../copytosourcetree.bash ]; then
        ../copytosourcetree.bash $OUTFILE
    fi
fi

exit
