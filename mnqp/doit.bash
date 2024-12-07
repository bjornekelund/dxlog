#!/bin/bash
FILE=`ls QSOP_* | tail -1 2> /dev/null`
OUTFILE=MNQP_db.txt

echo Parsing $FILE
dos2unix -q $FILE

sed 's/ //g' $FILE | gawk -f mnqp.awk | sort | sed 's/#. /# /g' > $OUTFILE

echo "Created" $OUTFILE
unix2dos -q $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
