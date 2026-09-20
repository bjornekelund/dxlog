#!/bin/bash
INFILE1=`ls ../rdac/huge/RDAC_huge_csv* | tail -1 2> /dev/null`
INFILE2=`ls UA2QP* | tail -1 2> /dev/null`
OUTFILE=UA2_QP_db.txt

echo Parsing $INFILE1 $INFILE2
dos2unix -q $INFILE1 $INFILE2

gawk -f ua2qp.awk $INFILE1 $INFILE2 | sort | sed 's/^#0. /# /g' > $OUTFILE

unix2dos -q $OUTFILE $INFILE1 $INFILE2
echo Created $OUTFILE

../copytosourcetree.sh $OUTFILE

exit
