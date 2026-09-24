#!/bin/bash
WEBFILE=data.csv
OUTFILE=PODXS_db.txt

rm -f $WEBFILE
curl -fsSL --connect-timeout 10 --max-time 20 "https://docs.google.com/spreadsheets/d/1s7RS8T4twf4-hNsI5uiGEsTiUnqQ51xU1Lne5B5GIUI/gviz/tq?tqx=out:csv&sheet=Member_shortlist" -o $WEBFILE || {\
    echo "ERROR! Download of $WEBFILE failed. Aborting." 
    rm -f $WEBFILE
    exit 1
}

if [ ! -f $WEBFILE ] || [ $(stat -c%s $WEBFILE 2>/dev/null) -lt 1000 ]; then
    echo "ERROR! Download of $WEBFILE failed. Aborting." 
    rm -f $WEBFILE
    exit 1
else
    echo Downloaded $WEBFILE
    dos2unix -q $WEBFILE
    sed 's/\"//g' $WEBFILE | gawk -f podxs.awk | sort | sed 's/#.. /# /g' > $OUTFILE
    unix2dos -q $OUTFILE
    echo Created $OUTFILE
    if [ -s ../copytosourcetree.sh ]; then
        ../copytosourcetree.sh $OUTFILE
    fi
fi

exit
