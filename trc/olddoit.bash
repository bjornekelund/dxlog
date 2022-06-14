#!/bin/bash
FILE=`ls TRCDX* | tail -1 2> /dev/null`
DBFILE=TRC_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk '
BEGIN {
  FS=","
}
{
  if ($1 ~ /^[0-9,A-Z\/]+$/ && $2 != "") {
    printf("%s=%s\n", $1, $2);
  }
  else
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr"
}
END { 
  printf("#0 TRC members database\n");
  printf("#1 Data collected and maintained by Claude VE2FK ve2fk@arrl.net\n");
  printf("#2 Last updated %s\n", strftime("%Y-%m-%d"));
}' $FILE | sort | sed 's/^\#. /\# /g' > $DBFILE

echo Created $DBFILE
unix2dos -q $DBFILE

exit
