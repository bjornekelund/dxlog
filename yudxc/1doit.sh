#!/bin/bash
if ../1helpers/download.sh YUDXC || [ -n "$1" ]; then
    INFILE=`ls YUDXC_2* | tail -1 2> /dev/null`
    OUTFILE=YUDXC_db.txt

    echo Parsing $INFILE
    dos2unix -q $INFILE

    gawk -f yudxc.awk $INFILE | sort | sed 's/^#0. /# /g' > $OUTFILE

    unix2dos -q $OUTFILE $INFILE
    echo Created $OUTFILE

    ../copytosourcetree.sh $OUTFILE
fi
exit
