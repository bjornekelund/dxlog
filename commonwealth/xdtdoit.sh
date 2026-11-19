#!/bin/bash
INFILE=$(ls RSGBBERU* | tail -1)
XDTFILE=COMMONW.xdt
XDTTMP=.xdtfile

dos2unix -q $INFILE
gawk -f xdt.awk $INFILE | sed 's/  / /g' | sort > $XDTTMP
unix2dos -q $XDTTMP $INFILE

if cmp -s $XDTTMP $XDTFILE && [ -z "$1" ]; then 
  echo "Nothing new: Commonwealth XDT"
  rm -f $XDTTMP
else
  mv $XDTTMP $XDTFILE
  echo Created new $XDTFILE
  ../_xdt/upload.sh $XDTFILE
fi
exit
