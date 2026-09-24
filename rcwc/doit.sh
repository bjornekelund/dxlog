#!/bin/bash
WEBFILE=RCWC.txt
OUTFILE=RCWC_db.txt

rm -f $WEBFILE

curl -fsSL --connect-timeout 5 --max-time 20 "https://rcwc.ru/?do=members&getlist=3" -o "$WEBFILE" || {\
    echo "ERROR! Download of $WEBFILE failed. Aborting." 
    rm -f $WEBFILE
    exit 1
}

if [ ! -f $WEBFILE ] || [ $(stat -c%s $WEBFILE 2>/dev/null) -lt 1000 ]; then
    echo "ERROR! Download of $WEBFILE failed. Aborting." 
    exit 1
else
    echo Downloaded $WEBFILE, parsing...

    dos2unix -q $WEBFILE
    gawk -f rcwc.awk $WEBFILE | sort | sed 's/^\#0. /\# /g' > $OUTFILE

    unix2dos -q $OUTFILE
    echo Created $OUTFILE

    if [ -s ../copytosourcetree.sh ]; then
        ../copytosourcetree.sh $OUTFILE
    fi
fi
exit
