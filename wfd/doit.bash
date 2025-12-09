#!/bin/bash

INFILE1=`ls WFD-2* | tail -1 2> /dev/null`
INFILE2=`ls WFD_2* | tail -1 2> /dev/null`
OUTFILE=WFD_db.txt

echo Parsing $INFILE1 and $INFILE2 to create $OUTFILE
dos2unix -q $INFILE1 $INFILE2

cat $INFILE1 $INFILE2 | tr -d ' \t' | gawk -f wfd.awk | sort | sed 's/#. /# /g' > $OUTFILE

unix2dos -q $OUTFILE $INFILE1 $INFILE2
echo Created $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
