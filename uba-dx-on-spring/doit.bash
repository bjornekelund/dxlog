#!/bin/bash
FILE="Fullcall.txt Vanitycall.txt"
#FILE="Fullcall.txt"
OUTFILE=UBA_Sections_db.txt

echo Parsing $FILE
dos2unix -q $FILE

cat $FILE | gawk -f uba-dx-on-spring.awk | sort | sed 's/^\#. /\# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
