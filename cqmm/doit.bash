#!/bin/bash
#FILE=CQMMDX.txt
INFILE=`ls CQMMDX[^_]* | tail -1 2> /dev/null`
WEBFILE=CQMMWEB.txt
OUTFILE=CQMM_db.txt

echo Downloading $WEBFILE

wget -q https://site.cwjf.com.br/membros-exportcsv -O $WEBFILE

echo Parsing $INFILE $WEBFILE
dos2unix -q $INFILE $WEBFILE

cat $INFILE $WEBFILE | sed -e 's/Ø/0/g' |\
sed -e 's/"//g' |\
sed 's/ ([^)]*)//g' |\
gawk -f cqmm.awk | sort | sed 's/#. /# /g' > $OUTFILE

unix2dos -q $OUTFILE
echo $OUTFILE created

../copytosourcetree.bash $OUTFILE

exit
