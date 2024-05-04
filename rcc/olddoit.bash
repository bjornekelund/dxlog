#!/bin/bash
OUTFILE=RCC_db.txt

dos2unix -q $1
echo Parsing $1

gawk -f oldrcc.awk $1 > $OUTFILE

unix2dos $OUTFILE
echo Created $OUTFILE

exit
