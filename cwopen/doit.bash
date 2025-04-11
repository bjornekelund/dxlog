#!/bin/bash
#FILE=`ls CWOPS* | tail -1 2> /dev/null`
INFILE=`ls CWOPSOPEN_2024-* | tail -1 2> /dev/null`
OUTFILE=CWOpen_db.txt
XDTFILE=CWOpen.xdt


dos2unix -q $INFILE

echo Parsing $INFILE
gawk -f txt.awk $INFILE | sort | sed 's/#. /# /g' > $OUTFILE
unix2dos -q $OUTFILE
echo Created $OUTFILE

../copytosourcetree.bash $OUTFILE

echo

echo Parsing $INFILE
gawk -f xdt.awk $INFILE | sed 's/  / /g' | sort > $XDTFILE
echo Created $XDTFILE
unix2dos -q $XDTFILE $INFILE
cp $XDTFILE ../xdt

exit
