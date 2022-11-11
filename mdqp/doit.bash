#!/bin/bash
FILE=`ls ../naqp/NAQP[^_]* | tail -1 2> /dev/null`
OUTFILE=MDQP_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk '
BEGIN {
  FS=","
  printf("#0 Maryland-DC QSO Party database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
}
{
  call = toupper($1);
  state = toupper($3);
  if (call ~ /^[0-9A-Z]/ && state ~ /^(AL|AK|AZ|AR|CA|CO|CT|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY|NL|LB|NF|NB|NS|PE|PEI|QC|ON|MB|SK|AB|BC|NT|NU|YT|ALY|ANA|BAL|BCT|CLV|CLN|CRL|CEC|CHS|DRC|FRD|GAR|HFD|HWD|KEN|MON|PGE|QAN|STM|SMR|TAL|WAS|WIC|WRC|WDC)$/)
    printf("%s=%s\n", toupper($1), toupper($3));
  else if ($0 !~ /^(!|#|$)/ && state !~ /^(MD|DC)$/)
    printf("Ignored: %s\n", $0) > "/dev/stderr";
}' $FILE | sort | sed 's/^#./#/g' > MDQP_db.txt

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
