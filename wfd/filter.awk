BEGIN {
  printf("#00 Winter Field Day prefill database\n");
  FS = ",";
}
{
  if ($1 ~ /!!Order!!/)
  {
    call = FindColumn("Call");
    cls = FindColumn("Exch1");
    sect = FindColumn("Sect");
    printf("%s --> call=%d sect=%d class=%d\n", $0, call, sect, cls) > "/dev/stderr";
  }
  else
  {
    $call = toupper($call);
    if (IsValidCall($call) && $cls ~ /^([1-9][0-9]?[HIOM]|)$/ && \
      $sect ~ /^(DX|MX|AL|AK|AB|AZ|AR|BC|CO|CT|DE|EB|EMA|ENY|EPA|EWA|GA|GH|ID|IL|IN|IA|KS|KY|LAX|LA|ME|MB|MDC|MI|MN|MS|MO|MT|NE|NV|NB|NH|NM|NLI|NL|NC|ND|NTX|NFL|NNJ|NNY|NS|OH|OK|ONE|ONN|ONS|ORG|OR|PAC|PE|PR|QC|RI|SV|SDG|SF|SJV|SB|SCV|SK|SC|SD|STX|SFL|SNJ|TN|TER|VI|UT|VT|VA|WCF|WTX|WV|WMA|WNY|WPA|WWA|WI|WY|)$/)
    {
      callsign[$call] = $call;
      section[$call] = $sect != "" ? $sect : section[$call];
      class[$call] = $cls != "" ? $cls : class[$call];
    }
    else if ($0 !~ /^(!|#|$)/)
    {
      # printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
    }
  } 
}
END {
  for (c in callsign)
  {
    printf("%s=%s;%s\n", callsign[c], class[c], section[c]);
  }
}