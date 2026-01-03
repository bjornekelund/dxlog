#!/bin/bash
# INFILE1 is newer and has precedence over INFILE2
INFILE1=Vidovdan_db.txt
INFILE2=YUREG_db_old.txt
OUTFILE=YUREG_db.txt

echo Parsing $INFILE2 and $INFILE1 to create $OUTFILE
dos2unix -q $INFILE2 $INFILE1

cat $INFILE2 $INFILE1 | gawk -f yu.awk | sort | sed 's/^\#0. /\# /g' > $OUTFILE

unix2dos -q $OUTFILE $INFILE1 $INFILE2
echo Created $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
