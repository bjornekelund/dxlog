#!/bin/bash
FILE=`ls AC* 2> /dev/null`
OUTFILE=POLAR-radioman.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk -f polar-radioman.awk $FILE > $OUTFILE

unix2dos -q $OUTFILE
echo Created $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
