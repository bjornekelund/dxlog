#!/bin/bash
WEBFILE=DIGLISTE.csv
OUTFILE=DIG_db.txt

rm -f $WEBFILE
curl -fsSL --connect-timeout 5 --max-time 20 https://diplom-interessen-gruppe.info/fileadmin/downloads/DIGLISTE.csv -o $WEBFILE || {\
    echo "ERROR! Download of $WEBFILE failed. Aborting." 
    rm -f $WEBFILE
    exit 1
}

if [ ! -f $WEBFILE ] || [ $(stat -c%s $WEBFILE 2>/dev/null) -lt 1000 ]; then
    echo "ERROR! Download of $WEBFILE failed" $>2
    rm -f $WEBFILE
    exit 1
else
    echo Downloaded $WEBFILE, parsing...

    dos2unix -q $WEBFILE
    cat $WEBFILE | sed 's/\"//g' | sed 's/\\N//g' | gawk -f dig.awk | sort | sed 's/=0*/=/g' | sed 's/^#0. /# /g' > $OUTFILE

    unix2dos -q $OUTFILE
    echo Created $OUTFILE

    if [ -s ../copytosourcetree.sh ]; then
        ../copytosourcetree.sh $OUTFILE
    fi
fi

exit
