#!/bin/bash
DBFILE=HSC_db.txt
XDTFILE=hsc.xdt

rm -f $XDTFILE
curl -s https://hsc.dj1yfk.de/db/$XDTFILE -O
unix2dos -q $XDTFILE

if [ ! -f $XDTFILE ] || [ $(stat -c%s $XDTFILE 2>/dev/null) -lt 1000 ]; then
    echo "ERROR! Download of $XDTFILE failed. Aborting."
    exit 1
else
    echo "Downloaded $XDTFILE"
    cp $XDTFILE ../xdt
fi

rm -f $DBFILE
curl -s https://hsc.dj1yfk.de/db/$DBFILE -O

if [ ! -f $DBFILE ] || [ $(stat -c%s $DBFILE 2>/dev/null) -lt 1000 ]; then
    echo "ERROR! Download of $DBFILE failed. Aborting."
    exit 1
else
    echo "Downloaded $DBFILE"
    gawk 'BEGIN{FS = "=";max=0;}{max=($0!~/^#/&&$2>max)?$2:max;}END{printf("Highest member number is %d\n",max);}' $DBFILE
    unix2dos -q $DBFILE
    ../copytosourcetree.sh $DBFILE
fi

exit
