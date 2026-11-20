#!/bin/bash
INFILE2=ARRLCW_BOTH.XDT
INFILE1=ARRLSSB_BOTH.XDT
OUTFILE=ARRL_DX_db.txt

echo Parsing $INFILE1 $INFILE2
dos2unix -q $INFILE1 $INFILE2

cat $INFILE1 $INFILE2 | sort | gawk -f arrldx.awk | sort | sed 's/^\#0. /\# /g' > ARRL_DX_db.txt

echo $OUTFILE created
unix2dos -q $OUTFILE

../_helpers/copytosourcetree.sh $OUTFILE
../_helpers/uploaddb.sh $OUTFILE

exit 0
