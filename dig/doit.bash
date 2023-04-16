#!/bin/bash
FILE=DIGLISTE.csv
OUTFILE=DIG_db.txt

echo Downloading $FILE

wget -q https://diplom-interessen-gruppe.info/fileadmin/downloads/DIGLISTE.csv -O $FILE

echo "Parsing" $FILE

dos2unix -q $FILE

cat $FILE | sed 's/\"//g' | gawk -f dig.awk | sort | sed 's/=0*/=/g' | sed 's/^\#. /\# /g' > $OUTFILE

unix2dos -q $OUTFILE
echo Created $OUTFILE

exit
