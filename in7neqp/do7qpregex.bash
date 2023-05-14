#!/bin/bash
FILE=7qp_abrv.txt
OUTFILE=regex-7qp.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk -f do7qpregex.awk $FILE > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
