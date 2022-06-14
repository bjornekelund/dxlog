#!/bin/bash
FILE=../naqp/NAQPCW.txt
OUTFILE=NHQP_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk '
BEGIN {
  FS=","
  printf("#0 NHQP database\n");
  printf("#1 Based on NAQP database maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly ve2fk@arrl.net\n");
  printf("#3 File last updated %s\n", strftime("%Y-%m-%d"));
  maxlen = 0;
  longest = "";
}
{
  if ($1 ~ /^[0-9,A-Z]/ && $3 ~ /^(AL|AK|AZ|AR|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MO|MS|MT|NE|NV|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY|AB|BC|LB|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/) {
    printf("%s=%s\n", toupper($1), toupper($3));
  }
  else if ($0 !~ /^(!|#|$)/)
    printf("Invalid exchange: %s\n", $0) > "/dev/stderr";
}
END {
}' $FILE | sort | sed 's/#. /# /g' | uniq > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
