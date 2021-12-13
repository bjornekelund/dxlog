#!/bin/bash
FILE=`ls INORC.* | tail -1 2> /dev/null`
OUTFILE=INORC_db.txt
echo Parsing $FILE...
dos2unix -q $FILE

gawk '
BEGIN {
  FS=","
}
{
  if ($1 ~ /^[0-9,A-Z\/]+$/ && $2 ~ /^[A-Z0-9]{3,7}$/ && $3 ~ /^[A-Z]+$/) {
    printf("%s=%s;%s\n", $1, $2, $3);
  }
  else
    if ($0 !~ /^(!|#|$)/) {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr"
  }
}
END {
  printf("#0 Database for INORC Contest\n");
  printf("#1 Data collected and maintained by Claude VE2FK ve2fk@arrl.net\n");
  printf("#2 Updated %s\n", strftime("%Y-%m-%d"));
}' < $FILE | sort | sed 's/^\#. /\# /g' > $OUTFILE

echo $OUTFILE created
unix2dos -q $OUTFILE
exit
