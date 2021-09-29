#!/bin/bash
#FILE=CQMMDX.txt
FILE=`ls CQMMDX[^_]* | tail -1 2> /dev/null`
OUTFILE=CQMMDX_db.txt

echo Parsing $FILE...
dos2unix -q $FILE

gawk '
BEGIN {
  FS=","
  date = strftime("%Y-%m-%d");
  printf("#0 CQMM DX database\n");
  printf("#1 Data collected and maintained by Claude VE2FK ve2fk@arrl.net\n");
  printf("#2 Updated %s\n", date);
}
{
  if ($1 ~ /^[0-9,A-Z,\/]+$/ && $2 ~ /^[A-Z]{3}$/)
    printf("%s=%s\n", $1, $2);
  else if ($0 !~ /^(!|#|$)/)
    printf("Skipped: \"%s\"\n", $0) > "/dev/stderr";  
}
END { }' $FILE | sort | sed 's/#. /# /g' > $OUTFILE
unix2dos -q $OUTFILE
echo $OUTFILE created
exit

