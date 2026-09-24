#!/bin/bash
#REFFILE=`ls CQMMDX[^_]* | tail -1 2> /dev/null`
REFFILE=CQMMDX-000.txt
WEBFILE=CQMMWEB.txt
OUTFILE=CQMM_db.txt

rm -f $WEBFILE
curl -fsSL --connect-timeout 5 --max-time 20 https://site.cwjf.com.br/membros-exportcsv -o "$WEBFILE" || {\
    echo "ERROR! Download of $WEBFILE failed. Aborting." 
    rm -f $WEBFILE
    exit 1
}

if [ ! -f $WEBFILE ] || [ $(stat -c%s $WEBFILE 2>/dev/null) -lt 1000 ]; then
    echo "ERROR! Download of member roster failed. Aborting." 
    rm -f $WEBFILE
    exit 1
else
    echo Downloaded $WEBFILE
    echo Parsing $REFFILE and $WEBFILE
    dos2unix -q $REFFILE $WEBFILE

    # Keep only YL, QRP, and clubs from reference file
    # Y, Q, and C take precedence over M
    # Non-members are automatically prefilled
    gawk 'BEGIN{FS=","}{if($2~/^(NA|EU|AS|AF|OC|SA)[CQY]$/){print $0}}' $REFFILE >> $WEBFILE
    # Clean up web file.
    # Remove Ø and double quotes
    # Remove asterisks and spaces
    # Remove everything after the first space in the callsign field
    cat $WEBFILE |\
    sed -e 's/Ø/0/g' |\
    sed -e 's/ //g' |\
    sed -e 's/\*//g' |\
    sed -e 's/"//g' |\
    sed 's/ ([^)]*)//g' |\
    gawk -f cqmm.awk | sort | sed 's/^#0. /# /g' > $OUTFILE

    unix2dos -q $OUTFILE
    echo $OUTFILE created

    if [ -s ../copytosourcetree.sh ]; then
        ../copytosourcetree.sh $OUTFILE
    fi
fi
exit
