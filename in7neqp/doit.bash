#!/bin/bash
FILE=`ls QSOP* | tail -1 2> /dev/null`
OUTFILE=IN7NEQP_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk -f in7neqp.awk $FILE | sort | sed 's/^#[0-9]/#/g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
