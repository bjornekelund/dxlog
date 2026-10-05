#!/bin/bash
if ../1helpers/download.sh UNDXC || [ -n "$1" ]; then
    INFILE=`ls UNDX_[^d]* | tail -1 2> /dev/null`
    OUTFILE=UNDXC_db.txt

    echo Parsing $INFILE
    dos2unix -q $INFILE

    gawk -f undxc.awk $INFILE | sort | sed 's/^#0. /# /g' > $OUTFILE

    unix2dos -q $OUTFILE $INFILE
    echo Created $OUTFILE

    ../copytosourcetree.sh $OUTFILE
fi
exit
