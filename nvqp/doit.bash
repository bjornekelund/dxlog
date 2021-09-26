#/bin/bash
cd $(dirname $0)
FILE=`ls QSOP_* | tail -1 2> /dev/null`
#FILE=ARRL160.txt
OUTFILE=NVQP_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk '
BEGIN {
  FS=","
  date = strftime("%Y-%m-%d");
  printf("#0 Nevada QSO Party database.\n");
  printf("#1 Based on call history data maintained by VE2FK ve2fk@arrl.net.\n");
  printf("#2 File created %s.\n", date);
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
    if ($1 ~ /^[0-9,A-Z,\/]+$/ && $col ~ /^([A-Z]{2,3}|[A-Z]{5}( .+)?)$/ && $col !~ /^NV$/) {
      exch = substr($col, 1, length($col) > 5 ? 5 : length($col));
      if (exch !~ /^(NVCAR|NVCHU|NVCLA|NVDOU|NVELK|NVESM|NVEUR|NVHUM|NVLAN|NVLIN|NVLYO|NVMIN|NVNYE|NVPER|NVSTO|NVWAS|NVWHI|AK|AL|AR|AZ|CO|CT|DE|EB|EMA|ENY|EPA|EWA|GA|IA|ID|IL|IN|KS|KY|LA|LAX|MDC|ME|MI|MN|MO|MS|MT|NC|ND|NE|NFL|NH|NLI|NM|NNJ|NNY|NTX|NV|OH|OK|OR|ORG|PAC|PR|RI|SB|SC|SCV|SD|SDG|SF|SFL|SJV|SNJ|STX|SV|TN|UT|VA|VI|VT|WCF|WI|WMA|WNY|WPA|WTX|WV|WWA|WY|AB|BC|GTA|MAR|MB|NL|NT|ONE|ONN|ONS|PE|QC|SK)$/)
        printf("Bad exchange: %s\n", $0) > "/dev/stderr";
      else
        printf("%s=%s\n", $1, exch);
    }
    else
      printf("Not included: \"%s\"\n", $0) > "/dev/stderr";
  }
}' $FILE | sort | uniq | sed 's/#. /# /g' > $OUTFILE
echo Created $OUTFILE
unix2dos -q $OUTFILE
exit
