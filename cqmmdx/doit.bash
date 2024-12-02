#!/bin/bash
#FILE=CQMMDX.txt
FILE=`ls CQMMDX[^_]* | tail -1 2> /dev/null`
OUTFILE=CQMMDX_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk -f cqmmdx.awk $FILE | sort | sed 's/#. /# /g' > $OUTFILE

unix2dos -q $OUTFILE
echo $OUTFILE created

../copytosourcetree.bash $OUTFILE

exit
