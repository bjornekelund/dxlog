#!/bin/bash
FILE=`ls IOTA_2* | tail -1 2> /dev/null`
DBFILE=IOTA_db.txt
XDTFILE=IOTA.xdt

dos2unix -q $FILE

gawk -f txt.awk $FILE | sort | sed 's/#. /# /g' > $DBFILE

echo Created $DBFILE
unix2dos -q $DBFILE

gawk -f xdt.awk $FILE | sort > $XDTFILE

echo Created $XDTFILE
unix2dos -q $XDTFILE

cp $XDTFILE ../xdt

echo Parsed $FILE

exit
