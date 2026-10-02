#!/usr/bin/env bash
CABNAME=$1
FOLDER=$1
AWKFILE=$FOLDER/filter.awk
OUTFILE=$FOLDER/$1.txt
DBFILE="$FOLDER/`cat $FOLDER/dbfile.txt`"
TMPFILE=$FOLDER/.rawoutfile
HELPERS=../1helpers/helpers.awk
#set -x

rm -f $OUTFILE

# echo "AWKFILE=$AWKFILE DBFILE=$DBFILE OUTFILE=$OUTFILE"

if [ -s "$FOLDER/webfiles.txt" ]; then
    echo "$FOLDER/webfiles.txt exists and is not empty"
    WEBFILES="`cat $FOLDER/webfiles.txt`"
    # echo WEBFILES=\"$WEBFILES\"
    for file in $WEBFILES; do
        URL="https://supercheckhistory.com/downloads/N1MM/$file"
        curl -fsSL --connect-timeout 5 --max-time 20 "$URL" -o "$FOLDER/$file" || {\
            echo "ERROR! Download of $file failed. Aborting." 
            rm -f $FOLDER/$file
            exit 1
        }
        cat $FOLDER/$file >> $TMPFILE
    done
else
    # echo "File is missing or empty"
    URL="https://supercheckhistory.com/downloads/N1MM/$CABNAME.txt"
    curl -fsSL --connect-timeout 5 --max-time 20 "$URL" -o "$TMPFILE" || {\
        echo "ERROR! Download of $CABNAME.txt failed. Aborting." 
        rm -f $WEBFILE
        exit 1
    }
fi

sort $TMPFILE | uniq > $OUTFILE

if [ ! -f $OUTFILE ] || [ $(stat -c%s $OUTFILE 2>/dev/null) -lt 1000 ]; then
    echo "ERROR! Download of $OUTFILE failed. Aborting." 
    exit 1
else
    echo Downloaded $OUTFILE, parsing...

    dos2unix -q $OUTFILE

    gawk -f $HELPERS -f $AWKFILE $OUTFILE | sort | sed 's/^#0. /# /g' > $DBFILE

    unix2dos -q $DBFILE
    echo Created $DBFILE

    # if [ -s ../copytosourcetree.sh ]; then
    #     ../copytosourcetree.sh $DBFILE
    # fi
fi
exit
