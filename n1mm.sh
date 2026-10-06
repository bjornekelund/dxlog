#!/bin/bash
DIR=`pwd`
cd $1

if [ ! -s n1mmfile.txt ]; then
  exit 0
fi

DLNAME=`cat n1mmfile.txt`
OUTFILE=`cat dbfile.txt`
HELPERS=../1helpers/helpers.awk
TMPFILE=.rawfile

#set -x

# echo DLNAME=$DLNAME OUTFILE=$OUTFILE 
if ../1helpers/download.sh $DLNAME || [ -n "$2" ]; then
  # INFILE=`ls $DLNAME* | tail -1 2> /dev/null`
  # echo INFILE=$INFILE
  INFILE=`cat n1mmlatest.txt`
  echo Parsing `basename $INFILE`
  dos2unix -q $INFILE

  cat $INFILE | sed 's/ //g' | gawk -f $HELPERS -f filter.awk > $TMPFILE

  echo "#01 Based on data maintained by Claude VE2FK" >> $TMPFILE
  echo "#02 Report updates and corrections directly to ve2fk@arrl.net" >> $TMPFILE
  echo "#03 Last updated `date +%F`" >> $TMPFILE

  cat $TMPFILE | sort | sed 's/^#0[0-9]/#/g' > $OUTFILE

  unix2dos -q $OUTFILE $INFILE
  echo Created $OUTFILE
  rm -f $TMPFILE

  if [ -n ../copytosourcetree.sh ]; then
    ../copytosourcetree.sh $OUTFILE
  fi
fi

cd $DIR
exit
