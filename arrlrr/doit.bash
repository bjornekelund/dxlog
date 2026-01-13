#!/bin/bash
INFILESS=`ls ../arrlss/SSCW* | tail -1 2> /dev/null`
INFILENAQP=`ls ../naqp/NAQP[^_]* | tail -1 2> /dev/null`
INFILEWRT=`ls ../wrt/WRT[^_]* | tail -1 2> /dev/null`
INFILENAMES=`ls ../names/Names_VE2FK* | tail -1 2> /dev/null`
INFILEFISTS=`ls ../fistsspr/FISTSSPR[^_]* | tail -1 2> /dev/null`

OUTFILE=ARRL_RR_db.txt

dos2unix -q $INFILESS $INFILENAQP

echo !!Order!!,Call,Sect,State,CK,UserText, > .temp

echo Parsing $INFILESS
gawk 'BEGIN{FS = ","}{if ($0 !~ /^(#|!|\s*$)/) printf("%s,,%s,%s\n", $1, $4, $3);}' $INFILESS > .temp

echo Parsing $INFILENAQP
gawk 'BEGIN{FS = ","}{if ($0 !~ /^(#|!|\s*$)/) printf("%s,%s,,%s\n", $1, $2, $3);}' $INFILENAQP >> .temp

echo Parsing $INFILEWRT
gawk 'BEGIN{FS = ","}{if ($0 !~ /^(#|!|\s*$)/) printf("%s,%s,,\n", $1, $2);}' $INFILEWRT >> .temp

echo Parsing $INFILENAMES
gawk 'BEGIN{FS = ","}{if ($0 !~ /^(#|!|\s*$)/) printf("%s,%s,,\n", $1, $2);}' $INFILENAMES >> .temp

echo Parsing $INFILEFISTS
gawk 'BEGIN{FS = ","}{if ($0 !~ /^(#|!|\s*$)/) printf("%s,%s,,\n", $1, $2);}' $INFILEFISTS >> .temp

gawk -f arrlrr.awk .temp | sort | sed 's/^#0. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
