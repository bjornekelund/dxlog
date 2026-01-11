BEGIN {
  printf("#00 Winter Field Day prefill database\n");
  printf("#01 Based on data maintained by Claude VE2FK\n");
  printf("#02 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#03 Last updated %s\n", strftime("%Y-%m-%d"));
  FS=",";
}
{
  if ($1 ~ /!!Order!!/) 
  {
    if ($2 ~ /Call/) call = 1;
    if ($3 ~ /Call/) call = 2;
    if ($4 ~ /Call/) call = 3;
    if ($5 ~ /Call/) call = 4;
    if ($3 ~ /Sect/) sct = 2;
    if ($4 ~ /Sect/) sct = 3;
    if ($5 ~ /Sect/) sct = 4;
    if ($3 ~ /Exch1/) cls = 2;
    if ($4 ~ /Exch1/) cls = 3;
    if ($5 ~ /Exch1/) cls = 4;
    printf("%s --> call=%d sect=%d class=%d\n", $0, call, sct, cls) > "/dev/stderr";
  } 
  else if ( \
    toupper($call) ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/ && \
    $cls !~ /^\[1-9][0-9]?[IOH]$/ && \
    $sct ~ /^(DX|MX|AL|AK|AB|AZ|AR|BC|CO|CT|DE|EB|EMA|ENY|EPA|EWA|GA|GH|ID|IL|IN|IA|KS|KY|LAX|LA|ME|MB|MDC|MI|MN|MS|MO|MT|NE|NV|NB|NH|NM|NLI|NL|NC|ND|NTX|NFL|NNJ|NNY|NS|OH|OK|ONE|ONN|ONS|ORG|OR|PAC|PE|PR|QC|RI|SV|SDG|SF|SJV|SB|SCV|SK|SC|SD|STX|SFL|SNJ|TN|TER|VI|UT|VT|VA|WCF|WTX|WV|WMA|WNY|WPA|WWA|WI|WY)$/) 
  {
    callsign[toupper($call)] = toupper($call);
    section[toupper($call)] = $sct != "" ? $sct : section[toupper($call)]; 
    class[toupper($call)] = $cls != "" ? $cls : class[toupper($call)];
   }
  else if ($0 !~ /^(!|#|$)/) 
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
END {
  for (c in callsign) 
  {
    printf("%s=%s;%s\n", callsign[c], class[c], section[c]);
  }
}