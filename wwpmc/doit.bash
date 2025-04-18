#!/bin/bash
INFILE="WWPMC_2024.txt"
OUTFILE=WWPMC_db.txt

dos2unix -q $INFILE
echo "Parsing" $INFILE...

gawk -f wwpmc.awk $INFILE | sort | sed 's/^\#. /\# /g' > $OUTFILE

unix2dos -q $OUTFILE $INFILE
echo "Created" $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
