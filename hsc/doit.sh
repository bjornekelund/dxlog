#!/bin/bash
DBFILE=HSC_db.txt
XDTFILE=hsc.xdt
DOWNLOAD=.downloaded

# rm -f $DBFILE
curl -s https://hsc.dj1yfk.de/db/$DBFILE -o $DOWNLOAD

if [ ! -f $DOWNLOAD ] || [ $(stat -c%s $DOWNLOAD 2>/dev/null) -lt 200 ]; then
    echo "ERROR! Download of $DBFILE failed. Aborting."
    exit 1
else
  unix2dos -q $DOWNLOAD

  if cmp -s $DBFILE $DOWNLOAD && [ -z "$1" ]; then 
    echo "Nothing new: FOC"
    rm -f $DOWNLOAD
  else
    mv $DOWNLOAD $DBFILE
    echo Downloaded $DBFILE
    gawk 'BEGIN{FS = "=";max=0;}{max=($0!~/^#/&&$2>max)?$2:max;}END{printf("Highest member number is %d\n",max);}' $DBFILE
    unix2dos -q $DBFILE
    ../copytosourcetree.sh $DBFILE
    ../_helpers/uploaddb.sh $DBFILE
  fi
fi

curl -s https://hsc.dj1yfk.de/db/$XDTFILE -o $DOWNLOAD
dos2unix -q $DOWNLOAD

if [ ! -f $DOWNLOAD ] || [ $(stat -c%s $DOWNLOAD 2>/dev/null) -lt 200 ]; then
    echo "ERROR! Download of $XDTFILE failed. Aborting."
    exit 1
else
  unix2dos -q $DOWNLOAD

  if cmp -s $XDTFILE $DOWNLOAD && [ -z "$1" ]; then 
    echo "Nothing new: HSC XDT"
    rm -f $DOWNLOAD
    exit 0
  else
    mv $DOWNLOAD $XDTFILE
    echo Downloaded $XDTFILE
    ../_xdt/upload.sh $XDTFILE
  fi
fi

exit
