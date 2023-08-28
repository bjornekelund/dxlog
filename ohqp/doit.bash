#!/bin/bash
FILE=`ls QSOP_OH* | tail -1 2> /dev/null`
OUTFILE=OHQP_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk -f ohqp.awk $FILE | sort | sed 's/#. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
