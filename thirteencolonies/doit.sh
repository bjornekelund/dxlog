#!/bin/bash

if ../1helpers/download.sh 13COLONIES || [ -n "$1" ]; then
    INFILE=`ls 13COLONIES-* | tail -1 2> /dev/null`
    OUTFILE=13COLONIES_db.txt
    HELPERS=../1helpers/helpers.awk

    echo Parsing $INFILE
    dos2unix -q $INFILE

    gawk -f $HELPERS -f filter.awk $INFILE | sort | sed 's/^#0. /# /g' > $OUTFILE

    unix2dos -q $OUTFILE $INFILE
    echo Created $OUTFILE

    ../copytosourcetree.sh $OUTFILE
fi

exit
