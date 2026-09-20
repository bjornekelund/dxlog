#!/bin/bash
OUTFILE=list-in7qpnede.txt

./do7qplist.sh
./doinlist.sh
./donewelist.sh

cat list-7qp.txt list-in.txt list-newe.txt list-de.txt | sed 's/KDE=/DEK=/g' | sed 's/NDE=/DEN=/g' | sed 's/SDE=/DES=/g' \
  | sort | sed 's/DEK=/KDE=/g' | sed 's/DEN=/NDE=/g' | sed 's/DES=/SDE=/g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
