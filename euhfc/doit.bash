#!/bin/bash
ZIPFILE=DXLog.zip
OUTFILE=EUHFC_db.txt

echo Downloading $ZIPFILE

wget -q https://euhf.s5cc.eu/history_files/DXLog.zip -O $ZIPFILE

echo Unzipping $ZIPFILE

unzip -q -o $ZIPFILE

unix2dos -q $OUTFILE

echo Created $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
