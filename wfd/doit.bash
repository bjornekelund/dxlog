#!/bin/bash
INFILE=`ls WFD_2* | tail -1 2> /dev/null`
OUTFILE=WFD_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

cat $INFILE | tr -d ' \t' | gawk -f wfd.awk | sort | sed 's/#. /# /g' > $OUTFILE

unix2dos -q $OUTFILE $INFILE
echo Created $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
