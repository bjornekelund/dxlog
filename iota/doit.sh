#!/bin/bash
if ../1helpers/download.sh IOTA || [ -n "$1" ]; then
  INFILE=`ls IOTA_2* | tail -1 2> /dev/null`
  DBFILE=IOTA_db.txt
  XDTFILE=IOTA.xdt
  TEMPFILE=.outfile
  HELPERS="../1helpers/helpers.awk"

  echo Parsing $INFILE
  dos2unix -q $INFILE

# TXT file creation

  gawk -f $HELPERS -f filter.awk $INFILE > $TEMPFILE

  echo "#02 Based on data collected by Claude VE2FK" >> $TEMPFILE
  echo "#09 Last updated `date +%F`" >> $TEMPFILE

  sort < $TEMPFILE | sed 's/^#0[0-9]/#/g' > $DBFILE

  rm -rf $TEMPFILE

# XDT file creation

  unix2dos -q $DBFILE
  echo Created $DBFILE

  ../copytosourcetree.sh $DBFILE

  gawk -f xdt.awk $INFILE | sort > $XDTFILE

  unix2dos -q $XDTFILE $INFILE
  echo Created $XDTFILE

  cp $XDTFILE ../3xdt
fi
exit
