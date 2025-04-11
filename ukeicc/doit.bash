#!/bin/bash
INFILE1=`ls UKEI80_V* | tail -1 2> /dev/null`
INFILE2="20240823 UKEI80_db.txt"
OUTFILE=UKEI80_db.txt

echo Parsing $INFILE1 $INFILE2
dos2unix -q $INFILE1 $INFILE2

cat $INFILE1 "$INFILE2" | gawk -f ukeicc.awk $INFILE | sort | sed 's/#. /# /g' > $OUTFILE

unix2dos -q $OUTFILE
echo Created $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
