#!/bin/bash
FILE=`ls WFD_2* | tail -1 2> /dev/null`
OUTFILE=WFD_db.txt

echo Parsing $FILE
dos2unix -q $FILE

cat $FILE | tr -d ' \t' | gawk '
BEGIN {
  FS=","
  printf("#0 Winter Field Day database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  printf("#4 Updated to 2023 RAC sections\n");
  col = 3;
}
{
  if ($1 ~ /!!Order!!/) {
    if ($2 ~ /Sect/) sect = 1;
    if ($3 ~ /Sect/) sect = 2;
    if ($4 ~ /Sect/) sect = 3;
    if ($5 ~ /Sect/) sect = 4;
    if ($2 ~ /Exch1/) class = 1;
    if ($3 ~ /Exch1/) class = 2;
    if ($4 ~ /Exch1/) class = 3;
    if ($5 ~ /Exch1/) class = 4;
    printf("%s --> Section is column %d\n", $0, sect) > "/dev/stderr";
    printf("%s --> Class is column %d\n", $0, class) > "/dev/stderr";
  } else {

    if ($1 ~ /^[0-9,A-Z,\/]+$/ && $class !~ /^\\d+[IOH]$/ && \
      $sect ~ /^(MX|DX|AB|AK|AL|AR|AZ|BC|CO|CT|DE|EB|EMA|ENY|EPA|EWA|GA|GH|IA|ID|IL|IN|KS|KY|LA|LAX|MB|MDC|ME|MI|MN|MO|MS|MT|NB|NC|ND|NE|NFL|NH|NL|NLI|NM|NNJ|NNY|NS|NTX|NV|OH|OK|ONE|ONN|ONS|OR|ORG|PAC|PE|PR|QC|RI|SB|SC|SCV|SD|SDG|SF|SFL|SJV|SK|SNJ|STX|SV|TER|TN|UT|VA|VI|VT|WCF|WI|WMA|WNY|WPA|WTX|WV|WWA|WY)$/) 
        printf("%s=%s;%s\n", $1, $class, $sect);
    else if ($0 !~ /^(!|#|$)/)
      printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}' | sort | sed 's/#. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
