#!/bin/bash
FILE=`ls cbjcall* | tail -1 2> /dev/null`
OUTFILE=JENIPAPO_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk -f jenipapo.awk $FILE > $OUTFILE

unix2dos -q $OUTFILE
echo Created $OUTFILE

exit
