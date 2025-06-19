#!/bin/bash
INFILE=DIGLISTE.csv
OUTFILE=DIG_db.txt

echo Downloading $INFILE

curl -sS https://diplom-interessen-gruppe.info/fileadmin/downloads/DIGLISTE.csv -o $INFILE

echo "Parsing" $INFILE

dos2unix -q $INFILE

cat $INFILE | sed 's/\"//g' | gawk -f dig.awk | sort | sed 's/=0*/=/g' | sed 's/^\#. /\# /g' > $OUTFILE

unix2dos -q $OUTFILE
echo Created $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
