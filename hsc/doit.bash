#!/bin/bash
DBFILE=HSC_db.txt
XDTFILE=hsc.xdt

rm -f $XDTFILE
curl -s https://hsc.dj1yfk.de/db/$XDTFILE -O
unix2dos -q $XDTFILE

if [ ! -s $XDTFILE ]; then
    echo "ERROR! Download of $XDTFILE failed. Aborting."
    exit 1
else
    echo "Downloaded $XDTFILE"
    cp $XDTFILE ../xdt
fi

rm -f $DBFILE
curl -s https://hsc.dj1yfk.de/db/$DBFILE -O
unix2dos -q $DBFILE

if [ ! -s $DBFILE ]; then
    echo "ERROR! Download of $DBFILE failed. Aborting."
    exit 1
else
    echo "Downloaded $DBFILE"
    ../copytosourcetree.bash $DBFILE
fi

exit
