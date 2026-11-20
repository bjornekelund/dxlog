#!/bin/bash
export LANG=C.UTF8
DIR=$(pwd)
HELPERS=../_helpers/helpers.awk
TMPFILE=.rawfile

if [ ! -d $1 ]; then
  exit 1
fi

cd $1

if [ ! -s n1mmfile.txt || ! -s dbfile.txt ]; then
  exit 0
  cd $DIR
fi

DLNAME=$(cat n1mmfile.txt)
OUTFILE=$(cat dbfile.txt)

if ../_helpers/download.sh $DLNAME || [ -n "$2" ]; then
  if [ -s n1mmlatest.txt ]; then
    INFILE=$(cat n1mmlatest.txt)
    echo Parsing $(basename $INFILE)
    dos2unix -q $INFILE

    cat $INFILE | gawk -f $HELPERS -f filter.awk > $TMPFILE

    echo "#02 Based on data collected by Claude VE2FK" >> $TMPFILE
    echo "#09 Last updated $(date +%F)" >> $TMPFILE

    cat $TMPFILE | sort | sed 's/^#0[0-9]/#/g' > $OUTFILE

    unix2dos -q $OUTFILE $INFILE
    echo Created $OUTFILE
    rm -f $TMPFILE

    ../_helpers/copytosourcetree.sh $OUTFILE

    echo -----
  fi
fi

cd $DIR
exit 0
