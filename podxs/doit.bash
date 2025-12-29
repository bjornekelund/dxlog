#!/bin/bash
INFILE=data.csv
OUTFILE=PODXS_db.txt

curl -sS "https://docs.google.com/spreadsheets/d/1s7RS8T4twf4-hNsI5uiGEsTiUnqQ51xU1Lne5B5GIUI/gviz/tq?tqx=out:csv&sheet=Member_shortlist" -o $INFILE

echo Parsing $INFILE
dos2unix -q $INFILE

sed 's/\"//g' $INFILE | gawk -f podxs.awk | sort | sed 's/#. /# /g' > $OUTFILE

unix2dos -q $OUTFILE
echo Created $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
