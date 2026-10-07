#!/bin/bash
ZIPFILE=DXLog.zip
OUTFILE=EUHFC_db.txt
OLDFILE=EUHFC_db-old.txt

# rm -f $ZIPFILE
curl -fsSL --connect-timeout 5 --max-time 20 https://euhf.s5cc.eu/history_files/DXLog.zip -O || {\
    echo "ERROR! Download of $ZIPFILE failed. Aborting." 
    rm -f $ZIPFILE
    exit 1
}

if [ ! -f $ZIPFILE ] || [ $(stat -c%s $ZIPFILE 2>/dev/null) -lt 200 ]; then
    echo "ERROR! Download of $ZIPFILE failed. Aborting." 
    rm -f $ZIPFILE
    exit 1
else
    # printf "Downloaded $ZIPFILE, unzipping..."
    unzip -q -o $ZIPFILE
    # echo done
    unix2dos -q $OUTFILE

    if cmp -s $OUTFILE $OLDFILE && [ -z "$1" ]; then 
        echo "The latest file is already downloaded."
        rm $OUTFILE
        exit 0
    fi

    if [ ! -s $OUTFILE ]; then
        echo "ERROR! $OUTFILE not present in $ZIPFILE. Aborting." 
        exit 1
    else
        echo Extracted $OUTFILE containing `wc -l < $OUTFILE` lines       
        if [ -s ../copytosourcetree.sh ]; then
            ../copytosourcetree.sh $OUTFILE
        fi
        mv $OUTFILE $OLDFILE
    fi
fi

exit
