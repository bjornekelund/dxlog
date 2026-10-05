#!/bin/bash
if ../1helpers/download.sh EUDXC || [ -n "$1" ]; then
    INFILE=`ls EUDXC-* | tail -1 2> /dev/null`
    OUTFILE=EUDXC_db.txt

    echo Parsing $INFILE
    dos2unix -q $INFILE

    gawk -f eudxc.awk $INFILE > $OUTFILE

    unix2dos -q $OUTFILE $INFILE
    echo Created $OUTFILE

    ../copytosourcetree.sh $OUTFILE
fi
exit
