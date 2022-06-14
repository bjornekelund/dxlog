#!/bin/bash
FILE=`ls QSOP_CP* | tail -1 2> /dev/null`
OUTFILE=CPQP_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk '
BEGIN {
  FS=","
  printf("#0 Database for Canadian Prairies QSO Party\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
}
{
  if ($1 ~ /^[0-9A-Z]+$/ && $3 ~ /^(AL|AK|AZ|AR|CA|CO|CT|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MA|MD|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY|NL|NB|NS|PE|QC|ON|BC|NT|NU|YT|BAR|BOW|BRC|CCE|CCF|CFL|CHE|CMD|CNH|CRR|CSD|CSH|CSK|EDC|EDG|EDM|EDW|EMW|ERB|EST|EWE|FTH|FTM|GPM|LAK|LTH|MED|PRW|RDL|RDM|SPK|STA|STR|YEL|BTL|CAR|CYP|DES|MOO|PRA|RGL|RGQ|RGW|SKG|SKU|SKW|SOU|YOR|BRS|CHA|CHR|DAU|ELM|KIL|POR|PRO|SEL|STB|WPC|WPN|WPS|WSC)$/) {
    printf("%s=%s\n", $1, $3);
  }
  else if ($0 !~ /^(!|#|$)/)
    printf("Invalid exchange: %s\n", $0) > "/dev/stderr";
}
END {
}' $FILE | sort | sed 's/#. /# /g' | uniq > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
