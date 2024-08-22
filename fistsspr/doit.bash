#!/bin/bash
FILE=`ls FISTSSPR[^_]* | tail -1 2> /dev/null`
CWTFILE=`ls ../cwt/CWOPS_* | tail -1 2> /dev/null`
OUTFILE=FISTSSPR_db.txt

echo Parsing $FILE $CWTFILE
dos2unix -q $FILE $CWTFILE

gawk 'BEGIN{FS = ",";}{
if ($0 ~ /!!/) 
  printf("%s\n", $0); 
else if ($0 !~ /^#/) 
  printf("%s,%s\n", $1, $2);
  }' $CWTFILE > .cwt

cat $FILE .cwt | gawk -f fistsspr.awk | sort | sed 's/#. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
