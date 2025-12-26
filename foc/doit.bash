#!/bin/bash
DBFILE=FOC_db.txt
XDTFILE=foc.xdt

rm -f $XDTFILE
curl -s https://foc.telegraphy.de/db/foc.xdt --output $XDTFILE
unix2dos -q $XDTFILE

if [ ! -s "$XDTFILE" ]; then
    echo "ERROR! $XDTFILE download failed"
    exit 1
else
    echo "Downloaded foc.xdt"
    cp $XDTFILE ../xdt
fi

rm -f $DBFILE
curl -s https://foc.telegraphy.de/db/FOC_db.txt --output $DBFILE
unix2dos -q $DBFILE

if [ ! -s "$DBFILE" ]; then
    echo "ERROR! $DBFILE download failed"
    exit 1
else
    echo "Downloaded $DBFILE"
    ../copytosourcetree.bash $DBFILE
fi

exit
