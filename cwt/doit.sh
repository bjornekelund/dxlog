#!/bin/bash
INFILE=$(ls CWOPS_* | tail -1 2> /dev/null)
DBFILE=CWT_db.txt
XDTFILE=CWOps.xdt

dos2unix -q $INFILE

echo Parsing $INFILE
gawk -f cwttxt.awk $INFILE | sort | sed 's/^\#0. /\# /g' > $DBFILE
echo Created $DBFILE
unix2dos -q $DBFILE

../_helpers/copytosourcetree.sh $DBFILE
../_helpers/uploaddb.sh $DBFILE

echo Parsing $INFILE
gawk -f cwtxdt.awk $INFILE | sed 's/  / /g' | sort > $XDTFILE
echo Created $XDTFILE
unix2dos -q $XDTFILE $INFILE

../_xdt/upload.sh $XDTFILE

exit 0
