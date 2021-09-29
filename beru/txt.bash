#!/bin/bash
OUTFILE=BERU_db.txt
gawk '
BEGIN {
  FS=","
  max = 0;
}
{
  if ($1 ~ /[0-9,A-Z]/ && $3 == "HQ")
    printf("%s=%s\n", $1, $3);
}
END {
  printf("#0 BERU HQ stations database\n");
  printf("#1 Based on data collected and maintained by Claude VE2FK ve2fk@arrl.net\n");
  printf("#2 File updated %s\n", strftime("%Y-%m-%d"));
}' < $1 | sort | sed 's/^\#. /\# /g' > $OUTFILE
echo $OUTFILE created
unix2dos -q $OUTFILE
exit
