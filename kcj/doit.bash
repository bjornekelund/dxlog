#!/bin/bash
FILE=KCJ.txt
DBFILE=KCJ_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk '
BEGIN {
  FS=","
  printf("#0 KCJ contest database\n");
  printf("#1 Data collected and maintained by UR7QM\n");
  printf("#2 Last updated %s\n", strftime("%Y-%m-%d"));
}
{
  if ($1 ~ /^[0-9,A-Z]/ && $2 != "")
    printf("%s=%s\n", toupper($1), toupper($2));
  else if ($0 !~ /^(#|!|$)/)
    printf("Ignored: %s\n", $0) > "/dev/stderr";
}' KCJ.txt | sort | sed 's/#. /# /g' > $DBFILE

echo Created $DBFILE
unix2dos -q $DBFILE

exit

