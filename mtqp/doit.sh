#!/bin/bash
INFILE=$(ls ../naqpcw/NAQPC* | tail -1 2> /dev/null)
OUTFILE=MTQP_db.txt
HELPERS=../_helpers/helpers.awk

echo Parsing $INFILE
dos2unix -q $INFILE

gawk -f $HELPERS -f mtqp.awk $INFILE | sort | sed 's/^#0. /# /g' > $OUTFILE

unix2dos -q $OUTFILE $INFILE
echo Created $OUTFILE

../copytosourcetree.sh $OUTFILE

exit
