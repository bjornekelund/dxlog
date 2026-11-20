#!/bin/bash
WEBFILE=epccall.txt
OUTFILE=EPC_db.txt
DOWNLOAD=.downloaded
HELPERS=../_helpers/helpers.awk
#set -x  

rm -f $DOWNLOAD
curl -fsSL --connect-timeout 5 --max-time 20 https://epc-mc.eu/download/epcdlde/epccall.txt -o $DOWNLOAD || {\
    echo "ERROR! Download of member data failed. Aborting."
    rm -f $DOWNLOAD
    exit 1
}

dos2unix -q $DOWNLOAD

if cmp -s $WEBFILE $DOWNLOAD && [ -z "$1" ]; then 
    echo "Nothing new: EPC"
    rm $DOWNLOAD
    exit 0
fi

mv $DOWNLOAD $WEBFILE

if [ ! -f $WEBFILE ] || [ $(stat -c%s $WEBFILE 2>/dev/null) -lt 1000 ]; then
    echo "ERROR! Download of member data failed. Aborting."
    rm -f $WEBFILE
    exit 1
fi

echo Downloaded $WEBFILE, parsing...
dos2unix -q $WEBFILE
gawk -f $HELPERS -f epc.awk $WEBFILE | sort | sed 's/^#0. /# /g' > $OUTFILE
echo Created $OUTFILE
unix2dos -q $OUTFILE

../_helpers/copytosourcetree.sh $OUTFILE
../_helpers/uploaddb.sh $OUTFILE

exit 0
