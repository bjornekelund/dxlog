#!/bin/bash
#FILE=`ls ../naqp/NAQP[^_]* | tail -1 2> /dev/null`
FILE=`ls QSOP* | tail -1 2> /dev/null`
OUTFILE=NJQP_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk -f njqp.awk $FILE | sort | sed 's/#. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
