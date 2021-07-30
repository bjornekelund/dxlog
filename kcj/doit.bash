#!/bin/bash
dos2unix KCJ.txt
gawk '
BEGIN {
  FS=","
  date = strftime("%Y-%m-%d");
  printf("#0 KCJ contest database\n");
  printf("#1 Data collected and maintained by UR7QM\n");
  printf("#2 File updated %s\n", date);
}
{
  if ($1 ~ /^[0-9,A-Z]/ && $2 != "")
    printf("%s=%s\n", toupper($1), toupper($2));
  else
    printf("Ignored: %s\n", $0) > "/dev/stderr";
}' KCJ.txt | sort | sed 's/#. /# /g' > KCJ_db.txt
unix2dos KCJ_db.txt
