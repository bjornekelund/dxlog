BEGIN {
  printf("#00 ARRL CW Sweepstakes database\n");
  printf("#01 Based on data collected and maintained by VE2FK\n");
  printf("#02 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#03 Last updated %s\n", strftime("%Y-%m-%d"));
  FS=","
}
{
  if ($0 !~ /^(#|!)/) 
  {
    if (call[$1] != "" && (prec[$1] != $2 || lic[$1] != $3 || sect[$1] != $4)) 
    {
      printf("Duplicate entry: \"%s\" overridden by \"%s\"\n", line[$1], $0) > "/dev/stderr";
    }
    if ($2 ~ /^(|AK|AL|AR|AZ|CO|CT|DE|EB|EMA|ENY|EPA|EWA|GA|IA|ID|IL|IN|KS|KY|LA|LAX|MDC|ME|MI|MN|MO|MS|MT|NC|ND|NE|NFL|NH|NLI|NM|NNJ|NNY|NTX|NV|OH|OK|OR|ORG|PAC|PR|RI|SB|SC|SCV|SD|SDG|SF|SFL|SJV|SNJ|STX|SV|TN|UT|VA|VI|VT|WCF|WI|WMA|WNY|WPA|WTX|WV|WWA|WY|AB|BC|GH|MB|NB|NL|NS|ONE|ONN|ONS|PE|QC|SK|TER)$/ && ($4 >= 0 || $4 == "")) 
    {
      call[$1] = $1;
      prec[$1] = "";
      lic[$1] = $3;
      sect[$1] = $2;
    }
    else 
    {
      printf("Problem entry: \"%s\"\n", $0) > "/dev/stderr";
    }
  }
}
END {
  for (cs in call) 
  {
    printf("%s=%s;%s;%s\n", cs, prec[cs], lic[cs], sect[cs]);
  }
}
