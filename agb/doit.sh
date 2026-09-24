#!/bin/bash
WEBFILE=agb-list.txt
OUTFILE=AGB_db.txt

rm -f $WEBFILE
curl -fsSL --connect-timeout 5 --max-time 20 http://ev5agb.com/club/$WEBFILE -O || {\
    echo "ERROR! Download of member data failed. Aborting." >&2
    rm -f $WEBFILE
    exit 1
}

if [ ! -f $WEBFILE ] || [ $(stat -c%s $WEBFILE 2>/dev/null) -lt 1000 ]; then
    echo "ERROR! Download of member data failed. Aborting." >&2
    rm -f $WEBFILE
    exit 1
else
    echo Downloaded $WEBFILE, parsing...
    dos2unix -q $WEBFILE
    gawk -f agb.awk $WEBFILE | sort | sed 's/^#0. /# /g' > $OUTFILE
    echo Created $OUTFILE
    unix2dos -q $OUTFILE
    if [ -s ../copytosourcetree.sh ]; then
        ../copytosourcetree.sh $OUTFILE
    fi
fi
exit
