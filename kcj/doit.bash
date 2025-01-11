#!/bin/bash
FILE=KCJ.txt
OUTFILE=KCJ_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk -f kcj.awk $FILE | sort | sed 's/#. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

../copytosourcetree.bash $OUTFILE

exit

