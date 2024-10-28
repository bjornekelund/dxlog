#!/bin/bash
FILECW=`ls SSCW* | tail -1 2> /dev/null`
FILESSB=`ls SSSSB* | tail -1 2> /dev/null`

OUTFILECW=ARRL_SS_db.txt
OUTFILESSB=ARRL_SS_SSB_db.txt

echo Parsing $FILECW
dos2unix -q $FILECW
gawk -f arrlss.awk $FILECW | sort | sed 's/#. /# /g' > $OUTFILECW

echo Parsing $FILESSB
dos2unix -q $FILESSB
gawk -f arrlss.awk $FILECW | sort | sed 's/#. /# /g' | sed 's/ARRL CW/ARRL SSB/g' > $OUTFILESSB

echo Created $OUTFILECW and $OUTFILESSB
unix2dos -q $OUTFILECW $OUTFILESSB

../copytosourcetree.bash $OUTFILECW
../copytosourcetree.bash $OUTFILESSB

exit
