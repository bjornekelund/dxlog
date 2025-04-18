#!/bin/bash
#FILE=CQMMDX.txt
OLDFILE=`ls CQMMDX[^_]* | tail -1 2> /dev/null`
WEBFILE=CQMMWEB.txt
OUTFILE=CQMM_db.txt

echo Downloading $WEBFILE

wget -q https://site.cwjf.com.br/membros-exportcsv -O $WEBFILE

echo Parsing $OLDFILE $WEBFILE
dos2unix -q $OLDFILE $WEBFILE

gawk 'BEGIN{FS=","}{if ($2 !~ /..M$/) {print $0}}' $OLDFILE > .temp
cat .temp $WEBFILE | sed -e 's/Ø/0/g' |\
sed -e 's/"//g' |\
sed 's/ ([^)]*)//g' |\
gawk -f cqmm.awk | sort | sed 's/#. /# /g' > $OUTFILE

unix2dos -q $OUTFILE
echo $OUTFILE created

../copytosourcetree.bash $OUTFILE

exit
