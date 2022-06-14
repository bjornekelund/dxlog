#!/bin/bash
FILE=HADX.txt
OUTFILE=HADX_db.txt

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
  else if ($0 !~ /^(!|#|$)/)
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr"
}
END {
  printf("#0 HA DX database\n");
  printf("#1 Data collected and maintained by HA2NA ha2na@ha2na.hu\n");
  printf("#2 File updated %s\n", strftime("%Y-%m-%d"));
}' < $FILE | sort | sed 's/^\#. /\# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q HADX_db.txt

exit
