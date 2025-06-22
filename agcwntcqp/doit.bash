#!/bin/bash
INFILE=`ls AGCW-NTC*[0-9].txt | tail -1 2> /dev/null`
OUTFILE=AGCWNTCQP_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

cat $INFILE | sed 's/ü/u/g' |  sed 's/é/e/g' | gawk -f agcwntcqp.awk | sort | sed 's/#. /# /g' > $OUTFILE

unix2dos -q $OUTFILE $INFILE
echo Created $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
