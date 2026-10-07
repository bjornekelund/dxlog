#!/bin/bash
WEBFILE=data.csv
OUTFILE=PODXS_db.txt
DOWNLOAD=.downloaded

rm -f $DOWNLOAD
curl -fsSL --connect-timeout 10 --max-time 20 "https://docs.google.com/spreadsheets/d/1s7RS8T4twf4-hNsI5uiGEsTiUnqQ51xU1Lne5B5GIUI/gviz/tq?tqx=out:csv&sheet=Member_shortlist" -o $DOWNLOAD || {\
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
  echo Downloaded $WEBFILE
  dos2unix -q $WEBFILE
  sed 's/\"//g' $WEBFILE | gawk -f podxs.awk | sort | sed 's/#.. /# /g' > $OUTFILE
  unix2dos -q $OUTFILE
  echo Created $OUTFILE
  if [ -s ../copytosourcetree.sh ]; then
      ../copytosourcetree.sh $OUTFILE
  fi
fi

exit
