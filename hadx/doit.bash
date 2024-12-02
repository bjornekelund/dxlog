#!/bin/bash
FILE=HADX.txt
OUTFILE=HADX_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk -f hadx.awk $FILE | sort | sed 's/^\#. /\# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q HADX_db.txt

../copytosourcetree.bash $OUTFILE

exit
