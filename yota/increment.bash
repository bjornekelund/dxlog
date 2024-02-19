#!/bin/bash
FILE=`ls YOTA_2* | tail -1 2> /dev/null`
OUTFILE=YOTA_NEXT.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk -f yotai.awk $FILE > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
