#!/bin/bash
FILE=`ls WFD-2* | tail -1 2> /dev/null`
OUTFILE=WFD_db.txt

echo Parsing $FILE
dos2unix -q $FILE

cat $FILE | tr -d ' \t' | gawk -f wfd.awk | sort | sed 's/#. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
