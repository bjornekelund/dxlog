#!/bin/bash
INFILE=`ls ARRL160* | tail -1 2> /dev/null`
OUTFILE=ARRL_160M_db.txt
echo Using $INFILE
dos2unix -q $INFILE

gawk '
BEGIN {
  FS=",";
}
{
  if ($1 ~ /^[0-9,A-Z\/]+$/ && $2 ~ /^(AK|AL|AR|AZ|CO|CT|DE|EB|EMA|ENY|EPA|EWA|GA|IA|ID|IL|IN|KS|KY|LA|LAX|MDC|ME|MI|MN|MO|MS|MT|NC|ND|NE|NFL|NH|NLI|NM|NNJ|NNY|NTX|NV|OH|OK|OR|ORG|PAC|PR|RI|SB|SC|SCV|SD|SDG|SF|SFL|SJV|SNJ|STX|SV|TN|UT|VA|VI|VT|WCF|WI|WMA|WNY|WPA|WTX|WV|WWA|WY|AB|BC|GTA|MAR|MB|NL|NT|ONE|ONN|ONS|PE|QC|SK)$/) {
    printf("%s=%s\n", $1, $2);
  }
  else if ($0 !~ /^(!|#|$)/)
    printf("Invalid exchange: \"%s\"\n", $0) > "/dev/stderr"
}
END {
  printf("#0 ARRL 160m database - ARRL/RAC sections\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly ve2fk@arrl.net\n");
  printf("#3 File last updated %s\n", strftime("%Y-%m-%d"));
}' $INFILE | sort | sed 's/^\#. /\# /g' > $OUTFILE

echo $OUTFILE "created"
unix2dos -q $OUTFILE
exit
