#!/bin/bash
FILE=`ls Names_VE2FK* | tail -1 2> /dev/null`

echo Parsing $FILE
dos2unix -q $FILE

gawk -f names.awk $FILE | sort | sed 's/#. /# /g' > Opnames.xdt

unix2dos -q Opnames.xdt
echo Created Opnames.xdt

exit
