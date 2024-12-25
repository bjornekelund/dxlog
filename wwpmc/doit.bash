#!/bin/bash
FILE="WWPMC_2024.txt"
OUTFILE=WWPMC_db.txt

dos2unix -q $FILE
echo "Parsing" $FILE...

gawk -f wwpmc.awk $FILE | sort | sed 's/^\#. /\# /g' > $OUTFILE

echo "Created" $OUTFILE
unix2dos -q $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
