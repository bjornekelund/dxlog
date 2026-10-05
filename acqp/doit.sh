#!/bin/bash

if ../1helpers/download.sh QSOP_AC || [ -n "$1" ]; then
    INFILE=`ls QSOP* | tail -1 2> /dev/null`
    OUTFILE=ACQP_db.txt
    HELPERS=../1helpers/helpers.awk

    echo Parsing $INFILE
    dos2unix -q $INFILE

    gawk -f $HELPERS -f acqp.awk $INFILE | sort | sed 's/^#0. /# /g' > $OUTFILE

    echo Created $OUTFILE
    unix2dos -q $OUTFILE $INFILE

    ../copytosourcetree.sh $OUTFILE
fi

exit
