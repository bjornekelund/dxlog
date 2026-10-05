#!/bin/bash
if ../1helpers/download.sh XERTTY || [ -n "$1" ]; then
    INFILE=`ls XERTTY* | tail -1 2> /dev/null`
    OUTFILE=XE_RTTY_db.txt

    echo Parsing $INFILE
    dos2unix -q $INFILE

    gawk -f xertty.awk $INFILE | sort | sed 's/^#0. /# /g' > $OUTFILE

    unix2dos -q $OUTFILE $INFILE
    echo Created $OUTFILE

    ../copytosourcetree.sh $OUTFILE
fi
exit
