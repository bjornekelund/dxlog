#!/bin/bash
dos2unix ARRL10M.txt
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
  printf("#0 ARRL 10m database\n");
  printf("#1 Data collected and maintained by Claude VE2FK ve2fk@arrl.net\n");
  printf("#2 File last updated %s\n", strftime("%Y-%m-%d"));
}' < ARRL10M.txt | sort | sed 's/^\#. /\# /g' > ARRL_10M_DB.txt

echo "ARRL_10M_DB.txt created"
unix2dos ARRL_10M_DB.txt
exit
