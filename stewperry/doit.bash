#!/bin/bash
FILE=`ls StewPerry[!_]* | tail -1 2> /dev/null`
OUTFILE=StewPerry_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk -f stewperry.awk $FILE | sort | sed 's/^#./#/g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

../copytosourcetree.bash $OUTFILE

cd ../tesla
./doit.bash

exit
