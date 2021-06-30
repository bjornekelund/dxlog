#!/bin/bash
dos2unix WWPMC.txt
gawk '
BEGIN {
  FS=","
}
{
  if ($1 ~ /^[0-9,A-Z\/]+$/ && $2 != "") {
    printf("%s=%s\n", $1, $2);
  }
  else
    printf("Fail: \"%s\"\n", $0) > "/dev/stderr"
}
END { 
  printf("#0 WW PMC database\n");
  printf("#1 Data collected and maintained by Claude VE2FK ve2fk@arrl.net\n");
  printf("#2 File last updated %s\n", strftime("%Y-%m-%d"));
}' < WWPMC.txt | sort | sed 's/^\#. /\# /g' > WWPMC_db.txt

echo "WWPMC_db.txt created"
unix2dos WWPMC_db.txt
exit
