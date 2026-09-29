#!/usr/bin/env bash
WEBFILE=RDAC.txt
OUTFILE=RDAC_db.txt

echo Parsing $INFILE

exit


rm -f $WEBFILE

curl -fsSL --connect-timeout 5 --max-time 20 "https://supercheckhistory.com/downloads/DXLog/RDAC.txt" -o "$WEBFILE" || {\
    echo "ERROR! Download of $WEBFILE failed. Aborting." 
    rm -f $WEBFILE
    exit 1
}

if [ ! -f $WEBFILE ] || [ $(stat -c%s $WEBFILE 2>/dev/null) -lt 1000 ]; then
    echo "ERROR! Download of $WEBFILE failed. Aborting." 
    exit 1
else
    echo Downloaded $WEBFILE, parsing...

dos2unix -q $INFILE

gawk -f rdac.awk $INFILE | sort | sed 's/^#0. /# /g' > $OUTFILE

unix2dos -q $OUTFILE $INFILE
echo Created $OUTFILE

../copytosourcetree.sh $OUTFILE

    if [ -s ../copytosourcetree.sh ]; then
        ../copytosourcetree.sh $OUTFILE
    fi
fi
exit
