#!/bin/bash
dos2unix NAQPCW.txt
gawk '
BEGIN {
  FS=","
  date = strftime("%Y-%m-%d");
  printf("#0 NAQP database\n");
  printf("#1 Data collected and maintained by Claude VE2FK ve2fk@arrl.net\n");
  printf("#2 File updated %s\n", date);
}
{
  if ($1 ~ /^[0-9,A-Z]/ && ($2 != "" && $3 != ""))
    printf("%s=%s;%s\n", toupper($1), toupper($2), toupper($3));
  else
    printf("Ignored: %s\n", $0) > "/dev/stderr";
}' NAQPCW.txt | sort | sed 's/#. /# /g' > NAQP_db.txt
unix2dos NAQP_db.txt
