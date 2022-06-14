#!/bin/bash
FILE=`ls RAEM-* | tail -1 2> /dev/null`
OUTFILE=RAEM_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk '
BEGIN {
  FS=","
}
{
  if ($1 ~ /^[0-9A-Z\/]+$/ && $2 ~ /^[0-9A-Z]{5,7}$/) {
    printf("%s=%s\n", $1, $2);
  }
  else
    if ($0 !~ /^(!|#|$)/) {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr"
  }
}
END {
  printf("#0 Database for RAEM International Contest\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly ve2fk@arrl.net\n");
  printf("#3 File last updated %s\n", strftime("%Y-%m-%d"));
}' < $FILE | sort | sed 's/^\#. /\# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
