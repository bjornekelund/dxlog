#!/bin/bash
WEBFILE=agb-list.txt
OUTFILE=AGB_db.txt
DOWNLOAD=.downloaded
#set -x  

rm -f $DOWNLOAD
curl -fsSL --connect-timeout 5 --max-time 20 http://ev5agb.com/club/$WEBFILE -o $DOWNLOAD || {\
    echo "ERROR! Download of member data failed. Aborting."
    rm -f $DOWNLOAD
    exit 1
}

dos2unix -q $DOWNLOAD

if cmp $WEBFILE $DOWNLOAD; then 
    echo "The latest file is already downloaded."
    rm $DOWNLOAD
    exit 0
fi

mv $DOWNLOAD $WEBFILE

if [ ! -f $WEBFILE ] || [ $(stat -c%s $WEBFILE 2>/dev/null) -lt 1000 ]; then
    echo "ERROR! Download of member data failed. Aborting."
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
exit 0
