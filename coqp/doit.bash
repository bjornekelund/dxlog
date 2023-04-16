#!/bin/bash
FILE=`ls ../naqp/NAQP[^_]* | tail -1 2> /dev/null`
OUTFILE=COQP_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk -f coqp.awk $FILE | sort | sed 's/#. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
