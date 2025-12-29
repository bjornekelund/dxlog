#!/bin/bash
#FILE=UBASSB*.txt
INFILE1=Fullcall.txt
INFILE2=Vanitycall.txt
OUTFILE=UBA_Sections_db.txt

echo Parsing $INFILE1 and $INFILE2
dos2unix -q $INFILE1 $INFILE2
sed 's/,/=/g' $INFILE1 $INFILE2 | gawk -f uba-dx-on-spring.awk | sort | sed 's/^\#. /\# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
