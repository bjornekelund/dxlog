#!/bin/bash
if ../1helpers/download.sh PACC || [ -n "$1" ]; then
    INFILE=`ls PACC-* | tail -1 2> /dev/null`
    OUTFILE=PACC_db.txt

    echo Parsing $INFILE
    dos2unix -q $INFILE

    gawk -f pacc.awk $INFILE | sort | sed 's/^#0. /# /g' > $OUTFILE

    unix2dos -q $OUTFILE $INFILE
    echo Created $OUTFILE

    ../copytosourcetree.sh $OUTFILE
fi
exit
