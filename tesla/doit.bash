#!/bin/bash
dos2unix $1
gawk '
BEGIN {
  FS=",";
  prevcall = "";
}
{
  call = $1;
  if (call ~ /^[0-9,A-Z\/]+$/) {
    if ($3 != "")
      printf("%s=%s\n", $1, $3);
    else
      printf("Info missing: \"%s\"\n", $0) > "/dev/stderr"
  }
  else
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr"
}
END { 
  printf("#0 Tesla Memorial database\n");
  printf("#1 Data collected and maintaned by Claude VE2FK ve2fk@arrl.net\n");
  printf("#2 File last updated %s\n", strftime("%Y-%m-%d"));
}' < $1 | sort | sed 's/^\#. /\# /g' > TESLA_db.txt

echo "TESLA_db.txt created"
unix2dos TESLA_db.txt
exit
