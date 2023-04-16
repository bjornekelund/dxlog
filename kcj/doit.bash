#!/bin/bash
FILE=KCJ.txt
DBFILE=KCJ_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk -f kcj.awk $FILE | sort | sed 's/#. /# /g' > $DBFILE

echo Created $DBFILE
unix2dos -q $DBFILE

exit

