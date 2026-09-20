#!/bin/bash
FILECW=ss_cw.xdt
OUTFILECW=ARRL_SS.txt
FILESSB=ss_ssb.xdt
OUTFILESSB=ARRL_SS_SSB.txt

echo Parsing $FILECW
dos2unix -q $FILECW
gawk '{gsub(/  +/," "); sub(/^ /,""); sub(/ $/,"")}1' $FILECW | gawk -f n1mmarrlss.awk | sort | sed 's/#0./#/g' > $OUTFILECW
unix2dos -q $OUTFILECW
echo Created $OUTFILECW

echo Parsing $FILESSB
dos2unix -q $FILESSB
gawk '{gsub(/  +/," "); sub(/^ /,""); sub(/ $/,"")}1' $FILESSB | gawk -f n1mmarrlss.awk | sort | sed 's/#0./#/g' > $OUTFILESSB
unix2dos -q $OUTFILESSB
echo Created $OUTFILESSB

    exit
