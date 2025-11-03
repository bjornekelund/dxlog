#!/bin/bash
INFILE=vhf_uhf_r1_db.txt

OUTFILE=../vhf_uhf_r1_db.txt

dos2unix -q $INFILE

echo Creating 6-position grid database by parsing $INFILE

# Create 6-position grid file

gawk -f om6abf.awk $INFILE | sort | sed 's/^\#. /\# /g' > $OUTFILE

echo $OUTFILE "created with" `cat $OUTFILE | wc -l` "calls"

unix2dos -q $OUTFILE

cd ..
../copytosourcetree.bash vhf_uhf_r1_db.txt

exit
