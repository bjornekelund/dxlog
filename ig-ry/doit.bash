#!/bin/bash
#INFILE=`ls IG_WW* | tail -1 2> /dev/null`
INFILE1=IG_WW_RTTY-004.txt
INFILE2=`ls SCR* | tail -1 2> /dev/null`
OUTFILE=IG-RY_db.txt

echo Parsing $INFILE1 $INFILE2 ...
dos2unix -q $INFILE1 $INFILE2

gawk -f ig-ry.awk $INFILE1 $INFILE2 | sort | sed 's/^\#. /\# /g' > $OUTFILE

unix2dos -q $OUTFILE $INFILE1 $INFILE2
echo Created $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
