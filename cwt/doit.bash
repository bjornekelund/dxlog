#!/bin/bash
INFILE=`ls CWOPS_* | tail -1 2> /dev/null`
DBFILE=CWT_db.txt
XDTFILE=CWOps.xdt

dos2unix -q $INFILE

gawk -f txt.awk $INFILE | sort | sed 's/^\#0. /\# /g' > $DBFILE
echo Created $DBFILE
unix2dos -q $DBFILE

gawk -f xdt.awk $INFILE | sed 's/  / /g' | sort > $XDTFILE
echo Created $XDTFILE
unix2dos -q $XDTFILE $INFILE

cp $XDTFILE ../xdt

../copytosourcetree.bash $DBFILE

exit
