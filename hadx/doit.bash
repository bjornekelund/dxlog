#!/bin/bash
dos2unix HADX.txt
gawk '
BEGIN {
  FS=","
}
{
  if ($1 ~ /^[0-9,A-Z\/]+$/ && $2 != "") {
    printf("%s=%s\n", $1, $2);
  }
  else
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr"
}
END {
  printf("#0 HA DX database\n");
  printf("#1 Data collected and maintained by Claude VE2FK ve2fk@arrl.net\n");
  printf("#2 File updated %s\n", strftime("%Y-%m-%d"));
}' < HADX.txt | sort | sed 's/^\#. /\# /g' > HADX_db.txt

echo "HADX_db.txt created"
unix2dos HADX_db.txt
exit
