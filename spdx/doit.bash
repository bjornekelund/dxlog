#!/bin/bash

FILE=`ls SPDX[^_]* | tail -1 2> /dev/null`
OUTFILE=SPDX_db.txt

dos2unix -q $FILE
echo Parsing $FILE

gawk '
BEGIN {
  FS=","
  max = 0;
}
{
  if ($1 ~ /^[0-9A-Z\/]+$/ && $2 ~/^[BCDFGJKLMOPRSUWZ]$/)
    printf("%s=%s\n", $1, $2);
  else if ($0 !~ /^(!|#|$)/)
    printf("Ignored: %s\n", $0) > "/dev/stderr";
}
END { 
  printf("#0 SP DX participants database\n");
  printf("#1 Based on call history data by Chris SP5KP, SN5N\n");
  printf("#2 Last updated %s\n", strftime("%Y-%m-%d"));
}' $FILE | sort | sed 's/^\#. /\# /g' > $OUTFILE

unix2dos -q $OUTFILE
echo Created $OUTFILE

exit
