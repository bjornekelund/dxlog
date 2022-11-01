#!/bin/bash
INFILE=`ls FD* | tail -1 2> /dev/null`
OUTFILE=ARRL_FD_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

cat $INFILE | gawk '
BEGIN {
  printf("#0 ARRL Field Day database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  FS=",";
}
{
#   printf("$1=%s $2=%s $3=%s\n", $1, $2, $3) > "/dev/stderr";
   if ($1 ~ /^[0-9A-Z]/ && $2 ~ /^[1-9][0-9]?[A-Z]$/ && $3 ~ /^(DX|AK|AL|AR|AZ|CO|CT|DE|EB|EMA|ENY|EPA|EWA|GA|IA|ID|IL|IN|KS|KY|LA|LAX|MDC|ME|MI|MN|MO|MS|MT|NC|ND|NE|NFL|NH|NLI|NM|NNJ|NNY|NTX|NV|OH|OK|OR|ORG|PAC|PR|RI|SB|SC|SCV|SD|SDG|SF|SFL|SJV|SNJ|STX|SV|TN|UT|VA|VI|VT|WCF|WI|WMA|WNY|WPA|WTX|WV|WWA|WY|AB|BC|GTA|MAR|MB|NL|NT|ONE|ONN|ONS|PE|QC|SK)$/) {
     printf("%s=%s;%s\n", toupper($1), toupper($2), toupper($3));
   }
   else if ($0 !~ /^(!|#|$)/) {
     printf("Ignored: %s\n", $0) > "/dev/stderr";
   }
}
END {}' | sort | sed 's/^\#. /\# /g' > $OUTFILE

echo $OUTFILE created
unix2dos -q $OUTFILE

exit
