#!/bin/bash
if ../1helpers/download.sh BB_ITALIA || [ -n "$1" ]; then
    INFILE=`ls BB_* | tail -1 2> /dev/null`
    OUTFILE=BANDE_BASSE_db.txt

    echo Parsing $INFILE
    dos2unix -q $INFILE

    gawk -f bb.awk $INFILE | sort | sed 's/#0./#/g' > $OUTFILE

    unix2dos -q $OUTFILE $INFILE
    echo Created $OUTFILE

    ../copytosourcetree.sh $OUTFILE
fi
exit
