#!/bin/bash
INFILE=`ls QSOP* | tail -1 2> /dev/null`
OUTFILE=IN7NEQP_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

gawk -f in7neqp.awk $INFILE | sort | sed 's/^#[0-9]/#/g' > $OUTFILE

unix2dos -q $OUTFILE $INFILE
echo Created $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
