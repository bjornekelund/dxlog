#!/bin/bash
INFILEOLD=EUAS-CHAMP-000.txt
INFILE=`ls EUAS-CH* | tail -1 2> /dev/null`
OUTFILE=EURASIA_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE $INFILEOLD

gawk -f eurasia.awk $INFILE $INFILEOLD | sort | sed 's/^\#. /\# /g' > $OUTFILE

unix2dos -q $OUTFILE $INFILE $INFILEOLD
echo Created $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
