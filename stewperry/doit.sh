#!/bin/bash
if ../1helpers/download.sh STEWPERRY || [ -n "$1" ]; then
    INFILE=`ls STEWPERRY[!_]* | tail -1 2> /dev/null`
    OUTFILE=StewPerry_db.txt

    echo Parsing $INFILE
    dos2unix -q $INFILE

    gawk -f stewperry.awk $INFILE | sort | sed 's/^#0. /# /g' > $OUTFILE

    unix2dos -q $OUTFILE $INFILE
    echo Created $OUTFILE

    ../copytosourcetree.sh $OUTFILE
fi
exit
