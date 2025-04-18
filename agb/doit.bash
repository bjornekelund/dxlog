#!/bin/bash
INFILE=agb-list.txt
OUTFILE=AGB_db.txt

echo Downloading $INFILE

curl -sS http://ev5agb.com/club/agb-list.txt -o $INFILE

dos2unix -q $INFILE

gawk -f agb.awk $INFILE | sort | sed 's/#. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
