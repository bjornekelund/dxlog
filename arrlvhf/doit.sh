#!/bin/bash
if ../1helpers/download.sh ARRLVHFSEP || [ -n "$1" ]; then
    INFILE=`ls ARRLVHF[^_]* | tail -1 2> /dev/null`
    OUTFILE=ARRL-VHF_db.txt

    echo Parsing $INFILE
    dos2unix -q $INFILE

    gawk -f arrlvhf.awk $INFILE | sort | sed 's/^#0. /# /g' > $OUTFILE

    unix2dos -q $OUTFILE $INFILE
    echo Created $OUTFILE

    ../copytosourcetree.sh $OUTFILE
fi
exit
