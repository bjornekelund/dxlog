#!/bin/bash
if ../1helpers/download.sh Names_VE2FK || [ -n "$1" ]; then
    INFILE=`ls Names_VE2FK* | tail -1 2> /dev/null`
    OUTFILEXDT=Opnames.xdt
    OUTFILE=NAMES_db.txt

    echo Parsing $INFILE
    dos2unix -q $INFILE

    gawk -f names-xdt.awk $INFILE | sort | sed 's/^#0. /# /g' > $OUTFILEXDT

    unix2dos -q $OUTFILEXDT
    echo Created $OUTFILEXDT

    cp $OUTFILEXDT ../xdt

    echo Parsing $INFILE

    gawk -f names.awk $INFILE | sort | sed 's/^#0. /# /g' > $OUTFILE

    unix2dos -q $OUTFILE $INFILE
    echo Created $OUTFILE

    ../copytosourcetree.sh $OUTFILE
fi
# cd ../fistsspr; ./doit.sh
# cd ../arrlrr; ./doit.sh

exit
