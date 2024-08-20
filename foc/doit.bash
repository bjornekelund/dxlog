#!/bin/bash
OUTFILE=FOC_db.txt
XDTFILE=foc.xdt

curl -s https://foc.telegraphy.de/db/FOC_db.txt --output $OUTFILE
curl -s https://foc.telegraphy.de/db/foc.xdt --output $XDTFILE

echo "Downloaded FOC_db.txt and foc.xdt"
unix2dos -q $XDTFILE $OUTFILE

cp $XDTFILE ../xdt

../copytosourcetree.bash $OUTFILE

exit
