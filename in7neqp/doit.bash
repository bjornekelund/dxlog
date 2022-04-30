#!/bin/bash
FILE=`ls QSOP* | tail -1 2> /dev/null`
OUTFILE=IN7NEQP_db.txt
echo Parsing $FILE...

dos2unix -q $FILE

gawk '
BEGIN {
  FS=","
  printf("#0 INQP, DEQP, 7QP, and NEQP joint database.\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly ve2fk@arrl.net\n");
  printf("#3 File last updated %s\n", strftime("%Y-%m-%d"));
}
{
  state = $3 ~ /^(DX|CT|MA|ME|NH|RI|VT|NJ|NY|DE|PA|MD|DC|AL|FL|GA|KY|NC|SC|TN|VA|AR|LA|MS|NM|OK|TX|CA|HI|AK|AZ|ID|MT|NV|OR|UT|WA|WY|MI|OH|WV|IL|WI|CO|IA|KS|MN|MO|ND|NE|SD|NB|NS|QC|ON|MB|SK|AB|BC|NT|NL|NF|YT|PE|NU)$/;
  cnty1 = $3 ~ /^(IN|CT|MA|ME|NH|RI|VT|NJ|NY|DE|PA|MD|DC|AL|FL|GA|KY|NC|SC|TN|VA|AR|LA|MS|NM|OK|TX|CA|HI|AK|AZ|ID|MT|NV|OR|UT|WA|WY|MI|OH|WV|IL|WI|CO|IA|KS|MN|MO|ND|NE|SD|NB|NS|QC|ON|MB|SK|AB|BC|NT|NL|NF|YT|PE|NU)\S\S\S$/;
  cnty2 = $3 ~ /^\S\S\S(IN|CT|MA|ME|NH|RI|VT|NJ|NY|DE|PA|MD|DC|AL|FL|GA|KY|NC|SC|TN|VA|AR|LA|MS|NM|OK|TX|CA|HI|AK|AZ|ID|MT|NV|OR|UT|WA|WY|MI|OH|WV|IL|WI|CO|IA|KS|MN|MO|ND|NE|SD|NB|NS|QC|ON|MB|SK|AB|BC|NT|NL|NF|YT|PE|NU)$/;
  if ($1 ~ /^[0-9,A-Z,\/]+$/ && (state || cnty1 || cnty2))
    printf("%s=%s\n", $1, $3);
  else if ($0 !~ /^(!|#|$)/ && $3 != "")
    printf("Invalid exchange: %s\n", $0) > "/dev/stderr";
}' $FILE | sort | sed 's/^#[0-9]/#/g' > $OUTFILE
echo Created $OUTFILE
unix2dos -q $OUTFILE
exit
