#!/bin/bash
if ../1helpers/download.sh ARRL10M || [ -n "$1" ]; then
    INFILE=`ls ARRL10M* | tail -1 2> /dev/null`
    OUTFILE=ARRL_10M_db.txt
    HELPERS=../1helpers/helpers.awk

    echo Parsing $INFILE
    dos2unix -q $INFILE

    gawk -f $HELPERS -f arrl10.awk $INFILE | sort | sed 's/^\#0. /\# /g' > $OUTFILE

    unix2dos -q $OUTFILE $INFILE
    echo Created $OUTFILE

    ../copytosourcetree.sh $OUTFILE
fi

exit
