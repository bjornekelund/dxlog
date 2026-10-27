#!/bin/bash
INFILECW=$(ls ARRLDXC* | tail -1 2> /dev/null)
OUTFILECW=ARRL_DX-CW_db.txt

echo Parsing $INFILECW
dos2unix -q $INFILECW

cat $INFILECW | sort | gawk -f arrldx.awk | sort | sed 's/^\#0. /\# /g' > $OUTFILECW

unix2dos -q $OUTFILECW $INFILECW
echo Created $OUTFILECW

../copytosourcetree.sh $OUTFILECW

exit
