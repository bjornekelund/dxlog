#!/bin/bash
FILE=`ls TESLA_V* | tail -1`
echo Parsing $FILE

dos2unix -q $FILE

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
  else if ($0 !~ /^(!|#|$)/)
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr"
}
END { 
  printf("#0 Tesla Memorial database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly ve2fk@arrl.net\n");
  printf("#3 File last updated %s\n", strftime("%Y-%m-%d"));
}' < $FILE | sort | sed 's/^\#. /\# /g' > TESLA_db.txt

echo "TESLA_db.txt created"
unix2dos TESLA_db.txt
exit
