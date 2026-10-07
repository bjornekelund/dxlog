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
SCHFILE="`cat schfile.txt`"
LASTOUTFILE="SCH-$SCHFILE.txt"
DBFILE="`cat dbfile.txt`"
TMPFILE1=".downloaded"
TMPFILE2=".tmpoutfile"
HELPERS="../1helpers/helpers.awk"
#set -x

rm -f $OUTFILE

# echo "AWKFILE=$AWKFILE DBFILE=$DBFILE OUTFILE=$OUTFILE"

if [ -s "schfile.txt" ]; then
  # echo "schfile.txt exists and is not empty"
  URL="https://supercheckhistory.com/downloads/N1MM/$SCHFILE"
  curl -fsSL --connect-timeout 5 --max-time 20 "$URL" -o "$TMPFILE1" || {\
    echo "ERROR! Download of $SCHFILE failed. Aborting." 
    rm -f $SCHFILE
    cd $DIR
    exit 1
  }
else
  echo "schfile.txt is missing or empty"
  cd $DIR
  exit 1 
fi

sort $TMPFILE1 | uniq > $SCHFILE

dos2unix -q $SCHFILE

if cmp -s $LASTOUTFILE $SCHFILE && [ -z "$2" ]; then 
    echo "The latest version of $SCHFILE is already downloaded."
    rm -f $TMPFILE1 $SCHFILE
    cd $DIR
    exit 0
fi

if [ ! -f $SCHFILE ] || [ $(stat -c%s $SCHFILE 2>/dev/null) -lt 100 ]; then
  echo "ERROR! Download of $SCHFILE failed. Aborting." 
  cd $DIR
  exit 1
else
  echo Downloaded $SCHFILE, parsing...

  dos2unix -q $SCHFILE

  gawk -f $HELPERS -f $AWKFILE $SCHFILE > $TMPFILE2
  
  echo "#01 Based on data from https://supercheckhistory.com/" >> $TMPFILE2
  echo "#02 Last updated `date +%F`" >> $TMPFILE2

  sort $TMPFILE2 | sed 's/^#0. /# /g' > $DBFILE

  unix2dos -q $DBFILE
  echo Created $DBFILE

  mv $SCHFILE $LASTOUTFILE
  rm -f $TMPFILE1 $TMPFILE2
  
  if [ -s ../copytosourcetree.sh ]; then
      ../copytosourcetree.sh $DBFILE
  fi
fi

cd $DIR

exit
