#!/bin/bash
if ../1helpers/download.sh ARRL160; then
    INFILE=`ls ARRL160* | tail -1 2> /dev/null`
    OUTFILE=ARRL_160M_db.txt
    HELPERS=../1helpers/helpers.awk

    echo Parsing $INFILE
    dos2unix -q $INFILE

    gawk -f $HELPERS -f arrl160.awk $INFILE | sort | sed 's/^\#0. /\# /g' > $OUTFILE

    unix2dos -q $OUTFILE $INFILE
    echo Created $OUTFILE

    ../copytosourcetree.sh $OUTFILE
fi
exit
