#!/bin/bash
FILE=`ls UKEIDX* | tail -1 2> /dev/null`
OUTFILE=ukeidx_db.txt

echo "Parsing" $FILE
dos2unix -q $FILE

gawk '
BEGIN {
  FS=","
  date = strftime("%Y-%m-%d");
  printf("#0 Database for UKEI DX Contest\n");
  printf("#1 Data collected and maintained by Claude VE2FK ve2fk@arrl.net\n");
  printf("#2 File updated %s\n", date);
  maxlen = 0;
  longest = "";
}
{
  if ($1 ~ /^[0-9A-Z\/]+$/ && $2 ~ /^[A-Z]{2}$/)
    printf("%s=%s\n", $1, $2);
  else if ($0 !~ /^(!|#|$)/ && $2 != "")
    printf("Ignored: %s\n", $0) > "/dev/stderr";
}
END {
}' $FILE | sort | sed 's/#. /# /g' | uniq > $OUTFILE
echo "Created" $OUTFILE
unix2dos -q $OUTFILE

exit
