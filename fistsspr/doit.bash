#!/bin/bash
INFILE=`ls FISTSSPR[^_]* | tail -1 2> /dev/null`
# CWTFILE=`ls ../cwt/CWOPS_* | tail -1 2> /dev/null`
OUTFILE=FISTSSPR_db.txt

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
