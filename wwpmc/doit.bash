#!/bin/bash
FILE="WWPMC.txt"
OUTFILE=WWPMC_db.txt

dos2unix -q $FILE
echo "Parsing" $FILE...

gawk -f wwpmc.awk $FILE | sort | sed 's/^\#. /\# /g' > $OUTFILE

echo "Created" $OUTFILE
unix2dos -q $OUTFILE
exit
