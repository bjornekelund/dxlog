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
    if ($3 ~ /Sect/) sct = 2;
    if ($4 ~ /Sect/) sct = 3;
    if ($5 ~ /Sect/) sct = 4;
    if ($3 ~ /Exch1/) cls = 2;
    if ($4 ~ /Exch1/) cls = 3;
    if ($5 ~ /Exch1/) cls = 4;
    printf("%s --> Section is column %d\n", $0, sct) > "/dev/stderr";
    printf("%s --> Class is column %d\n", $0, cls) > "/dev/stderr";
  } 
  else {
    call = toupper($1);
    if (call ~ /^[0-9A-Z/]+$/ && $cls !~ /^\\d+[IOH]$/ && $sct ~ /^(DX|MX|AL|AK|AB|AZ|AR|BC|CO|CT|DE|EB|EMA|ENY|EPA|EWA|GA|GH|ID|IL|IN|IA|KS|KY|LAX|LA|ME|MB|MDC|MI|MN|MS|MO|MT|NE|NV|NB|NH|NM|NLI|NL|NC|ND|NTX|NFL|NNJ|NNY|NS|OH|OK|ONE|ONN|ONS|ORG|OR|PAC|PE|PR|QC|RI|SV|SDG|SF|SJV|SB|SCV|SK|SC|SD|STX|SFL|SNJ|TN|TER|VI|UT|VT|VA|WCF|WTX|WV|WMA|WNY|WPA|WWA|WI|WY)$/) {
      # if (callsign[$1] != "" && $sct != section[$1] && $cls != class[$1]) {
      #   printf("\"%s\" reoccurs as \"%s\"\n", line[$1], $0) > "/dev/stderr";
      # }
      # else {
        callsign[$1] = $1;
        section[$1] = $sct; 

        class[$1] = $cls;
        line[$1] = $0;
      # }
    }
    else if ($0 !~ /^(!|#|$)/) {
      printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
    }
  }
}
END {
  for (c in callsign) {
    printf("%s=%s;%s\n", callsign[c], class[c], section[c]);
  }
}