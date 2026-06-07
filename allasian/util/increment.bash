#!/bin/bash
FILE=`ls ../ALLASIACW_[^N]* | tail -1 2> /dev/null`
OUTFILE=../ALLASIACW_NEXTYEAR.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk -f allasian-inc.awk $FILE > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
