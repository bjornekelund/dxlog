#!/bin/bash
FILE=`ls ../JARTSWW* | tail -1 2> /dev/null`
OUTFILE=../JARLWWRTTY_NEXTYEAR.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk -f jarlwwr-inc.awk $FILE > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
