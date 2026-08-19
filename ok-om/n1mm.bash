#!/bin/bash
INFILE=OK-OM_db.txt
OUTFILE=OKOMDX.txt

dos2unix -q $INFILE

gawk -f n1mm.awk $INFILE > $OUTFILE

unix2dos -q $OUTFILE
echo Created $OUTFILE

exit
