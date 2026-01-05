#!/bin/bash
WEBFILE=fistsmembers.csv
INFILE=members.txt
OLDFILE=FISTSSPR-OLD.txt
OUTFILE=FISTSSPR_db.txt

rm -f $WEBFILE
curl -sS https://fists.co.uk/docs/$WEBFILE -O

if [ ! -s $WEBFILE ]; then
    echo "ERROR! Download of $WEBFILE failed"
    exit 1
else
    echo Downloaded $WEBFILE, creating $INFILE...

    echo "!!Order!!,Misc,Call,Name" > $INFILE
    dos2unix -q $WEBFILE $OLDFILE
    cat $WEBFILE >> $INFILE
    cat $OLDFILE >> $INFILE

    gawk -f nfistsspr.awk $INFILE | sort | sed 's/^\#0. /\# /g' > $OUTFILE

    unix2dos -q $OUTFILE
    echo Created $OUTFILE

    if [ -s ../copytosourcetree.bash ]; then
        ../copytosourcetree.bash $OUTFILE
    fi
fi
exit


echo Parsing $INFILE $CWTFILE
dos2unix -q $INFILE $CWTFILE

# gawk 'BEGIN{FS = ",";}{
# if ($0 ~ /!!/) 
#   printf("%s\n", $0); 
# else if ($0 ~ /^[A-Z0-9]/) 
#   printf("%s,%s\n", $1, $2);
#   }' $CWTFILE > .cwt

echo "" > .cwt

cat $INFILE .cwt | gawk -f fistsspr.awk | sort | sed 's/#0. /# /g' > $OUTFILE

unix2dos -q $OUTFILE $INFILE
echo Created $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
