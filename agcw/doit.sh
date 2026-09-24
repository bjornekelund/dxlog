#!/bin/bash
WEBFILE=Mitglieder.csv
OUTFILE=AGCW_db.txt

rm -f $WEBFILE
curl -fsSL --connect-timeout 5 --max-time 20 https://www.agcw.de/wp-content/persist/$WEBFILE -O || {\
    echo "ERROR! Download of $WEBFILE failed. Aborting." 
    rm -f $WEBFILE
    exit 1
}

if [ ! -f $WEBFILE ] || [ $(stat -c%s $WEBFILE 2>/dev/null) -lt 1000 ]; then
    echo "ERROR! Download of member data failed. Aborting." 
    rm -f $WEBFILE
    exit 1
else
    echo Downloaded $WEBFILE, parsing...
    dos2unix -q $WEBFILE
    cat $WEBFILE | sed 's/Ø/0/g' | sed 's/ //g' | gawk -f agcw.awk | sort | sed 's/^#0. /# /g' > $OUTFILE
    echo Created $OUTFILE
    unix2dos -q $OUTFILE
    if [ -s ../copytosourcetree.sh ]; then
        ../copytosourcetree.sh $OUTFILE
    fi
fi

if [ -s ../agcwntcqp ]; then
    cd ../agcwntcqp && ./doit.sh
fi

exit
