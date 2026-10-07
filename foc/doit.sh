#!/bin/bash
DBFILE=FOC_db.txt
XDTFILE=foc.xdt
DOWNLOAD=.downloaded

# rm -f $XDTFILE
curl -s https://foc.telegraphy.de/db/$XDTFILE -o $DOWNLOAD

if [ ! -f $DOWNLOAD ] || [ $(stat -c%s $DOWNLOAD 2>/dev/null) -lt 200 ]; then
  echo "ERROR! Download of $XDTFILE failed. Aborting."
  exit 1
else
  unix2dos -q $DOWNLOAD

  if cmp -s $XDTFILE $DOWNLOAD && [ -z "$1" ]; then 
      echo "The latest xdt file is already downloaded."
      rm -f $DOWNLOAD
  else
    mv $DOWNLOAD $XDTFILE
    echo Downloaded $XDTFILE
    cp $XDTFILE ../3xdt
  fi
fi

# rm -f $DBFILE
curl -s https://foc.telegraphy.de/db/$DBFILE -o $DOWNLOAD

if [ ! -f $DOWNLOAD ] || [ $(stat -c%s $DOWNLOAD 2>/dev/null) -lt 200 ]; then
  echo "ERROR! Download of $DBFILE failed. Aborting."
  exit 1
else
  unix2dos -q $DOWNLOAD

  if cmp -s $DBFILE $DOWNLOAD && [ -z "$1" ]; then 
      echo "The latest db file is already downloaded."
      rm $DOWNLOAD
      exit 0
  fi

  mv $DOWNLOAD $DBFILE
  echo Downloaded $DBFILE
  gawk 'BEGIN{FS = ";";max=0;}{max=($0!~/^#/&&$2>max)?$2:max;}END{printf("Highest member number is %d\n",max);}' $DBFILE
  unix2dos -q $DBFILE
  ../copytosourcetree.sh $DBFILE
fi

exit 0

