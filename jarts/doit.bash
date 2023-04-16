#!/bin/bash
FILE=`ls JARTSWW* | tail -1 2> /dev/null`
OUTFILE=JARTSNEXTYEAR.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk -f jarts.awk $FILE > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
