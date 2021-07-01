#!/bin/bash
dos2unix AGCW.txt
gawk '
BEGIN {
  FS=","
}
{
  if ($1 ~ /^[0-9,A-Z\/]+$/ && $3 ~/[0-9]+/) {
    printf("%s=%s\n", $1, $3);
  }
  else
    printf("Fail: \"%s\"\n", $0) > "/dev/stderr"
}
END {
  printf("#0 AGCW members database\n");
  printf("#1 Data collected and maintained by Claude VE2FK ve2fk@arrl.net\n");
  printf("#2 File last updated %s\n", strftime("%Y-%m-%d"));
}' < AGCW.txt | sort | sed 's/^\#. /\# /g' > AGCW_db.txt

echo "AGCW_db.txt created"
unix2dos AGCW_db.txt
exit
