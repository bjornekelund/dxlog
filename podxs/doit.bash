#!/bin/bash
INFILE=webclip.csv
OUTFILE=PODXS_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

gawk -f podxs.awk $INFILE | sort | sed 's/#. /# /g' > $OUTFILE

unix2dos -q $OUTFILE
echo Created $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
