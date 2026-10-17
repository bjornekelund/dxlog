#!/bin/bash
WEBFILE=$(ls WAPC_H* | tail -1 2> /dev/null)
OUTFILE=WAPC_db.txt
DOWNLOAD=.downloaded
HELPERS=../1helpers/helpers.awk
TEMPFILE=.tmpoutfile
URL=http://www.mulandxc.com/index/download?id=33
# set -x

rm -f $DOWNLOAD
curl -fsSL --connect-timeout 5 --max-time 20 $URL -o $DOWNLOAD || {\
  echo "ERROR! Download of call history data failed. Aborting."
  rm -f $DOWNLOAD
  exit 1
}

dos2unix -q $DOWNLOAD

if cmp -s $WEBFILE $DOWNLOAD && [ -z "$1" ]; then 
  echo "The latest file is already downloaded."
  rm $DOWNLOAD
  exit 0
fi

mv $DOWNLOAD $WEBFILE

if [ ! -f $WEBFILE ] || [ $(stat -c%s $WEBFILE 2>/dev/null) -lt 1000 ]; then
  echo "ERROR! Download of call history data failed. Aborting."
  rm -f $DOWNLOAD
  exit 1
else
  echo Downloaded $WEBFILE, parsing...
  dos2unix -q $WEBFILE
  gawk -f filter.awk -f $HELPERS $WEBFILE > $TEMPFILE
  echo "#01 Based on data from http://www.mulandxc.com/index/down_list" >> $TEMPFILE;
  echo "#04 Contains only exceptions to rule-based prefill" >> $TEMPFILE;
  echo "#09 Last updated `date +%F`" >> $TEMPFILE
  sort $TEMPFILE | sed 's/^#0. /# /g' > $OUTFILE
  echo Created $OUTFILE
  unix2dos -q $OUTFILE
  if [ -s ../copytosourcetree.sh ]; then
    ../copytosourcetree.sh $OUTFILE
  fi
  # rm -f $TEMPFILE $DOWNLOAD
fi
exit 0
