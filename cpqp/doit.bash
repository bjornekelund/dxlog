#!/bin/bash
FILE=QSOP_CP.txt
OUTFILE=CPQP_db.txt

echo "Parsing" $FILE
dos2unix -q $FILE

gawk '
BEGIN {
  FS=","
  date = strftime("%Y-%m-%d");
  printf("#0 Database for Canadian Prairies QSO Party\n");
  printf("#1 Data collected and maintained by Claude VE2FK ve2fk@arrl.net\n");
  printf("#2 File updated %s\n", date);
  maxlen = 0;
  longest = "";
}
{
  if ($1 ~ /^[0-9A-Z]+$/ && $3 !~ /^(\s*|MB|SK|AB)$/) {
    printf("%s=%s\n", $1, $3);
  }
  else if ($0 !~ /^(!|#|$)/)
    printf("Ignored: %s\n", $0) > "/dev/stderr";
}
END {
}' $FILE | sort | sed 's/#. /# /g' | uniq > $OUTFILE
echo "Created" $OUTFILE
unix2dos -q $OUTFILE

exit
