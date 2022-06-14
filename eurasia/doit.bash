#!/bin/bash
FILE=`ls EUAS-CH* | tail -1 2> /dev/null`
OUTFILE=EURASIA_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk '
BEGIN {
  FS=","
}
{
  if ($1 ~ /^[0-9,A-Z\/]+$/ && $3 ~ /^[A-Ra-r]{2}[0-9]{2}[A-Xa-x]{2}$/) {
    printf("%s=%s\n", $1, toupper($3));
  }
  else if ($0 !~ /^(!|#|$)/)
    printf("Skipped: \"%s\"\n", $0) > "/dev/stderr"
}
END {
  printf("#0 EURASIA Championship database - 6-position grid locator\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly ve2fk@arrl.net\n");
  printf("#3 File last updated %s\n", strftime("%Y-%m-%d"));
}' $FILE | sort | sed 's/^\#. /\# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
