#!/bin/bash

if ../1helpers/download.sh SSCW || [ -n "$1" ]; then
    INFILECW=`ls SSCW* | tail -1 2> /dev/null`
    OUTFILECW=ARRL_SS_CW_db.txt

    echo Parsing $INFILECW
    dos2unix -q $INFILECW
    gawk -f arrlss.awk $INFILECW | sort | sed 's/^#0. /# /g' > $OUTFILECW

    echo Created $OUTFILECW
    unix2dos -q $OUTFILECW
    ../copytosourcetree.sh $OUTFILECW
fi

if ../1helpers/download.sh SSSSB || [ -n "$1" ]; then
    echo ---
    INFILESSB=`ls SSSSB* | tail -1 2> /dev/null`
    OUTFILESSB=ARRL_SS_SSB_db.txt

    echo Parsing $INFILESSB
    dos2unix -q $INFILESSB
    gawk -f arrlss.awk $INFILESSB | sort | sed 's/^#0. /# /g' | sed 's/ARRL CW/ARRL SSB/g' > $OUTFILESSB

    echo Created $OUTFILESSB
    unix2dos -q $OUTFILESSB
    ../copytosourcetree.sh $OUTFILESSB
fi

# cd ../fistsspr; ./doit.sh
# cd ../arrlrr; ./doit.sh

echo ---


exit
