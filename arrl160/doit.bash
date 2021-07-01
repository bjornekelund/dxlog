#!/bin/bash
dos2unix ARRL160.txt
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
  printf("#0 ARRL 160m database - ARRL/RAC sections\n");
  printf("#1 Data collected and maintained by Claude VE2FK ve2fk@arrl.net\n");
  printf("#2 File last updated %s\n", strftime("%Y-%m-%d"));
}' < ARRL160.txt | sort | sed 's/^\#. /\# /g' > ARRL_160M_db.txt

echo "ARRL_160M_db.txt created"
unix2dos ARRL_160M_db.txt
exit
