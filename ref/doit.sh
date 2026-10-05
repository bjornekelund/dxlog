#!/bin/bash
if ../1helpers/download.sh REFCW || [ -n "$1" ]; then
    INFILE=`ls REFCW* | tail -1 2> /dev/null`
    OUTFILE=REF_db.txt

    echo Parsing $INFILE
    dos2unix -q $INFILE

    sed 's/ //g' $INFILE | gawk -f ref.awk | sort | sed 's/^#0. /# /g' > $OUTFILE

    unix2dos -q $OUTFILE $INFILE
    echo Created $OUTFILE

    ../copytosourcetree.sh $OUTFILE
fi
exit
