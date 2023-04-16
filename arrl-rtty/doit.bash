#!/bin/bash
INFILE=`ls ARRLR* | tail -1 2> /dev/null`

echo Parsing $INFILE
OUTFILE=ARRL_RTTY_db.txt

dos2unix -q $INFILE
gawk -f arrl-rtty.awk $INFILE | sort | sed 's/^\#. /\# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
