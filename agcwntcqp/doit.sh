#!/bin/bash
QPFILE=$(ls AGCW-NTC*[0-9].txt | tail -1 2> /dev/null)
OUTFILE=AGCWNTCQP_db.txt

echo Parsing $QPFILE
dos2unix -q $QPFILE

echo Creating $OUTFILE

gawk -f agcwntcqp.awk -f ../1helpers/helpers.awk $QPFILE | sort | sed 's/^#0. /# /g' > $OUTFILE

unix2dos -q $OUTFILE

../copytosourcetree.sh $OUTFILE

rm -f $TEMP1 $TEMP2 $TEMP3
exit
