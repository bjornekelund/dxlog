#!/bin/bash
dos2unix TRCDX.txt
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
  printf("#0 TRC members database\n");
  printf("#1 Data collected and maintained by Claude VE2FK ve2fk@arrl.net\n");
  printf("#2 File last updated %s\n", strftime("%Y-%m-%d"));
}' < TRCDX.txt | sort | sed 's/^\#. /\# /g' > TRC_db.txt

echo "TRC_db.txt created"
unix2dos TRC_db.txt
exit
