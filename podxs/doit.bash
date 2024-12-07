#!/bin/bash
FILE=webclip.csv
OUTFILE=PODXS_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk -f podxs.awk $FILE | sort | sed 's/#. /# /g' > $OUTFILE

unix2dos -q $OUTFILE
echo Created $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
