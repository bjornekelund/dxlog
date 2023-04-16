#!/bin/bash
FILE=SPDXRTTY_KP.txt
OUTFILE=SPDXRTTY_db.txt

dos2unix -q $FILE

gawk -f spdx-rtty.awk $FILE | sort | sed 's/^\#. /\# /g' > $OUTFILE

unix2dos -q $OUTFILE
echo Created $OUTFILE

exit
