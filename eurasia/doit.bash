#!/bin/bash
dos2unix EUAS-CHAMP.txt
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
  printf("#0 EURASIA Championship CQ 160M atabase - 6-position grid locator\n");
  printf("#1 Data collected and maintained by Claude VE2FK ve2fk@arrl.net\n");
  printf("#2 File updated %s\n", strftime("%Y-%m-%d"));
}' < EUAS-CHAMP.txt | sort | sed 's/^\#. /\# /g' > EURASIA_db.txt

echo "EURASIA_db.txt created"
unix2dos EURASIA_db.txt
exit
