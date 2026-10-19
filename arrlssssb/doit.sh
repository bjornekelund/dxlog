#!/bin/bash
INFILESSB=`ls SSSSB* | tail -1 2> /dev/null`
OUTFILESSB=ARRL_SS_SSB_db.txt

echo Parsing $INFILESSB
dos2unix -q $INFILESSB
gawk -f arrlssssb.awk $INFILESSB | sort | sed 's/^#0. /# /g' > $OUTFILESSB

echo Created $OUTFILESSB
unix2dos -q $OUTFILESSB
../copytosourcetree.sh $OUTFILESSB

exit
