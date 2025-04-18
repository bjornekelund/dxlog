#!/bin/bash
INFILE=`ls ../stewperry/StewPerry-* | tail -1`
OUTFILE=TESLA_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

gawk -f tesla.awk $INFILE | sort | sed 's/^\#. /\# /g' > $OUTFILE

unix2dos -q $OUTFILE
echo Created $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
