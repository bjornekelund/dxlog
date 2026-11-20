#!/bin/bash
INFILE=$(ls Names_VE2FK* | tail -1 2> /dev/null)
OUTFILEXDT=Opnames.xdt
OUTFILE=NAMES_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

gawk -f names-xdt.awk $INFILE | sort | sed 's/^#0. /# /g' > $OUTFILEXDT

unix2dos -q $OUTFILEXDT
echo Created $OUTFILEXDT

../_xdt/upload.sh $OUTFILEXDT

echo Parsing $INFILE

gawk -f names.awk $INFILE | sort | sed 's/^#0. /# /g' > $OUTFILE

unix2dos -q $OUTFILE $INFILE
echo Created $OUTFILE

../_helpers/copytosourcetree.sh $OUTFILE
../_helpers/uploaddb.sh $OUTFILE

exit 0
