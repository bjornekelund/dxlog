#!/bin/bash
INFILE=JIDXCW*.txt
OUTFILE=JIDXC_db.txt

dos2unix -q $INFILE

gawk -f jidxc.awk $INFILE | sort | sed 's/#. /# /g' > $OUTFILE

unix2dos -q $OUTFILE
echo Created $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
