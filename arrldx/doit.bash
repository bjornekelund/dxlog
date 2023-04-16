#!/bin/bash
INFILE=`ls ARRLDX*`
OUTFILE=ARRL_DX_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

cat $INFILE | sort | gawk -f arrldx.awk | sort | sed 's/^\#. /\# /g' > ARRL_DX_db.txt

echo $OUTFILE created
unix2dos -q $OUTFILE

exit
