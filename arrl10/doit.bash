#!/bin/bash
INFILE=`ls ARRL10M* | tail -1 2> /dev/null`
OUTFILE=ARRL_10M_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

gawk '
BEGIN {
  FS=","
}
{
  if ($1 ~ /^[0-9,A-Z\/]+$/ && $3 ~ /^(AL|AK|AZ|AR|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY|AB|BC|LB|MB|NB|NF|NS|NT|NU|ON|PE|QC|SK|YT|AGS|BAC|BCS|CAM|CHI|CHH|CMX|COA|COL|DGO|EMX|GTO|GRO|HGO|JAL|MIC|MOR|NAY|NLE|OAX|PUE|QRO|QUI|SLP|SIN|SON|TAB|TAM|TLX|VER|YUC|ZAC)$/) {
    printf("%s=%s\n", $1, $3);
  }
  else if ($0 !~ /^(!|#|$)/)
    printf("Invalid exchange: \"%s\"\n", $0) > "/dev/stderr"
}
END {
  printf("#0 ARRL 10m database - ARRL/RAC/XE sections\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly ve2fk@arrl.net\n");
  printf("#3 File last updated %s\n", strftime("%Y-%m-%d"));
}' $INFILE | sort | sed 's/^\#. /\# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
