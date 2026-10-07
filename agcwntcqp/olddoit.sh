#!/bin/bash
if ../1helpers/download.sh AGCW-NTCQP || [ -n "$1" ]; then

    AGCWFILE=`ls ../agcw/Mitglieder.csv`
    NTCFILE=`ls ../ntc/NTC_Q* | tail -1 2> /dev/null`
    QPFILE=`ls AGCW-NTC*[0-9].txt | tail -1 2> /dev/null`
    NAMESFILE=`ls ../names/Names_VE2FK* | tail -1 2> /dev/null`
    OUTFILE=AGCWNTCQP_db.txt

    TEMP1=.temp1
    TEMP2=.temp2
    TEMP3=.temp3

    echo Parsing $AGCWFILE
    dos2unix -q $AGCWFILE

    cat $AGCWFILE | tr 'üéöáàåä' 'ueoaaaa' | tr 'Ø' '0' |sed 's/\s*$//' | sed 's/\s*;\s*/;/g' | gawk -f agcw.awk > $TEMP1

    echo Parsing $NTCFILE
    dos2unix -q $NTCFILE

    cat $NTCFILE | sed 's/[ \t]*$//' | sed 's/ ;/;/g' | gawk -f ntc.awk > $TEMP2

    echo Parsing $QPFILE
    dos2unix -q $QPFILE $NAMESFILE

    cat $QPFILE | sed 's/ü/u/g' |  sed 's/é/e/g' | gawk -f qp.awk > $TEMP3

    cat $NAMESFILE | gawk -f names.awk >> $TEMP3

    echo Creating $OUTFILE

    cat $TEMP1 $TEMP2 $TEMP3 | gawk -f agcwntcqp.awk | sort | sed 's/^#0. /# /g' > $OUTFILE

    unix2dos -q $OUTFILE

    ../copytosourcetree.sh $OUTFILE
fi

rm -f $TEMP1 $TEMP2 $TEMP3
exit
