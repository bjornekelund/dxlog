#!/bin/bash
if ../1helpers/download.sh LZDX || [ -n "$1" ]; then
    INFILE=`ls LZDX-2* | tail -1 2> /dev/null`
    OUTFILE=LZDX_db.txt

    dos2unix -q $INFILE
    echo Parsing $INFILE...

    gawk -f lzdx.awk $INFILE | sort | sed 's/^#0. /# /g' > $OUTFILE

    unix2dos -q $OUTFILE $INFILE
    echo Created $OUTFILE

    rm -rf $OLDTEMP

    ../copytosourcetree.sh $OUTFILE
fi
exit
