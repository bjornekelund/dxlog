#!/bin/bash
REFFILE=`ls CQMMDX[^_]* | tail -1 2> /dev/null`
WEBFILE=CQMMWEB.txt
OUTFILE=CQMM_db.txt

rm -f $WEBFILE
wget -q https://site.cwjf.com.br/membros-exportcsv -O $WEBFILE

if [ ! -s $WEBFILE ]; then
    echo "ERROR! Download of member roster failed. Aborting."
    exit 1
else
    echo Downloaded $WEBFILE
    echo Parsing $REFFILE and $WEBFILE
    dos2unix -q $REFFILE $WEBFILE

    # Keep only YL, QRP, and clubs from reference file
    # Y, Q, and C take precedence over M
    # Non-members are automatically prefilled
    gawk 'BEGIN{FS=","}{if ($2 ~ /^(NA|EU|AS|AF|OC|SA)[CQY]$/) {print $0}}' $REFFILE >> $WEBFILE
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
    gawk -f cqmm.awk | sort | sed 's/#. /# /g' > $OUTFILE

    unix2dos -q $OUTFILE
    echo $OUTFILE created

    if [ -s ../copytosourcetree.bash ]; then
        ../copytosourcetree.bash $OUTFILE
    fi
fi
exit
