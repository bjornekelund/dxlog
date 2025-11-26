#!/bin/bash
# INFILE1 is newer and has precedence over INFILE2
INFILE1=Vidovdan_db.txt
INFILE2=YUREG_db_old.txt
OUTFILE=YUREG_db.txt

echo Parsing $INFILE1 $INFILE2 to create $OUTFILE
dos2unix -q $INFILE1 $INFILE2

cat $INFILE1 $INFILE2 | gawk -f yu.awk | sort | sed 's/^\#. /\# /g' > $OUTFILE

unix2dos -q $OUTFILE $INFILE1 $INFILE2
echo Created $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
