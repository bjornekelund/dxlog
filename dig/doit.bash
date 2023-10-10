#!/bin/bash
FILE=DIGLISTE.csv
OUTFILE=DIG_db.txt

echo Downloading $FILE

curl -sS https://diplom-interessen-gruppe.info/fileadmin/downloads/DIGLISTE.csv -o $FILE

echo "Parsing" $FILE

dos2unix -q $FILE

cat $FILE | sed 's/\"//g' | gawk -f dig.awk | sort | sed 's/=0*/=/g' | sed 's/^\#. /\# /g' > $OUTFILE

unix2dos -q $OUTFILE
echo Created $OUTFILE

exit
