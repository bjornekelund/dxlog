BEGIN {
  printf("#00 ARRL CW Sweepstakes prefill database\n");
  printf("#01 Based on data maintained by VE2FK\n");
  printf("#02 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#03 Last updated %s\n", strftime("%Y-%m-%d"));
  FS=",";
}
{
  # Call,Sect,State,CK,UserText,
  if ($1 ~ /!!Order!!/)
  {
    if ($2 ~ /Call/) call = 1;
    if ($3 ~ /Call/) call = 2;
    if ($4 ~ /Call/) call = 3;
    if ($5 ~ /Call/) call = 4;
    if ($3 ~ /CK/) check = 2;
    if ($4 ~ /CK/) check = 3;
    if ($5 ~ /CK/) check = 4;
    if ($6 ~ /CK/) check = 5;
    if ($3 ~ /Sect/) sect = 2;
    if ($4 ~ /Sect/) sect = 3;
    if ($5 ~ /Sect/) sect = 4;
    if ($6 ~ /Sect/) sect = 5;
    printf("%s --> call=%d check=%d sect=%d\n", $0, call, check, sect) > "/dev/stderr";
  }
  else if ( \
    (($call ~ /^(A[A-L]|[KNW][A-Z]?)[0-9](([A-Z]{1,3})(\/[0-9MP])?$|\/)|\/(W[0-9]|KL7|KH6)$|^4U1WB$|\/W[0-9]$$/ && $sect ~ /^(^(AK|AL|AR|AZ|CO|CT|DE|EB|EMA|ENY|EPA|EWA|GA|IA|ID|IL|IN|KS|KY|LA|LAX|MDC|ME|MI|MN|MO|MS|MT|NC|ND|NE|NFL|NH|NLI|NM|NNJ|NV|NNY|NTX|OH|OK|OR|ORG|PAC|PR|RI|SB|SC|SCV|SD|SDG|SF|SFL|SJV|SNJ|STX|SV|TN|UT|VA|VI|VT|WCF|WI|WMA|WNY|WPA|WTX|WV|WWA|WY)$)$/) || \
    ($call ~ /^(C[FG]|V[A-EOY])[0-9]([A-Z]+$|\/)|\/V[EOY][0-9]$/ && $sect ~ /^(|AB|BC|GH|MB|NB|NL|NS|ONE|ONN|ONS|PE|QC|SK|TER)$/)) && \
    $check ~ /^([0-9]{,2})$/)
  {
    if (calls[$call] != "" && (precs[$call] != "" || checks[$call] != $check || sects[$call] != $sect)) 
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$call], $0) > "/dev/stderr";
    }
    else
    {
      calls[$call] = $call;
      precs[$call] = "";
      checks[$call] = $check;
      sects[$call] = $sect;
    }
  }
  else if ($0 !~ /^(#|!)/)
  {
    # printf("%s --> call=\"%s\" check=\"%s\" sect=\"%s\"\n", $0, $call, $check, $sect) > "/dev/stderr";
    printf("Problem entry: \"%s\"\n", $0) > "/dev/stderr";
  }
}
END {
  for (cs in calls) 
  {
    printf("%s=%s;%s;%s\n", cs, precs[cs], checks[cs], sects[cs]);
  }
}
