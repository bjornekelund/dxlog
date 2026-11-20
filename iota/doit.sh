#!/bin/bash
INFILE=$(ls IOTA_2* | tail -1 2> /dev/null)
DBFILE=IOTA_db.txt
XDTFILE=IOTA.xdt

echo Parsing $INFILE

dos2unix -q $INFILE

gawk -f txt.awk $INFILE | sort | sed 's/^#0. /# /g' > $DBFILE

unix2dos -q $DBFILE
echo Created $DBFILE

../_helpers/copytosourcetree.sh $DBFILE
../_helpers/uploaddb.sh $DBFILE

gawk -f xdt.awk $INFILE | sort > $XDTFILE

unix2dos -q $XDTFILE $INFILE
echo Created $XDTFILE

../_xdt/upload.sh $XDTFILE

exit 0
