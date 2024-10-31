#!/bin/bash
FILECW=ss-cw.xdt
OUTFILECW=ARRL_SS_db.txt

echo Parsing $FILECW

dos2unix -q $FILECW

gawk '{gsub(/  +/," "); sub(/^ /,""); sub(/ $/,"")}1' $FILECW | gawk -f arrlss.awk | sort | sed 's/#. /# /g' > $OUTFILECW

unix2dos -q $OUTFILECW

echo Created $OUTFILECW

../../copytosourcetree.bash $OUTFILECW

exit
