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
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
}' < $1 | sort | sed 's/^\#. /\# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
