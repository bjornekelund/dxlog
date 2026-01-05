#!/bin/bash
FILE=urcdxrttycontest-list.txt
OUTFILE=regex-urcdxrtty.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk -f createregex.awk $FILE > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
