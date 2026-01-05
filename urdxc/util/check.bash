#!/bin/bash
INFILE=UR-Contests_2021_DXLog.txt
OUTFILE=result.txt

echo Parsing $INFILE
dos2unix -q $INFILE

gawk -f check.awk $INFILE > $OUTFILE

unix2dos -q $OUTFILE $INFILE
echo Created $OUTFILE

exit
