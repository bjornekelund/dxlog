#!/bin/bash
FILE=`ls Names_VE2FK* | tail -1 2> /dev/null`
OUTFILE=Opnames.xdt

echo Parsing $FILE
dos2unix -q $FILE

gawk -f names.awk $FILE | sort | sed 's/#. /# /g' > $OUTFILE

unix2dos -q $OUTFILE
echo Created $OUTFILE

cp $OUTFILE ../xdt

exit
