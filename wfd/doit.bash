#!/bin/bash
FILE=`ls WFD-* | tail -1 2> /dev/null`
OUTFILE=WFD_db.txt

echo Parsing $FILE
dos2unix -q $FILE

cat $FILE | tr -d ' \t' | gawk '
BEGIN {
  FS=","
  printf("#0 Winter Field Day database.\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly ve2fk@arrl.net\n");
  printf("#3 File last updated %s\n", strftime("%Y-%m-%d"));
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
      $sect ~ /^(DX|AB|AK|AL|AR|AZ|BC|CA|CO|CT|DE|EB|EMA|ENY|EPA|EWA|FL|GA|GTA|IA|ID|IL|IN|KS|KY|LA|LAX|MA|MAR|MB|MD|MDC|ME|MI|MN|MO|MS|MT|NC|ND|NE|NFL|NH|NJ|NL|NLI|NM|NNJ|NNY|NT|NTX|NV|NY|OH|OK|ON|ONE|ONN|ONS|OR|ORG|PA|PAC|PE|PR|QC|RI|SB|SC|SCV|SD|SDG|SF|SFL|SJV|SK|SNJ|STX|SV|TN|TX|UT|VA|VI|VT|WA|WCF|WI|WMA|WNY|WPA|WTX|WV|WWA|WY|YT)$/) 
        printf("%s=%s;%s\n", $1, $class, $sect);
    else if ($0 !~ /^(!|#|$)/)
      printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}' | sort | uniq | sed 's/#. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
