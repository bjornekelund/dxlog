#!/bin/bash
INFILE=RCWC.txt
OUTFILE=RCWC_db.txt

rm -f $INFILE
wget -q "https://rcwc.ru/?do=members&getlist=3" -O $INFILE

if [ ! -s $INFILE ]; then
    echo "ERROR! Download of $INFILE failed"
    exit 1
else
    echo Downloaded $INFILE, parsing...

    dos2unix -q $INFILE
    gawk -f rcwc.awk $INFILE | sort | sed 's/^\#. /\# /g' > $OUTFILE

    unix2dos -q $OUTFILE
    echo Created $OUTFILE

    ../copytosourcetree.bash $OUTFILE
fi
exit


exit
echo Parsing $INFILE
dos2unix -q $INFILE


echo Created $OUTFILE
unix2dos -q $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
