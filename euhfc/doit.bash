#!/bin/bash
ZIPFILE=DXLog.zip
OUTFILE=EUHFC_db.txt

rm -f $ZIPFILE
curl -sS https://euhf.s5cc.eu/history_files/DXLog.zip -O

if [ ! -s $ZIPFILE ]; then
    echo "ERROR! Download of $ZIPFILE failed. Aborting."
    exit 1
else
    echo Downloaded $ZIPFILE, unzipping...
    unzip -q -o $ZIPFILE
    unix2dos -q $OUTFILE
    if [ ! -s $OUTFILE ]; then
        echo "ERROR! $OUTFILE not present in  $ZIPFILE. Aborting."
        exit 1
    else
        echo Extracted $OUTFILE containing `wc -l < $OUTFILE` lines
        if [ -s ../copytosourcetree.bash ]; then
            ../copytosourcetree.bash $OUTFILE
        fi
    fi
fi

exit
