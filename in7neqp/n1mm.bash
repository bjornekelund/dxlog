#!/bin/bash
OUTFILE=QSOP_IN7QPNE_DE-2024.txt
rm -f $OUTFILE
FILE=`ls QSOP* | tail -1 2> /dev/null`

echo Parsing $FILE
dos2unix -q $FILE

gawk -f n1mm.awk $FILE > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
