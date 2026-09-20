#!/bin/bash
FILE6=vhf_uhf_r1_db.txt
FILE4=vhf_uhf_r1_4_db.txt

OUTFILE6=../$FILE6
OUTFILE4=../$FILE4

# Create 6-position grid file

dos2unix -q $FILE6
echo Creating 6-position grid database by parsing $FILE6
gawk -f om6abf.awk $FILE6 | sort | sed 's/^\#0. /\# /g' > $OUTFILE6
echo $OUTFILE6 "created with" `cat $OUTFILE6 | wc -l` "calls"
unix2dos -q $OUTFILE6

# Create 4-position grid file

echo Creating 4-position grid database by parsing $FILE6
gawk -f om6abf4.awk $FILE6 | sort | sed 's/^\#0. /\# /g' > $OUTFILE4
echo $OUTFILE4 "created with" `cat $OUTFILE4 | wc -l` "calls"
unix2dos -q $FILE6 $OUTFILE4

cd ..
../copytosourcetree.sh vhf_uhf_r1_db.txt
../copytosourcetree.sh vhf_uhf_r1_4_db.txt

exit
