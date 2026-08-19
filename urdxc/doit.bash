#!/bin/bash
INFILE=UR-Contests_2021_DXLog.txt
OUTFILE=UR_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

gawk -f urdxc.awk $INFILE > $OUTFILE

unix2dos -q $OUTFILE $INFILE
echo Created $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
