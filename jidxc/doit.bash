#!/bin/bash
INFILE=JIDXC.txt
OUTFILE=JIDXC_db.txt

echo Downloading $INFILE

curl -sS http://jidx.org/jidx-hist.txt -o $INFILE

dos2unix -q $INFILE

gawk -f jidxc.awk $INFILE | sort | sed 's/#. /# /g' > $OUTFILE

unix2dos -q $OUTFILE
echo Created $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
