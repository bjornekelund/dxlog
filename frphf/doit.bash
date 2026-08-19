#!/bin/bash
INFILE=`ls FRPHF[^_]* | tail -1 2> /dev/null`
OUTFILE=FRPHF_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

cat $INFILE | gawk -f frphf.awk | sort | sed 's/^#0. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
