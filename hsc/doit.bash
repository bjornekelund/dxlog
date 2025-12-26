#!/bin/bash
DBFILE=HSC_db.txt
XDTFILE=hsc.xdt

rm -f $XDTFILE
curl -s https://hsc.dj1yfk.de/db/hsc.xdt --output $XDTFILE
unix2dos -q $XDTFILE

if [ ! -s "$XDTFILE" ]; then
    echo "ERROR! $XDTFILE download failed"
    exit 1
else
    echo "Downloaded $XDTFILE"
    cp $XDTFILE ../xdt
fi

rm -f $DBFILE
curl -s https://hsc.dj1yfk.de/db/HSC_db.txt --output $DBFILE
unix2dos -q $DBFILE

if [ ! -s "$DBFILE" ]; then
    echo "ERROR! $DBFILE download failed"
    exit 1
else
    echo "Downloaded $DBFILE"
    ../copytosourcetree.bash $DBFILE
fi

exit
