#!/bin/bash
dos2unix $1
gawk '
BEGIN {
  FS=","
  date = strftime("%Y-%m-%d");
  printf("#0 CQMM DX database\n");
  printf("#1 Data collected and maintained by Claude VE2FK ve2fk@arrl.net\n");
  printf("#2 File last updated %s\n", date);
}
{
#  if ($1 ~ /^[0-9,A-Z,\/]$/ && $3 ~ /[A-Z]{2}/)
#  printf("$1=\"%s\"\n", $1) > "/dev/stderr";
  if ($1 ~ /^[0-9,A-Z,\/]+$/ && $2 ~ /^[A-Z]{3}$/)
    printf("%s=%s\n", $1, $2);
  else
    printf("Bad data: \"%s\"\n", $0) > "/dev/stderr";
  
}
END { }' $1 | sort | sed 's/#. /# /g' > CQMMDX_db.txt
unix2dos CQMMDX_db.txt
