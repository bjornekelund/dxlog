#!/bin/bash
#set -x
DIR=`pwd`

if [ ! -d $1 ]; then
  exit 1
fi

cd $1

if [ ! -s n1mmfile.txt ]; then
  exit 0
  cd $DIR
fi

DLNAME=$(cat n1mmfile.txt)
OUTFILE=$(cat dbfile.txt)
HELPERS=../1helpers/helpers.awk
TMPFILE=.rawfile

if [ -s "schfile.txt" ]; then
  SCHFILE=$(cat schfile.txt)
else
  SCHFILE=$DLNAME
fi

if ../1helpers/download.sh $DLNAME || [ -n "$2" ]; then
  # INFILE=`ls $DLNAME* | tail -1 2> /dev/null`
  # echo INFILE=$INFILE
  if [ -s n1mmlatest.txt ]; then
    INFILE=$(cat n1mmlatest.txt)
    echo Parsing `basename $INFILE`
    dos2unix -q $INFILE

    # cat $INFILE | sed 's/ //g' | gawk -f $HELPERS -f filter.awk > $TMPFILE
    cat $INFILE | gawk -f $HELPERS -f filter.awk > $TMPFILE

    echo "#02 Based on data maintained by Claude VE2FK" >> $TMPFILE
    echo "#03 Report updates and corrections directly to ve2fk@arrl.net" >> $TMPFILE
    echo "#09 Last updated `date +%F`" >> $TMPFILE

    cat $TMPFILE | sort | sed 's/^#0[0-9]/#/g' > $OUTFILE

    unix2dos -q $OUTFILE $INFILE
    echo Created $OUTFILE
    rm -f $TMPFILE

    if [ -n ../copytosourcetree.sh ]; then
      ../copytosourcetree.sh $OUTFILE
    fi

    # DELETE=$(find . -maxdepth 1 -type f -name "${DLNAME}*" ! -name "$SCHFILE" ! -name "$OUTFILE" ! -name "$INFILE")
    # if [ -n "$DELETE" ]; then
    #   echo Deleting $DELETE
    #   rm -f $DELETE
    # fi
  fi
fi

cd $DIR
exit
