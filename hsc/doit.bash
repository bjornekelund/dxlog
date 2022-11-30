#!/bin/bash

DBFILE=HSC_db.txt
XDTFILE=hsc.xdt

curl -s https://hsc.dj1yfk.de/db/HSC_db.txt --output HSC_db.txt
curl -s https://hsc.dj1yfk.de/db/hsc.xdt --output hsc.xdt

echo Downloaded $DBFILE and $XDTFILE

exit
