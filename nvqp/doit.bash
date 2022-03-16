#!/bin/bash
FILE=`ls QSOP_* | tail -1 2> /dev/null`
OUTFILE=NVQP_db.txt

echo Parsing $FILE
dos2unix -q $FILE

cat $FILE | gawk '
BEGIN {
  FS=","
  date = strftime("%Y-%m-%d");
  printf("#0 Nevada QSO Party database.\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly ve2fk@arrl.net\n");
  printf("#3 File last updated %s\n", strftime("%Y-%m-%d"));
  col = 3;
}
{
  if ($1 ~ /!!Order!!/) {
    if ($2 ~ /Exch1|State/) col = 1;
    if ($3 ~ /Exch1|State/) col = 2;
    if ($4 ~ /Exch1|State/) col = 3;
    if ($5 ~ /Exch1|State/) col = 4;
    printf("%s --> Column is %d\n", $0, col) > "/dev/stderr";
  } else {
    exch = $col;
    if ($1 ~ /^[0-9,A-Z,\/]+$/ && $col ~ /^(NVCAR|NVCHU|NVCLA|NVDOU|NVELK|NVESM|NVEUR|NVHUM|NVLAN|NVLIN|NVLYO|NVMIN|NVNYE|NVPER|NVSTO|NVWAS|NVWHI|AK|AL|AR|AZ|CO|CT|DE|EB|EMA|ENY|EPA|EWA|GA|IA|ID|IL|IN|KS|KY|LA|LAX|MDC|ME|MI|MN|MO|MS|MT|NC|ND|NE|NFL|NH|NLI|NM|NNJ|NNY|NTX|NV|OH|OK|OR|ORG|PAC|PR|RI|SB|SC|SCV|SD|SDG|SF|SFL|SJV|SNJ|STX|SV|TN|UT|VA|VI|VT|WCF|WI|WMA|WNY|WPA|WTX|WV|WWA|WY|AB|BC|GTA|MAR|MB|NL|NT|ONE|ONN|ONS|PE|QC|SK)$/)
      printf("%s=%s\n", $1, exch);
	else if ($0 !~ /^(!|#|$)/)
      printf("Invalid exchange: %s\n", $0) > "/dev/stderr";
  }
}' $FILE | sort | uniq | sed 's/#. /# /g' > $OUTFILE
echo Created $OUTFILE
unix2dos -q $OUTFILE
exit
