#!/bin/bash
#FILE=CQMMDX.txt
FILE=`ls CQMMDX[^_]* | tail -1 2> /dev/null`
OUTFILE=CQMMDX_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk '
BEGIN {
  FS=","
  printf("#0 CQMM DX database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
}
{
  if ($1 ~ /^[0-9,A-Z,\/]+$/ && $2 ~ /^(AF|EU|AS|SA|NA|OC)(M|C|Q|Y|M)$/)
    printf("%s=%s\n", $1, $2);
  else if ($0 !~ /^(!|#|$)/)
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
}
END { }' $FILE | sort | sed 's/#. /# /g' > $OUTFILE

unix2dos -q $OUTFILE
echo $OUTFILE created

exit
