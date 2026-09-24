#!/bin/bash
WEBFILE=List_Members_MC.csv
OUTFILE=MCD_db.txt

rm -f $WEBFILE
curl -fsSL --connect-timeout 5 --max-time 20 https://www.marconiclub.it/List_Members_MC.csv -o $WEBFILE || {\
    echo "ERROR! Download of $WEBFILE failed. Aborting." 
    rm -f $WEBFILE
    exit 1
}

if [ ! -f $WEBFILE ] || [ $(stat -c%s $WEBFILE 2>/dev/null) -lt 1000 ]; then
    echo "ERROR! Download of $WEBFILE failed. Aborting." 
    rm -f $WEBFILE
    exit 1
else
    echo Downloaded $WEBFILE, parsing...
    dos2unix -q $WEBFILE
    sed 's/ //g' $WEBFILE |\
      iconv -f ISO-8859-1 -t ASCII//TRANSLIT |\
      gawk -f mcdqp.awk | sort | sed 's/^#0. /# /g' > $OUTFILE
    echo Created $OUTFILE
    unix2dos -q $OUTFILE
    if [ -s ../copytosourcetree.sh ]; then
        ../copytosourcetree.sh $OUTFILE
    fi
fi

exit
