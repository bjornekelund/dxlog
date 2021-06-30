#!/bin/bash
dos2unix CQ160SSB.txt
gawk '
BEGIN {
  FS=","
}
{
  if ($1 ~ /^[0-9,A-Z\/]+$/ && $3 != "") {
    printf("%s=%s\n", $1, $3);
  }
  else
    printf("Fail: \"%s\"\n", $0) > "/dev/stderr"
}
END { 
  printf("#0 CQ 160M database - States and provinces\n");
  printf("#1 Data collected and maintained by Claude VE2FK ve2fk@arrl.net\n");
  printf("#2 File updated %s\n", strftime("%Y-%m-%d"));
}' < CQ160SSB.txt | sort | sed 's/^\#. /\# /g' > CQ_160M_db.txt

echo "CQ_160M_db.txt created"
unix2dos CQ_160M_db.txt
exit
