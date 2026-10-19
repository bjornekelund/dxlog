#!/bin/bash

INFILECW=`ls SSCW* | tail -1 2> /dev/null`
OUTFILECW=ARRL_SS_CW_db.txt

echo Parsing $INFILECW
dos2unix -q $INFILECW
gawk -f arrlss.awk $INFILECW | sort | sed 's/^#0. /# /g' > $OUTFILECW

echo Created $OUTFILECW
unix2dos -q $OUTFILECW
../copytosourcetree.sh $OUTFILECW

exit
