#!/bin/bash
if ../1helpers/download.sh SACW || [ -n "$1" ]; then
    INFILE=`ls SACW[\.-]* | tail -1 2> /dev/null`
    OUTFILE=SACW_db.txt

    echo Parsing $INFILE
    dos2unix -q $INFILE

    gawk -f sacw.awk $INFILE | sort | sed 's/^\#0. /\# /g' > $OUTFILE

    unix2dos -q $OUTFILE $INFILE
    echo Created $OUTFILE

    ../copytosourcetree.sh $OUTFILE
fi
exit
