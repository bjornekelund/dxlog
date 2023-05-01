BEGIN {
  printf("#0 ARRL 160m database - ARRL/RAC sections\n");
  printf("#2 Data collected and maintained by Claude VE2FK\n");
  printf("#3 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#4 Last updated %s\n", strftime("%Y-%m-%d"));
  FS=",";
}
{
  if ($1 ~ /^[0-9A-Z/]+$/ && $2 ~ /^(AK|AL|AR|AZ|CO|CT|DE|EB|EMA|ENY|EPA|EWA|GA|IA|ID|IL|IN|KS|KY|LA|LAX|MDC|ME|MI|MN|MO|MS|MT|NC|ND|NE|NFL|NH|NLI|NM|NNJ|NNY|NTX|NV|OH|OK|OR|ORG|PAC|PR|RI|SB|SC|SCV|SD|SDG|SF|SFL|SJV|SNJ|STX|SV|TN|UT|VA|VI|VT|WCF|WI|WMA|WNY|WPA|WTX|WV|WWA|WY|AB|BC|GTA|MAR|MB|NL|NT|ONE|ONN|ONS|PE|QC|SK)$/) {
    if (lines[$1] != "") {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$1], $0) > "/dev/stderr";
    }
    else {
      printf("%s=%s\n", $1, $2);
      lines[$1] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/ && $2 != ""){
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
