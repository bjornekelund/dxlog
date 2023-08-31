#!/bin/bash
#FILE=`ls CWOPS* | tail -1 2> /dev/null`
FILE1=CWOPSOPEN_2023-002.txt
FILE2=Names_VE2FK-046.txt
OUTFILE=CWOPSOPEN_2023_003.txt

echo Parsing $FILE1 $FILE2

dos2unix -q $FILE1 $FILE2

cat $FILE1 $FILE2 | awk '{if ($0 !~ /^(!|#|$)/) printf("%s\n", $0);}' | sort > temp1.txt

exit

echo Parsing $FILE1 $FILE2
gawk -f txt.awk $FILE | sort | sed 's/#. /# /g' > $OUTFILE
unix2dos -q $OUTFILE
echo Created $OUTFILE

echo

echo Parsing $FILE
gawk -f xdt.awk $FILE | sed 's/  / /g' | sort > $XDTFILE
echo Created $XDTFILE
unix2dos -q $XDTFILE
cp $XDTFILE ../xdt

exit
