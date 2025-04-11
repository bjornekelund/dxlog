#!/bin/bash
#FILE=UBASSB*.txt
INFILE="Fullcall.txt Vanitycall.txt"
OUTFILE=UBA_Sections_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

sed 's/,/=/g' $INFILE | gawk -f uba-dx-on-spring.awk | sort | sed 's/^\#. /\# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
