#!/bin/bash

FILE=agb-list.txt
OUTFILE=AGB_db.txt

echo Downloading $FILE

wget -q http://ev5agb.com/club/agb-list.txt -O $FILE

dos2unix -q $FILE

gawk -f agb.awk $FILE | sort | sed 's/#. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
