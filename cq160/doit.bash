#!/bin/bash
INFILE=`ls CQ160* | tail -1 2> /dev/null`
OUTFILE=CQ160_db.txt
echo Using $INFILE
dos2unix -q $INFILE

gawk '
BEGIN {
  FS=","
}
{
  if ($1 ~ /^[0-9,A-Z\/]+$/ && $3 != "" && $3 ~ /CT|MA|ME|NH|RI|VT|NJ|NY|DE|PA|MD|DC|AL|FL|GA|KY|NC|SC|TN|VA|AR|LA|MS|NM|OK|TX|CA|AZ|ID|MT|NV|OR|UT|WA|WY|MI|OH|WV|IL|IN|WI|CO|IA|KS|MN|MO|ND|NE|SD|NB|NS|NF|PE|PEI|LB|QC|ON|MB|SK|AB|BC|NU|NT|NWT|YT|YUK/) {
    exch = $3;
    if ($3 == "YUK") exch = "YT";
    if ($3 == "NWT") exch = "NT";
    if ($3 == "PEI") exch = "PE";
    printf("%s=%s\n", $1, exch);
  }
  else if ($0 !~/^(!|#|$)/)
    printf("Skipped: \"%s\"\n", $0) > "/dev/stderr"
}
END {
  printf("#0 CQ 160M database - States and provinces\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly ve2fk@arrl.net\n");
  printf("#3 File last updated %s\n", strftime("%Y-%m-%d"));
}' $INFILE | sort | sed 's/^\#. /\# /g' > $OUTFILE

echo $OUTFILE "created"
unix2dos -q $OUTFILE
exit
