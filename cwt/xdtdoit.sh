#!/bin/bash
INFILE=$(ls CWOPS_* | tail -1 2> /dev/null)
XDTFILE=CWOps.xdt
XDTTMP=.xdt

dos2unix -q $INFILE
gawk -f cwtxdt.awk $INFILE | sed 's/  / /g' | sort > $XDTTMP
unix2dos -q $XDTMP $INFILE

if cmp -s $XDTTMP $XDTFILE && [ -z "$1" ]; then
  echo "Nothing new: CWOps XDT"
  rm -f $XDTTMP
else
  mv $XDTTMP $XDTFILE
  echo Created new $XDTFILE
  ../_xdt/upload.sh $XDTFILE
fi

exit 0
