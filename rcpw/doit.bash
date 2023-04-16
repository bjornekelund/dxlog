#!/bin/bash
FILE=raw.txt
OUTFILE=RCPW_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk -f rcpw.awk $FILE > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
