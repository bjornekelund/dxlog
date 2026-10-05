#!/bin/bash
if ../1helpers/download.sh HADX || [ -n "$1" ]; then
    INFILE=HADX.txt
    OUTFILE=HADX_db.txt

    echo Parsing $INFILE
    dos2unix -q $INFILE

    gawk -f hadx.awk $INFILE | sort | sed 's/^\#0. /\# /g' > $OUTFILE

    unix2dos -q $OUTFILE $INFILE
    echo Created $OUTFILE

    ../copytosourcetree.sh $OUTFILE
fi
exit
