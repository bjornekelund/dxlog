#!/bin/bash
INFILECW=`ls CQ160C* | tail -1 2> /dev/null`
INFILESSB=`ls CQ160S* | tail -1 2> /dev/null`
OUTFILECW=CQ160-CW_db.txt
OUTFILESSB=CQ160-SSB_db.txt
HELPERS=../1helpers/helpers.awk

echo Parsing $INFILECW
dos2unix -q $INFILECW

gawk -f $HELPERS -f cq160.awk  $INFILECW | sort | sed 's/^\#0. /\# /g' > $OUTFILECW

unix2dos -q $OUTFILECW $INFILECW
echo Created $OUTFILECW

../copytosourcetree.sh $OUTFILECW

echo ---

echo Parsing $INFILESSB
dos2unix -q $INFILESSB

gawk -f $HELPERS -f cq160.awk  $INFILESSB | sort | sed 's/^\#0. /\# /g' > $OUTFILESSB

unix2dos -q $OUTFILESSB $INFILESSB
echo Created $OUTFILESSB

../copytosourcetree.sh $OUTFILESSB

exit
