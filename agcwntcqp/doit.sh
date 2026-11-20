#!/bin/bash
NAGCWFILE="../agcw/Mitglieder.csv"
AGCWFILE="Mitglieder.csv"
NNTCFILE="../ntc/NTC-QP.txt"
NTCFILE="NTC-QP.txt"
OUTFILE=AGCWNTCQP_db.txt
HELPERS=../_helpers/helpers.awk

TEMP1=.temp1
TEMP2=.temp2

if cmp -s $NAGCWFILE $AGCWFILE && cmp -s $NNTCFILE $NTCFILE && [ -z "$1" ]; then 
    echo "Nothing new: AGCNTCQP"
    exit 0
fi

cp $NAGCWFILE $AGCWFILE
cp $NNTCFILE $NTCFILE

dos2unix -q $AGCWFILE $NTCFILE

echo Parsing $AGCWFILE
cat $AGCWFILE | tr 'üéöáàåä' 'ueoaaaa' | tr 'Ø' '0' |sed 's/\s*$//' | sed 's/\s*;\s*/;/g' | gawk -f $HELPERS -f agcw.awk > $TEMP1

echo Parsing $NTCFILE
cat $NTCFILE | sed 's/[ \t]*$//' | sed 's/ ;/;/g' | gawk -f $HELPERS -f ntc.awk > $TEMP2

echo Creating $OUTFILE
cat $TEMP1 $TEMP2 | gawk -f $HELPERS -f newagcwntcqp.awk | sort | sed 's/^#0. /# /g' > $OUTFILE

unix2dos -q $OUTFILE

../_helpers/copytosourcetree.sh $OUTFILE
../_helpers/uploaddb.sh $OUTFILE

rm -f $TEMP1 $TEMP2

exit 0
