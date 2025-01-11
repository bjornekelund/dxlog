#!/bin/bash
FILE=`ls LZDX-2* | tail -1 2> /dev/null`
OUTFILE=LZDX_db.txt

dos2unix -q $FILE
echo Parsing $FILE...

gawk -f lzdx.awk $FILE | sort | sed 's/#. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

rm -rf $OLDTEMP

../copytosourcetree.bash $OUTFILE

exit
