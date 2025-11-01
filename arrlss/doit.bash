#!/bin/bash
INFILECW=`ls SSCW* | tail -1 2> /dev/null`
INFILESSB=`ls SSSSB* | tail -1 2> /dev/null`

OUTFILECW=ARRL_SS_db.txt
OUTFILESSB=ARRL_SS_SSB_db.txt

if [ -e $INFILECW ]; then
    echo Parsing $INFILECW
    dos2unix -q $INFILECW
    gawk -f arrlss.awk $INFILECW | sort | sed 's/#. /# /g' > $OUTFILECW
    echo Created $OUTFILECW
    unix2dos -q $OUTFILECW
    ../copytosourcetree.bash $OUTFILECW
fi

if [ -e $INFILESSB ]; then
    echo Parsing $INFILESSB
    dos2unix -q $INFILESSB
    gawk -f arrlss.awk $INFILECW | sort | sed 's/#. /# /g' | sed 's/ARRL CW/ARRL SSB/g' > $OUTFILESSB
    echo Created $$OUTFILESSB
    unix2dos -q $OUTFILESSB
    ../copytosourcetree.bash $OUTFILESSB
fi

exit
