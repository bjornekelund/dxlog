#!/bin/bash
#FILE=CQMMDX.txt
FILE=`ls CQMMDX[^_]* | tail -1 2> /dev/null`
OUTFILE=CQMMDX_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

gawk -f cqmmdx.awk $INFILE | sort | sed 's/#. /# /g' > $OUTFILE

unix2dos -q $OUTFILE $INFILE
echo Created $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
