#!/bin/bash
FILE=RDAC_2022.txt
OUTFILE=RDAC_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk -f rdac.awk $FILE | sort | sed 's/#. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
