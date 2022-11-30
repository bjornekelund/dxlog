#!/bin/bash
INFILE=`ls SACW[\.-]* | tail -1 2> /dev/null`
OUTFILE=SACW_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

gawk '
BEGIN {
  printf("#0 South America Integration Contest database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  FS=","
}
{
  if ($1 ~ /^[0-9,A-Z\/]+$/ && $3 != "" && $3 ~ /^([0-9]?[0-9]|M|QRP|YL)$/) {
    printf("%s=%s\n", $1, $3);
  }
  else if ($0 !~ /^(!|#|$)/ && $3 != "")
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr"
}
END {}' $INFILE | sort | sed 's/^\#. /\# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
