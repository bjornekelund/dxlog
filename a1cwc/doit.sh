#!/bin/bash

if ../1helpers/download.sh A1AWT; then
    INFILE=`ls A1AWT* | tail -1 2> /dev/null`
    OUTFILE=A1CWC_db.txt

    echo Parsing $INFILE
    dos2unix -q $INFILE

    gawk -f a1cwc.awk $INFILE | sort | sed 's/^#0. /# /g' > $OUTFILE

    unix2dos -q $OUTFILE $INFILE
    echo Created $OUTFILE

    ../copytosourcetree.sh $OUTFILE
fi

exit
