#!/bin/bash
FILE=FRPHF-001.txt
#FILE=`ls FRPHF[^_]* | tail -1 2> /dev/null`
OUTFILE=FRPHF_db.txt

echo Parsing $FILE
dos2unix -q $FILE

cat $FILE | gawk -f frphf.awk | sort | sed 's/#. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
