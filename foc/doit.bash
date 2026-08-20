#!/bin/bash
DBFILE=FOC_db.txt
XDTFILE=foc.xdt

rm -f $XDTFILE
curl -s https://foc.telegraphy.de/db/$XDTFILE -O

if [ ! -f $XDTFILE ] || [ $(stat -c%s $XDTFILE 2>/dev/null) -lt 1000 ]; then
  echo "ERROR! Download of $XDTFILE failed. Aborting."
  exit 1
else
    unix2dos -q $XDTFILE
    echo Downloaded $XDTFILE
    cp $XDTFILE ../xdt
fi

rm -f $DBFILE
curl -s https://foc.telegraphy.de/db/$DBFILE -O

if [ ! -f $DBFILE ] || [ $(stat -c%s $DBFILE 2>/dev/null) -lt 1000 ]; then
  echo "ERROR! Download of $DBFILE failed. Aborting."
  exit 1
else
    echo Downloaded $DBFILE
    gawk 'BEGIN{FS = ";";max=0;}{max=($0!~/^#/&&$2>max)?$2:max;}END{printf("Highest member number is %d\n",max);}' $DBFILE
    unix2dos -q $DBFILE
    ../copytosourcetree.bash $DBFILE
fi

exit

