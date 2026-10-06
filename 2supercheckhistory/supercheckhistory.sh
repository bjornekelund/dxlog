#!/usr/bin/env bash
CABNAME=$1
FOLDER=$1
AWKFILE=$FOLDER/filter.awk
OUTFILE=$FOLDER/$1.txt
LASTOUTFILE=$FOLDER/old-$1.txt
DBFILE="$FOLDER/`cat $FOLDER/dbfile.txt`"
TMPFILE1=$FOLDER/.rawoutfile
TMPFILE2=$FOLDER/.tmpoutfile
HELPERS=../1helpers/helpers.awk
#set -x

rm -f $OUTFILE

# echo "AWKFILE=$AWKFILE DBFILE=$DBFILE OUTFILE=$OUTFILE"

if [ -s "$FOLDER/schfile.txt" ]; then
  # echo "$FOLDER/schfile.txt exists and is not empty"
  WEBFILES="`cat $FOLDER/schfile.txt`"
  # echo WEBFILES=\"$WEBFILES\"
  for file in $WEBFILES; do
    URL="https://supercheckhistory.com/downloads/N1MM/$file"
    curl -fsSL --connect-timeout 5 --max-time 20 "$URL" -o "$FOLDER/$file" || {\
      echo "ERROR! Download of `basename $file` failed. Aborting." 
      rm -f $FOLDER/$file
      exit 1
    }
    cat $FOLDER/$file >> $TMPFILE1
  done
else
  echo "$FOLDER/schfile.txt is missing or empty"
  exit 1 
fi

sort $TMPFILE1 | uniq > $OUTFILE

dos2unix -q $OUTFILE

if cmp -s $LASTOUTFILE $OUTFILE; then 
    echo "The latest file is already downloaded."
    rm -f $TMPFILE1 $OUTFILE
    exit 0
fi

if [ ! -f $OUTFILE ] || [ $(stat -c%s $OUTFILE 2>/dev/null) -lt 100 ]; then
  echo "ERROR! Download of failed. Aborting." 
  exit 1
else
  echo Downloaded, parsing...

  dos2unix -q $OUTFILE

  gawk -f $HELPERS -f $AWKFILE $OUTFILE > $TMPFILE2
  
  echo "#01 Based on data from https://supercheckhistory.com/" >> $TMPFILE2
  echo "#02 Last updated `date +%F`" >> $TMPFILE2

  sort $TMPFILE2 | sed 's/^#0. /# /g' > $DBFILE

  unix2dos -q $DBFILE
  echo Created $DBFILE

  mv $OUTFILE $LASTOUTFILE
  rm -f $TMPFILE1 $TMPFILE2
  
  # if [ -s ../copytosourcetree.sh ]; then
  #     ../copytosourcetree.sh $DBFILE
  # fi
fi

exit
