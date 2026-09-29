#!/usr/bin/env bash
CABNAME=$1
FOLDER=$1
WEBFILE=$FOLDER/$1.txt
AWKFILE=$FOLDER/$1.awk
OUTFILE=$FOLDER/`cat $FOLDER/$1.file`
URL="https://supercheckhistory.com/downloads/N1MM/$CABNAME.txt"
HELPERS=../1helpers/helpers.awk
#set -x

#echo "AWKFILE=$AWKFILE OUTFILE=$OUTFILE WEBFILE=$WEBFILE URL=$URL"

rm -f $WEBFILE

curl -fsSL --connect-timeout 5 --max-time 20 "$URL" -o "$WEBFILE" || {\
    echo "ERROR! Download of $WEBFILE failed. Aborting." 
    rm -f $WEBFILE
    exit 1
}

if [ ! -f $WEBFILE ] || [ $(stat -c%s $WEBFILE 2>/dev/null) -lt 1000 ]; then
    echo "ERROR! Download of $WEBFILE failed. Aborting." 
    exit 1
else
    echo Downloaded $WEBFILE, parsing...

    dos2unix -q $WEBFILE

    gawk -f $HELPERS -f $AWKFILE $WEBFILE | sort | sed 's/^#0. /# /g' > $OUTFILE

    unix2dos -q $OUTFILE
    echo Created $OUTFILE

    if [ -s ../copytosourcetree.sh ]; then
        ../copytosourcetree.sh $OUTFILE
    fi
fi
exit
