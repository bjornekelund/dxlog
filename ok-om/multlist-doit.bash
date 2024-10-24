#!/bin/bash
INFILE=multsfromweb.txt
OUTFILE=multlist.txt

dos2unix -q $INFILE

cat $INFILE | sort | sed 's/ - /\=/g' > $OUTFILE

unix2dos $OUTFILE
echo Created $OUTFILE

exit
