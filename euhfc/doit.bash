#!/bin/bash
FILE=`ls EUHFC[^_]* | tail -1 2> /dev/null`
OUTFILE=EUHFC_db.txt

echo Parsing $FILE
dos2unix -q $FILE

tr -d ' ' < $FILE | gawk -f euhfc.awk | sort | sed 's/^\#. /\# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
