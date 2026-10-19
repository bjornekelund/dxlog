#!/bin/bash
echo ---
INFILESSB=`ls ARRLDXS* | tail -1 2> /dev/null`
OUTFILESSB=ARRL_DX-SSB_db.txt

echo Parsing $INFILESSB
dos2unix -q $INFILESSB

cat $INFILESSB | sort | gawk -f arrldx.awk | sort | sed 's/^\#0. /\# /g' > $OUTFILESSB

unix2dos -q $OUTFILESSB $INFILESSB
echo Created $OUTFILESSB

../copytosourcetree.sh $OUTFILESSB

exit
