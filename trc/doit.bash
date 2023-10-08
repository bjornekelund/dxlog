#!/bin/bash
FILE=`ls TRCDX* | tail -1 2> /dev/null`
DBFILE=TRC_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk -f trc.awk $FILE | sort | sed 's/^\#. /\# /g' > $DBFILE

echo Created $DBFILE
unix2dos -q $DBFILE

exit
