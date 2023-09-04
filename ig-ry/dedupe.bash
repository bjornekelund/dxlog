#!/bin/bash

OUTFILE=SCRY_2024-003.txt
FILE=SCRY_2024-002.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk -f dedupe.awk $FILE | sort | sed 's/^\#. /\# /g' > $OUTFILE

unix2dos -q $OUTFILE
echo Created $OUTFILE

exit
