#!/bin/bash
#FILE=`ls TRCDX* | tail -1 2> /dev/null`
#echo Using file $FILE
#dos2unix -q $FILE
DBFILE=TRC_db.txt

RAWFILE=TRCRAW.txt
dos2unix -q $RAWFILE
TMPFILE=TRCTEMP.txt

gawk '
BEGIN {
  FS = " ";
}
{
  if ($0 ~ /^TRC#/ && $0 !~ /SWL/ && $2 != "CB" && $2 !~ /-/ && $2 != "")
    printf("%s,TRC\n", $2);
}' $RAWFILE > $TMPFILE

gawk -f trc.awk $TMPFILE | sort | sed 's/^\#. /\# /g' > $DBFILE

echo Created $DBFILE
unix2dos -q $DBFILE

exit
