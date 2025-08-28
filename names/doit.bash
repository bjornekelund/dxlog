#!/bin/bash
INFILE=`ls Names_VE2FK* | tail -1 2> /dev/null`
OUTFILEXDT=Opnames.xdt
OUTFILE=NAMES_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

gawk -f names-xdt.awk $INFILE | sort | sed 's/#. /# /g' > $OUTFILEXDT

unix2dos -q $OUTFILEXDT
echo Created $OUTFILEXDT

cp $OUTFILEXDT ../xdt

gawk -f names.awk $INFILE | sort | sed 's/#. /# /g' > $OUTFILE

unix2dos -q $OUTFILE $INFILE
echo Created $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
