#!/bin/bash
cd $(dirname $0)
INFILE=`ls ARRL10M* | tail -1 2> /dev/null`
OUTFILE=ARRL_10M_db.txt
echo Using $INFILE
dos2unix -q $INFILE

gawk '
BEGIN {
  FS=","
}
{
  if ($1 ~ /^[0-9,A-Z\/]+$/ && $3 != "") {
    printf("%s=%s\n", $1, $3);
  }
  else
    printf("Skipped: \"%s\"\n", $0) > "/dev/stderr"
}
END {
  printf("#0 ARRL 10m database\n");
  printf("#1 Data collected and maintained by Claude VE2FK ve2fk@arrl.net\n");
  printf("#2 File last updated %s\n", strftime("%Y-%m-%d"));
}' $INFILE | sort | sed 's/^\#. /\# /g' > $OUTFILE

echo $OUTFILE "created"
unix2dos -q $OUTFILE
exit
