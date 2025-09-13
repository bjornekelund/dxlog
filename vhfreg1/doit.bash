#!/bin/bash
INFILE=`ls clean/VHFREG1-* | tail -1 2> /dev/null`
INFILE4=`ls clean/VHFREG1_4-* | tail -1 2> /dev/null`

OUTFILE=vhf_uhf_r1_db.txt
OUTFILE4=vhf_uhf_r1_4_db.txt

cd clean
./clean.bash
cd ..

dos2unix -q $INFILE $INFILE4

echo Creating 6-position grid database by parsing $INFILE

# Create 6-position grid file

gawk -f grid6.awk $INFILE | sort | sed 's/^\#. /\# /g' > $OUTFILE

echo $OUTFILE "created with" `cat $OUTFILE | wc -l` "calls"

echo  Creating 4-position grid database by parsing $INFILE4

gawk -f grid4.awk $INFILE4 | sort | sed 's/^\#. /\# /g' > $OUTFILE4

echo $OUTFILE4 created with `cat $OUTFILE4 | wc -l` calls

unix2dos -q $OUTFILE $OUTFILE4

../copytosourcetree.bash $OUTFILE
../copytosourcetree.bash $OUTFILE4

exit
