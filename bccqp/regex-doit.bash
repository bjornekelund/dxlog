#!/bin/bash
URL=https://www.bavarian-contest-club.de/data
WEBFILE=bcc-members.txt
OUTFILE=BCC-regex.txt

rm -f $WEBFILE
curl -sS $URL/$WEBFILE -O

if [ ! -s $WEBFILE ]; then
  echo "ERROR! Download of $WEBFILE failed. Aborting."
  exit 1
else
  echo Downloaded $WEBFILE, parsing...
  dos2unix -q $WEBFILE

  sed 's/ //g' $WEBFILE | sort | gawk -b -f regex.awk > $OUTFILE

  echo Created $OUTFILE
  unix2dos -q $OUTFILE
fi

exit

