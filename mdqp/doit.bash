#!/bin/bash
FILE=`ls NAQ* | tail -1 2> /dev/null`
OUTFILE=MDQP_db.txt

echo Parsing $FILE...

dos2unix -q $FILE
gawk '
BEGIN {
  FS=","
  date = strftime("%Y-%m-%d");
  printf("#0 MD-DC QP database.\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly ve2fk@arrl.net\n");
  printf("#3 File last updated %s\n", strftime("%Y-%m-%d"));
}
{
  call = toupper($1);
  state = toupper($3);
  if (call ~ /^[0-9,A-Z]/ && state ~ /^(AL|AK|AZ|AR|CA|CO|CT|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY|NL|LB|NF|NB|NS|PE|PEI|QC|ON|MB|SK|AB|BC|NT|NU|YT|ALY|ANA|BAL|BCT|CLV|CLN|CRL|CEC|CHS|DRC|FRD|GAR|HFD|HWD|KEN|MON|PGE|QAN|STM|SMR|TAL|WAS|WIC|WRC|WDC)$/)
    printf("%s=%s\n", toupper($1), toupper($3));
  else if ($0 !~ /^(!|#|$)/)
    printf("Invalid exchange: %s\n", $0) > "/dev/stderr";
}' $FILE | sort | sed 's/^#./#/g' > MDQP_db.txt
unix2dos $OUTFILE
