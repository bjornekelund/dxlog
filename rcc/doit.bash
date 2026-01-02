#!/bin/bash
INFILE=`ls RCCC* | tail -1 2> /dev/null`
OUTFILE=RCC_db.txt

dos2unix -q $INFILE
echo Parsing $INFILE

gawk -f rcc.awk $INFILE | sort | sed 's/#0. /# /g' > $OUTFILE

unix2dos -q $OUTFILE
echo Created $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
