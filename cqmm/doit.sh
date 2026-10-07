#!/bin/bash
REFFILE=REF-CQMMDX.txt
WEBFILE=CQMMWEB.txt
OUTFILE=CQMM_db.txt
DOWNLOAD=.downloaded
COMBINED=.combined

#rm -f $DOWNLOAD
curl -fsSL --connect-timeout 5 --max-time 20 https://site.cwjf.com.br/membros-exportcsv -o $DOWNLOAD || {\
    echo "ERROR! Download of online member data failed. Aborting." 
    rm -f $DOWNLOAD
    exit 1
}

dos2unix -q $DOWNLOAD

if cmp $WEBFILE $DOWNLOAD && [ -z "$1" ]; then 
    echo "The latest file is already downloaded."
    rm -f $DOWNLOAD
    exit 0
fi

cp $DOWNLOAD $WEBFILE
cp $DOWNLOAD $COMBINED

if [ ! -f $WEBFILE ] || [ $(stat -c%s $WEBFILE 2>/dev/null) -lt 200 ]; then
    echo "ERROR! Download of member roster failed. Aborting." 
    rm -f $WEBFILE
    exit 1
else
    echo Downloaded $WEBFILE
    echo Parsing $REFFILE and $WEBFILE
    dos2unix -q $REFFILE $COMBINED

    # Keep only YL, QRP, and clubs from reference file
    # Y, Q, and C take precedence over M
    # Non-members are automatically prefilled
    gawk 'BEGIN{FS=","}{if($2~/^(NA|EU|AS|AF|OC|SA)[CQY]$/){print $0}}' $REFFILE >> $COMBINED |\
    # Clean up web file.
    # Remove Ø and double quotes
    # Remove asterisks and spaces
    # Remove everything after the first space in the callsign field
    cat $COMBINED | sed -e 's/Ø/0/g' |\
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
