#!/bin/bash
INFILE=`ls EUHFC[^_]* | tail -1 2> /dev/null`
OUTFILE=EUHFC_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

tr -d ' ' < $INFILE | gawk -f euhfc.awk | sort | sed 's/^\#0. /\# /g' > $OUTFILE

unix2dos -q $OUTFILE $INFILE
echo Created $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
