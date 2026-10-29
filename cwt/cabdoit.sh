#!/bin/bash
INFILE=CWT_db.txt
CABFILE=CWT.log

dos2unix -q $INFILE

echo Parsing $INFILE
cat $INFILE | { echo "!!Order!!,Call,Name,Exch1"; cat; } | gawk -f ../1helpers/helpers.awk -f cabrillo.awk > $CABFILE
echo Created $CABFILE
unix2dos -q $CABFILE

exit
