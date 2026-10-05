#!/bin/bash
if ../1helpers/download.sh QSOP_MN || [ -n "$1" ]; then
    INFILE=`ls QSOP_* | tail -1 2> /dev/null`
    OUTFILE=MNQP_db.txt
    HELPERS=../1helpers/helpers.awk

    echo Parsing $INFILE
    dos2unix -q $INFILE

    sed 's/ //g' $INFILE | gawk -f $HELPERS -f mnqp.awk | sort | sed 's/^#0. /# /g' > $OUTFILE

    unix2dos -q $OUTFILE $INFILE
    echo Created $OUTFILE

    ../copytosourcetree.sh $OUTFILE
fi
exit
