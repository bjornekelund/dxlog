#!/bin/bash
WEBFILE=RCWC.txt
OUTFILE=RCWC_db.txt
DOWNLOAD=.downloaded

rm -f $DOWNLOAD

curl -fsSL --connect-timeout 5 --max-time 20 "https://rcwc.ru/?do=members&getlist=3" -o "$DOWNLOAD" || {\
  echo "ERROR! Download of $WEBFILE failed. Aborting." 
  rm -f $DOWNLOAD
  exit 1
}

if [ ! -f $DOWNLOAD ] || [ $(stat -c%s $DOWNLOAD 2>/dev/null) -lt 200 ]; then
  echo "ERROR! Download of $WEBFILE failed. Aborting." 
  rm -f $DOWNLOAD
  exit 1
else
  dos2unix -q $DOWNLOAD
  if cmp -s $WEBFILE $DOWNLOAD && [ -z "$1" ]; then 
    echo "The latest db file is already downloaded."
    rm -f $DOWNLOAD
    exit 0
  fi
  mv $DOWNLOAD $WEBFILE

  echo Downloaded $WEBFILE, parsing...

  dos2unix -q $WEBFILE
  gawk -f rcwc.awk $WEBFILE | sort | sed 's/^\#0. /\# /g' > $OUTFILE

  unix2dos -q $OUTFILE
  echo Created $OUTFILE

  if [ -s ../copytosourcetree.sh ]; then
      ../copytosourcetree.sh $OUTFILE
  fi
fi
exit
