#!/bin/bash
dos2unix $1
gawk '
BEGIN {
  FS=","
}
{
  if ($1 ~ /^[0-9,A-Z\/]+$/ && $2 ~ /[A-Z]{3}/) {
    printf("%s=%s\n", $1, $2);
  }
  else
    printf("Fail: \"%s\"\n", $0) > "/dev/stderr"
}
END { 
  printf("#0 UBA Spring database\n");
  printf("#1 Data collected and maintained by Claude VE2FK ve2fk@arrl.net\n");
  printf("#2 File last updated %s\n", strftime("%Y-%m-%d"));
}' < $1 | sort | sed 's/^\#. /\# /g' > UBA_Spring_db.txt

echo "UBA_Spring_db.txt created"
unix2dos UBA_Spring_db.txt
exit
