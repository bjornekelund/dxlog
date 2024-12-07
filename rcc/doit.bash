#!/bin/bash
FILE=`ls RCCC* | tail -1 2> /dev/null`
OUTFILE=RCC_db.txt

dos2unix -q $FILE
echo Parsing $FILE

gawk -f rcc.awk $FILE | sort | sed 's/#. /# /g' > $OUTFILE

unix2dos -q $OUTFILE
echo Created $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
