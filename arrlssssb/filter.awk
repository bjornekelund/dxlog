BEGIN {
  printf("#00 ARRL SSB Sweepstakes prefill database\n");
  FS = ",";
}
{
  # Call,Sect,State,CK,UserText,
  if ($1 ~ /!!Order!!/)
  {
    call = FindColumn("Call");
    check = FindColumn("CK");
    sect = FindColumn("Sect");
    # printf("%s --> call=%d check=%d sect=%d\n", $0, call, check, sect) > "/dev/stderr";
  }
  else 
  {
    if ($check == "-1") $check = "";
    if ( \
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
}
END {
  for (cs in calls)
  {
    printf("%s=%s;%s;%s\n", cs, precs[cs], checks[cs], sects[cs]);
  }
}
