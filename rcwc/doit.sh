#!/bin/bash
INFILE=RCWC.txt
OUTFILE=RCWC_db.txt

rm -f $INFILE
wget -q "https://rcwc.ru/?do=members&getlist=3" -O $INFILE

if [ ! -f $INFILE ] || [ $(stat -c%s $INFILE 2>/dev/null) -lt 1000 ]; then
    echo "ERROR! Download of $INFILE failed. Aborting."
    exit 1
else
    echo Downloaded $INFILE, parsing...

    dos2unix -q $INFILE
    gawk -f rcwc.awk $INFILE | sort | sed 's/^\#0. /\# /g' > $OUTFILE

    unix2dos -q $OUTFILE
    echo Created $OUTFILE

    if [ -s ../copytosourcetree.sh ]; then
        ../copytosourcetree.sh $OUTFILE
    fi
fi
exit
