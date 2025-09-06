#!/bin/bash
FILE=multipliers-7qp.txt
OUTFILE=regex-7qp.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk -f do7qpregex.awk $FILE > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
