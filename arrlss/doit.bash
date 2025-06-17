#!/bin/bash
INFILECW=`ls SSCW* | tail -1 2> /dev/null`
INFILESSB=`ls SSSSB* | tail -1 2> /dev/null`

OUTFILECW=ARRL_SS_db.txt
OUTFILESSB=ARRL_SS_SSB_db.txt

echo Parsing $INFILECW
dos2unix -q $INFILECW
gawk -f arrlss.awk $INFILECW | sort | sed 's/#. /# /g' > $OUTFILECW

echo Parsing $INFILESSB
dos2unix -q $INFILESSB
gawk -f arrlss.awk $INFILECW | sort | sed 's/#. /# /g' | sed 's/ARRL CW/ARRL SSB/g' > $OUTFILESSB

echo Created $OUTFILECW and $OUTFILESSB
unix2dos -q $OUTFILECW $OUTFILESSB

../copytosourcetree.bash $OUTFILECW
../copytosourcetree.bash $OUTFILESSB

exit
