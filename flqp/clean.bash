#!/bin/bash
FILE=QSOP_FL-2023-007.txt
OUTFILE=QSOP_FL-2023-008.txt

dos2unix -q $FILE

gawk -f clean.awk $FILE > $OUTFILE

unix2dos -q $OUTFILE

exit
