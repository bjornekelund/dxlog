#!/bin/bash
FILE=`ls QSOP_* | tail -1 2> /dev/null`
OUTFILE=PAQP_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk '
BEGIN {
  FS=","
  printf("#0 Pennsylvania QSO Party database\n");
  printf("#1 Credits to AA3B and K3CT for collecting and consolidating the data\n");
  printf("#2 Last updated %s\n", strftime("%Y-%m-%d"));
  col = 2;
}
{
  if ($1 == "!!Order!!") {
    if ($2 == "Exch1") col = 1;
    if ($3 == "Exch1") col = 2;
    if ($4 == "Exch1") col = 3;
    if ($5 == "Exch1") col = 4;
    printf("\"%s\" --> Exchange is in column %d\n", $0, col) > "/dev/stderr";
  } else {
    if ($1 ~ /^[0-9,A-Z,\/]+$/ && $col ~ /^(DX|AK|AL|AR|AZ|CO|CT|DE|EB|EMA|ENY|EWA|GA|IA|ID|IL|IN|KS|KY|LA|LAX|MDC|ME|MI|MN|MO|MS|MT|NC|ND|NE|NFL|NH|NLI|NM|NNJ|NNY|NTX|NV|OH|OK|OR|ORG|PAC|PR|RI|SB|SC|SCV|SD|SDG|SF|SFL|SJV|SNJ|STX|SV|TN|UT|VA|VI|VT|WCF|WI|WMA|WNY|WTX|WV|WWA|WY|AB|BC|GTA|MAR|MB|NL|NT|ONE|ONN|ONS|PE|QC|SK|ADA|ALL|ARM|BEA|BED|BER|BLA|BRA|BUT|BUX|CAR|CEN|CHE|CLA|CLE|CLI|CMB|COL|CRA|CRN|CUM|DAU|DCO|ELK|ERI|FAY|FOR|FRA|FUL|GRE|HUN|INN|JEF|JUN|LAC|LAN|LAW|LEB|LEH|LUZ|LYC|MCK|MER|MGY|MIF|MOE|MTR|NHA|NUM|PER|PHI|PIK|POT|SCH|SNY|SOM|SUL|SUS|TIO|UNI|VEN|WAR|WAS|WAY|WES|WYO|YOR)(\/(ADA|ALL|ARM|BEA|BED|BER|BLA|BRA|BUT|BUX|CAR|CEN|CHE|CLA|CLE|CLI|CMB|COL|CRA|CRN|CUM|DAU|DCO|ELK|ERI|FAY|FOR|FRA|FUL|GRE|HUN|INN|JEF|JUN|LAC|LAN|LAW|LEB|LEH|LUZ|LYC|MCK|MER|MGY|MIF|MOE|MTR|NHA|NUM|PER|PHI|PIK|POT|SCH|SNY|SOM|SUL|SUS|TIO|UNI|VEN|WAR|WAS|WAY|WES|WYO|YOR))?$/)
      printf("%s=%s\n", $1, $col);
    else if ($0 !~ /^(!|#|$)/)
      printf("Invalid exchange: \"%s\"\n", $0) > "/dev/stderr";
  }
}
END { }' $FILE | sort | uniq | sed 's/#. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
