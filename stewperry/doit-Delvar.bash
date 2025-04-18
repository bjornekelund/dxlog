#!/bin/bash
INFILE=`ls StewPerry[!_]* | tail -1 2> /dev/null`
OUTFILE=StewPerry_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

gawk -f stewperry.awk $INFILE | sort | sed 's/^#./#/g' > $OUTFILE

unix2dos -q $OUTFILE $INFILE
echo Created $OUTFILE

../copytosourcetree.bash $OUTFILE

cd ../tesla
./doit.bash

exit
