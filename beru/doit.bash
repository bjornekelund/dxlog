#!/bin/bash
FILE=`ls RSGBBERU* | tail -1`
DBFILE=BERU_db.txt
XDTFILE=BERU.xdt

echo Parsing $FILE...
dos2unix -q $FILE

gawk -f txt.awk $FILE | sort | sed 's/^\#. /\# /g' > $DBFILE

echo Created $DBFILE
unix2dos -q $DBFILE

../copytosourcetree.bash $DBFILE

gawk -f xdt.awk $FILE | sed 's/  / /g' | sort > $XDTFILE

echo Created $XDTFILE
unix2dos -q $XDTFILE

exit
