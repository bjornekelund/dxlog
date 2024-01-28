#!/bin/bash
FILE=`ls Names_VE2FK* | tail -1 2> /dev/null`
OUTFILEXDT=Opnames.xdt
OUTFILE=NAMES_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk -f names-xdt.awk $FILE | sort | sed 's/#. /# /g' > $OUTFILEXDT

unix2dos -q $OUTFILEXDT
echo Created $OUTFILEXDT

cp $OUTFILEXDT ../xdt

gawk -f names.awk $FILE | sort | sed 's/#. /# /g' > $OUTFILE

unix2dos -q $OUTFILE
echo Created $OUTFILE

exit
