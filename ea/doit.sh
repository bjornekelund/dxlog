#!/bin/bash
# File 2 should be the newer
#INFILE1=`ls CNCW* | tail -1 2> /dev/null`
INFILE2=`ls KING* | tail -1 2> /dev/null`
OUTFILE=EA_db.txt

#echo Parsing $INFILE1 and $INFILE2
echo Parsing $INFILE2
#dos2unix -q $INFILE1 $INFILE2
dos2unix -q $INFILE1 $INFILE2

cat $INFILE2 | sed 's/ //g' | gawk -f ea.awk | sort | sed 's/^#0. /# /g' > $OUTFILE

unix2dos -q $OUTFILE $INFILE2
echo Created $OUTFILE

../copytosourcetree.sh $OUTFILE

exit
