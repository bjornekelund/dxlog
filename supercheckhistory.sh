#!/usr/bin/env bash
DIR=`pwd`

if [ ! -d $1 ]; then
  exit 0
fi

cd $1

if [ ! -s schfile.txt ]; then
  exit 0
  cd $DIR
fi

AWKFILE="filter.awk"
TMPFILE1=".downloaded"
TMPFILE2=".tmpoutfile"
HELPERS="../1helpers/helpers.awk"
#set -x

rm -f $OUTFILE

# echo "AWKFILE=$AWKFILE DBFILE=$DBFILE OUTFILE=$OUTFILE"

if [ -s "schfile.txt" ] && [ -s "dbfile.txt" ]; then
  SCHFILE="`cat schfile.txt`"
  DBFILE="`cat dbfile.txt`"
  # echo "schfile.txt exists and is not empty"
  URL="https://supercheckhistory.com/downloads/N1MM/$SCHFILE"
  curl -fsSL --connect-timeout 5 --max-time 20 "$URL" -o "$TMPFILE1" || {\
    echo "ERROR! Download of $SCHFILE failed. Aborting." 
    rm -f $TMPFILE1
    cd $DIR
    exit 1
  }
else
  echo "schfile.txt or dbfile.txt is missing or empty"
  cd $DIR
  exit 1 
fi

dos2unix -q $TMPFILE1

if cmp -s $SCHFILE $TMPFILE1 && [ -z "$2" ]; then 
    echo "The latest version of $SCHFILE is already downloaded."
    rm -f $TMPFILE1
    cd $DIR
    exit 0
fi

if [ ! -f $TMPFILE ] || [ $(stat -c%s $TMPFILE1 2>/dev/null) -lt 100 ]; then
  echo "ERROR! Download of $SCHFILE failed. Aborting." 
  rm -f $TMPFILE1
  cd $DIR
  exit 1
else
  echo Downloaded $SCHFILE, parsing...

  mv $TMPFILE1 $SCHFILE
  dos2unix -q $SCHFILE

  gawk -f $HELPERS -f $AWKFILE $SCHFILE > $TMPFILE2
  
  echo "#01 Based on data from https://supercheckhistory.com/" >> $TMPFILE2
  echo "#02 Last updated `date +%F`" >> $TMPFILE2

  sort $TMPFILE2 | sed 's/^#0. /# /g' > $DBFILE

  unix2dos -q $DBFILE
  echo Created $DBFILE

  rm -f $TMPFILE1 $TMPFILE2
  
  if [ -s ../copytosourcetree.sh ]; then
      ../copytosourcetree.sh $DBFILE
  fi
fi

cd $DIR

exit
