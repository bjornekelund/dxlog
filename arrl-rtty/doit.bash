#!/bin/bash
INFILE=`ls ARRLR* | tail -1 2> /dev/null`
echo Parsing $INFILE...
OUTFILE=ARRL_RTTY_db.txt

dos2unix -q $INFILE
gawk '
BEGIN {
  FS=","
}
{
  if ($1 ~ /^[0-9,A-Z\/]+$/ && $3 != "") {
    printf("%s=%s\n", $1, $3);
  }
  else if ($0 !~ /^(!|#|$)/)
    printf("Skipped: \"%s\"\n", $0) > "/dev/stderr"
}
END {
  printf("#0 ARRL RTTY database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly ve2fk@arrl.net\n");
  printf("#3 File last updated %s\n", strftime("%Y-%m-%d"));
}' $INFILE | sort | sed 's/^\#. /\# /g' > $OUTFILE

echo $OUTFILE created
unix2dos -q $OUTFILE
exit
