#!/bin/bash
WEBFILE=CQMMWEB.txt
OUTFILE=CQMM_db.txt

rm -f $WEBFILE
wget -q https://site.cwjf.com.br/membros-exportcsv -O $WEBFILE

if [ ! -s $WEBFILE ]; then
    echo "ERROR! Download of member roster failed. Aborting."
    exit 1
else
    echo Downloaded $WEBFILE, parsing...
    dos2unix -q $WEBFILE

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

    rm -f .temp

    unix2dos -q $OUTFILE
    echo $OUTFILE created

    if [ -s ../copytosourcetree.bash ]; then
      ../copytosourcetree.bash $OUTFILE
    fi
fi
exit
