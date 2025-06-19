#!/bin/bash
FILECW=ss_cw.xdt
OUTFILECW=ARRL_SS_db.txt
FILESSB=ss_ssb.xdt
OUTFILESSB=ARRL_SS_SSB_db.txt

echo Parsing $FILECW
dos2unix -q $FILECW
gawk '{gsub(/  +/," "); sub(/^ /,""); sub(/ $/,"")}1' $FILECW | gawk -f arrlss.awk | sort | sed 's/#. /# /g' > $OUTFILECW
unix2dos -q $OUTFILECW
echo Created $OUTFILECW

echo Parsing $FILESSB
dos2unix -q $FILESSB
gawk '{gsub(/  +/," "); sub(/^ /,""); sub(/ $/,"")}1' $FILESSB | gawk -f arrlss.awk | sort | sed 's/#. /# /g' > $OUTFILESSB
unix2dos -q $OUTFILESSB
echo Created $OUTFILESSB



../../copytosourcetree.bash $OUTFILECW
../../copytosourcetree.bash $OUTFILESSB

exit
