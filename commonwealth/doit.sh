#!/bin/bash
INFILE=`ls RSGBBERU* | tail -1`
DBFILE=COMMONW_db.txt
XDTFILE=COMMONW.xdt

echo Parsing $INFILE...
dos2unix -q $INFILE

gawk -f txt.awk $INFILE | sort | sed 's/^\#0. /\# /g' > $DBFILE

unix2dos -q $DBFILE
echo Created $DBFILE

../copytosourcetree.sh $DBFILE

gawk -f xdt.awk $INFILE | sed 's/  / /g' | sort > $XDTFILE

unix2dos -q $XDTFILE $INFILE
cp $XDTFILE ../xdt
echo Created $XDTFILE

exit
