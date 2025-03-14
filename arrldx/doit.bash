#!/bin/bash
INFILE=`ls ARRLDX[^_]* | tail -1 2> /dev/null`
OUTFILE=ARRL_DX_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

cat $INFILE | sort | gawk -f arrldx.awk | sort | sed 's/^\#. /\# /g' > $OUTFILE

echo $OUTFILE created
unix2dos -q $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
