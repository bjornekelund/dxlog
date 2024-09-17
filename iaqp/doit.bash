#!/bin/bash
FILE=`ls QSOP_* | tail -1 2> /dev/null`
echo Parsing $FILE...
OUTFILE=IAQP_db.txt

dos2unix -q $FILE

gawk -f iaqp.awk $FILE | sort | sed 's/#. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
