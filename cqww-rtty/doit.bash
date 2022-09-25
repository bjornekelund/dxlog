#!/bin/bash
INFILE=`ls CQWWRTTY* | tail -1 2> /dev/null`
OUTFILE=CQWWR_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

gawk '
BEGIN {
  FS=","
}
{
  if ($1 ~ /^[0-9,A-Z\/]+$/ && $3 ~ /CT|MA|ME|NH|RI|VT|NJ|NY|DE|PA|MD|DC|AL|FL|GA|Y|NC|SC|TN|VA||AR|LA|MS|NM|OK|TX|CA|AZ|ID|MT|NV|OR|UT|WA|WY|MI|OH|WV|IL|IN|WI|CO|IA|KS|MN|MO|ND|NE|SD|NB|NS|NF|PEI|LB|QC|ON|MB|SK|AB|BC|NU|NWT|YT/) {
    printf("%s=%s\n", $1, $3);
  }
  else if ($0 !~ /^(!|#|$)/)
    printf("Invalid exchange: \"%s\"\n", $0) > "/dev/stderr"
}
END { 
  printf("#0 CQ WW RTTY database - States and provinces but AK HI PR VI not included\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
}' < $INFILE | sort | sed 's/^\#. /\# /g' > $OUTFILE

unix2dos -q $OUTFILE
echo Created $OUTFILE

exit
