#!/bin/bash
FILE1=`ls UKEI80_V* | tail -1 2> /dev/null`
FILE2="20240823 UKEI80_db.txt"
OUTFILE=UKEI80_db.txt

echo Parsing $FILE1 $FILE2
dos2unix -q $FILE1 $FILE2

cat $FILE1 "$FILE2" | gawk -f ukeicc.awk $FILE | sort | sed 's/#. /# /g' > $OUTFILE

unix2dos -q $OUTFILE
echo Created $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
