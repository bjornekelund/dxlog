#!/bin/bash
FILE=`ls QSOP_OH* | tail -1 2> /dev/null`

echo Parsing $FILE
dos2unix -q $FILE

gawk -f ohqp.awk $FILE | sort | sed 's/#. /# /g' > OHQP_db.txt

echo Created OHQP_db.txt
unix2dos -q OHQP_db.txt

exit
