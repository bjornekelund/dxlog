#!/bin/bash
FILE=`ls CWops_* | tail -1 2> /dev/null`
DBFILE=CWT_db.txt
XDTFILE=CWOps.xdt

echo Parsing $FILE
dos2unix -q $FILE

gawk -f txt.awk $FILE | sort | sed 's/^\#. /\# /g' > $DBFILE
echo $DBFILE "created"
unix2dos -q $DBFILE

gawk -f xdt.awk $FILE | sed 's/  / /g' | sort > $XDTFILE

echo $XDTFILE "created"
unix2dos -q $XDTFILE

cp $XDTFILE ../xdt

exit
