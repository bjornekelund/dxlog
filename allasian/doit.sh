#!/bin/bash
if ../1helpers/download.sh ALLASIACW || [ -n "$1" ]; then
    INFILE=`ls ALLASIACW_* | tail -1 2> /dev/null`
    OUTFILE=ALLASIAN_db.txt

    echo Parsing $INFILE
    dos2unix -q $INFILE

    gawk -f allasian.awk $INFILE | sort | sed 's/^#0[0-9]/#/g' > $OUTFILE

    unix2dos -q $OUTFILE $INFILE
    echo Created $OUTFILE

    ../copytosourcetree.sh $OUTFILE
fi
exit
