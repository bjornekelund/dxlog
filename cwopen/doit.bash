#!/bin/bash
FILE=`ls CWOPS* | tail -1 2> /dev/null`
OUTFILE=CWOpen_db.txt
XDTFILE=CWOpen.xdt


dos2unix -q $FILE

echo Parsing $FILE
gawk -f txt.awk $FILE | sort | sed 's/#. /# /g' > $OUTFILE
unix2dos -q $OUTFILE
echo Created $OUTFILE

echo

echo Parsing $FILE
gawk -f xdt.awk $FILE | sed 's/  / /g' | sort > $XDTFILE
echo Created $XDTFILE
unix2dos -q $XDTFILE

exit
