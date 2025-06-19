#!/bin/bash
INFILE=`ls CWOPS_* | tail -1 2> /dev/null`
DBFILE=CWT_db.txt
XDTFILE=CWOps.xdt

echo Parsing $INFILE
dos2unix -q $INFILE

gawk -f txt.awk $INFILE | sort | sed 's/^\#. /\# /g' > $DBFILE
echo Created $DBFILE
unix2dos -q $DBFILE $INFILE

gawk -f xdt.awk $INFILE | sed 's/  / /g' | sort > $XDTFILE

unix2dos -q $XDTFILE $INFILE
echo Created $XDTFILE

cp $XDTFILE ../xdt

../copytosourcetree.bash $DBFILE

exit
