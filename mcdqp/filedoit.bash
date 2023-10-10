#!/bin/bash
INFILE=`ls MAR* | tail -1 2> /dev/null`
OUTFILE=MCD_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

gawk -f fmcdqp.awk $INFILE | sort | sed 's/^\#. /\# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
