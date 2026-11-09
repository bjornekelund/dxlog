#!/bin/bash
FILECW=SS_CW.xdt
OUTFILECW=ARRL_SS_CW_db.txt
FILESSB=SS_SSB.xdt
OUTFILESSB=ARRL_SS_SSB_db.txt

echo Parsing $FILECW
dos2unix -q $FILECW
gawk '{gsub(/  +/," "); sub(/^ /,""); sub(/ $/,"")}1' $FILECW | gawk -f arrlss.awk | sort | sed 's/^#0. /# /g' > $OUTFILECW
unix2dos -q $OUTFILECW
echo Created $OUTFILECW

echo Parsing $FILESSB
dos2unix -q $FILESSB
gawk '{gsub(/  +/," "); sub(/^ /,""); sub(/ $/,"")}1' $FILESSB | gawk -f arrlss.awk | sort | sed 's/^#0. /# /g' > $OUTFILESSB
unix2dos -q $OUTFILESSB
echo Created $OUTFILESSB

../../copytosourcetree.sh $OUTFILECW
../../copytosourcetree.sh $OUTFILESSB

exit
