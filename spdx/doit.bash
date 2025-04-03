#!/bin/bash

FILE=`ls SPDX*[0-9]* | tail -1 2> /dev/null`
OUTFILE=SPDX_db.txt

dos2unix -q $FILE
echo Parsing $FILE

gawk -f spdx.awk $FILE | sed 's/^\#. /\# /g' > $OUTFILE

unix2dos -q $OUTFILE
echo Created $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
