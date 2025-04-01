#!/bin/bash
# File 2 should be the newer
FILE1=`ls CNCW* | tail -1 2> /dev/null`
FILE2=`ls EARTT* | tail -1 2> /dev/null`
OUTFILE=EA_db.txt

echo Parsing $FILE1 and $FILE2
dos2unix -q $FILE1 $FILE2

cat $FILE1 $FILE2 | sed 's/ //g' | gawk -f ea.awk | sort | sed 's/#. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
