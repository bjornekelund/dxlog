#!/bin/bash
INFILE1=`ls ../../cwt/CWOPS_* | tail -1 2> /dev/null`
INFILE2=`ls ../Names_VE2FK* | tail -1 2> /dev/null`
OUTFILE=CWOPEN.txt

echo Parsing $INFILE1 $INFILE2
dos2unix -q $INFILE1 $INFILE2

gawk -f docwopen.awk $INFILE1 $INFILE2 | sort > $OUTFILE

unix2dos -q $OUTFILE $INFILE1 $INFILE2
echo Created $OUTFILE

exit
