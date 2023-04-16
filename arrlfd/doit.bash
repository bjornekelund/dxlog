#!/bin/bash
INFILE=`ls FD* | tail -1 2> /dev/null`
OUTFILE=ARRL_FD_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

gawk -f arrlfd.awk $INFILE | sort | sed 's/^\#. /\# /g' > $OUTFILE

echo $OUTFILE created
unix2dos -q $OUTFILE

exit
