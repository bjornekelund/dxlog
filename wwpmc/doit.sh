#!/bin/bash
INFILE=$(ls WWPMC_2* | tail -1 2> /dev/null)
OUTFILE=WWPMC_db.txt

dos2unix -q $INFILE
echo "Parsing" $INFILE...

gawk -f wwpmc.awk $INFILE | sort | sed 's/^\#0. /\# /g' > $OUTFILE

unix2dos -q $OUTFILE $INFILE
echo "Created" $OUTFILE

../_helpers/copytosourcetree.sh $OUTFILE
../_helpers/uploaddb.sh $OUTFILE

exit 0
