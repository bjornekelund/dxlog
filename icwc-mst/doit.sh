#!/bin/bash
if ../1helpers/download.sh ICWC-MST || [ -n "$1" ]; then
    INFILE=`ls ICWC-* | tail -1 2> /dev/null`
    OUTFILE=ICWCMST_db.txt

    echo Parsing $INFILE
    dos2unix -q $INFILE

    gawk -f filter.awk $INFILE | sort | sed 's/^#0. /# /g' > $OUTFILE

    unix2dos -q $OUTFILE $INFILE
    echo Created $OUTFILE

    ../copytosourcetree.sh $OUTFILE
fi
exit
