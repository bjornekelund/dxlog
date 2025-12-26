#!/bin/bash
DBFILE=FOC_db.txt
XDTFILE=foc.xdt

rm -f $XDTFILE
curl -s https://foc.telegraphy.de/db/$XDTFILE -O

if [ ! -s $XDTFILE ]; then
    echo "ERROR! Download of $XDTFILE failed. Aborting."
    exit 1
else
    unix2dos -q $XDTFILE
    echo "Downloaded $XDTFILE"
    cp $XDTFILE ../xdt
fi

rm -f $DBFILE
curl -s https://foc.telegraphy.de/db/$DBFILE -O

if [ ! -s $DBFILE ]; then
    echo "ERROR! Download of $DBFILE failed. Aborting."
    exit 1
else
    unix2dos -q $DBFILE
    echo "Downloaded $DBFILE"
    ../copytosourcetree.bash $DBFILE
fi

exit
