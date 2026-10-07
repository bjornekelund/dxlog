#!/bin/bash
#set -x

if ../1helpers/download.sh 9ADX || [ -n "$1" ]; then
    INFILE=`ls 9ADX_2* | tail -1 2> /dev/null`
    OUTFILE=9ADX_db.txt

    dos2unix -q $INFILE
    echo Parsing $INFILE

    gawk -f filter.awk $INFILE | sort | sed 's/^\#0. /\# /g' > $OUTFILE

    unix2dos -q $OUTFILE
    echo Created $OUTFILE

    ../copytosourcetree.sh $OUTFILE
fi

exit
