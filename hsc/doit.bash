#!/bin/bash

DBFILE=HSC_db.txt
XDTFILE=hsc.xdt

curl -s https://hsc.dj1yfk.de/db/HSC_db.txt --output $DBFILE
curl -s https://hsc.dj1yfk.de/db/hsc.xdt --output $XDTFILE

echo Downloaded $DBFILE and $XDTFILE

cp $XDTFILE ../xdt

../copytosourcetree.bash $DBFILE

exit
