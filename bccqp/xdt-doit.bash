#!/bin/bash
WEBFILE=bcc-members.xdt

rm -f $WEBFILE
curl -sS https://www.bavarian-contest-club.de/data/$WEBFILE -O

if [ ! -s $WEBFILE ]; then
    echo "ERROR! Download of member roster failed. Aborting."
    exit 1
else
    echo Downloaded $WEBFILE
    iconv -f ISO-8859-1 -t UTF-8 $WEBFILE -o $WEBFILE
    # unix2dos -q $WEBFILE
    cp $WEBFILE ../xdt
fi
