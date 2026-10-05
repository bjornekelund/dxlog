#!/bin/bash
if ../1helpers/download.sh WWPMC || [ -n "$1" ]; then
    INFILE=`ls WWPMC_2* | tail -1 2> /dev/null`
    OUTFILE=WWPMC_db.txt

    dos2unix -q $INFILE
    echo "Parsing" $INFILE...

    gawk -f wwpmc.awk $INFILE | sort | sed 's/^\#0. /\# /g' > $OUTFILE

    unix2dos -q $OUTFILE $INFILE
    echo "Created" $OUTFILE

    ../copytosourcetree.sh $OUTFILE
fi
exit
