#!/bin/bash
#FILE=`ls TRCDX* | tail -1 2> /dev/null`
#echo Using file $FILE
#dos2unix -q $FILE
DBFILE=TRC_db.txt

RAWFILE=TRC_CB2021_0101.txt
dos2unix -q $RAWFILE
TMPFILE=_trcraw.txt

gawk '
BEGIN {
  FS=" "
}
{
  if ($0 ~ /^TRC#/)
    printf("\n%s", $1);
  else if ($1 ~ /[a-zA-Z0-9]/)
    printf(" %s", $0);
}' $RAWFILE > $TMPFILE

gawk -f trc.awk $TMPFILE | sort | sed 's/^\#. /\# /g' > $DBFILE

echo Created $DBFILE
unix2dos -q $DBFILE

exit
