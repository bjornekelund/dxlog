#!/bin/bash
INFILECW=`ls ARRLDXC* | tail -1 2> /dev/null`
INFILESSB=`ls ARRLDXS* | tail -1 2> /dev/null`
OUTFILECW=ARRL_DX-CW_db.txt
OUTFILESSB=ARRL_DX-SSB_db.txt

echo Parsing $INFILECW
dos2unix -q $INFILECW

cat $INFILECW | sort | gawk -f arrldx.awk | sort | sed 's/^\#0. /\# /g' > $OUTFILECW

unix2dos -q $OUTFILECW $INFILECW
echo Created $OUTFILECW

../copytosourcetree.sh $OUTFILECW

echo ---

echo Parsing $INFILESSB
dos2unix -q $INFILESSB

cat $INFILESSB | sort | gawk -f arrldx.awk | sort | sed 's/^\#0. /\# /g' > $OUTFILESSB

unix2dos -q $OUTFILESSB $INFILESSB
echo Created $OUTFILESSB

../copytosourcetree.sh $OUTFILESSB

exit
