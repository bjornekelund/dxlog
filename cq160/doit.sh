#!/bin/bash
if ../1helpers/download.sh CQ160CW || [ -n "$1" ]; then
    INFILE=`ls CQ160C* | tail -1 2> /dev/null`
    OUTFILE=CQ160_db.txt
    HELPERS=../1helpers/helpers.awk

    echo Parsing $INFILE
    dos2unix -q $INFILE

    gawk -f $HELPERS -f cq160.awk  $INFILE | sort | sed 's/^\#0. /\# /g' > $OUTFILE

    unix2dos -q $OUTFILE $INFILE
    echo Created $OUTFILE

    ../copytosourcetree.sh $OUTFILE
fi
exit
