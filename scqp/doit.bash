#!/bin/bash
cd $(dirname $0)
FILE=`ls QSOP_* | tail -1 2> /dev/null`
echo Using file \"$FILE\"

dos2unix $FILE
gawk '
BEGIN {
  FS=","
  date = strftime("%Y-%m-%d");
  printf("#0 SCQP database\n");
  printf("#1 Data collected and maintained by Claude VE2FK ve2fk@arrl.net\n");
  printf("#2 File updated %s\n", date);
}
{
  if ($1 ~ /^[0-9,A-Z]/ && $3 ~ /[A-Z]{4}|[A-Z]{2}/)
    printf("%s=%s\n", toupper($1), toupper($3));
  else
    printf("Error: %s\n", $0) > "/dev/stderr";
}' $FILE | sort | sed 's/#./#/g' > SCQP_db.txt
unix2dos SCQP_db.txt
