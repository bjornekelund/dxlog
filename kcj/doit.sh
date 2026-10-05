#!/bin/bash
if ../1helpers/download.sh KCJ || [ -n "$1" ]; then
    INFILE=`ls KCJ-* | tail -1 2> /dev/null`
    OUTFILE=KCJ_db.txt

    echo Parsing $INFILE
    dos2unix -q $INFILE

    gawk -f kcj.awk $INFILE | sort | sed 's/^#0. /# /g' > $OUTFILE

    unix2dos -q $OUTFILE $INFILE
    echo Created $OUTFILE

    ../copytosourcetree.sh $OUTFILE
fi
exit

