BEGIN {
  printf("#00 ARRL 160m Contest prefill database\n");
  FS = ",";
}
{
  if ($1 ~ /!!Order!!/)
  {
    call = FindColumn("Call");
    exch = FindColumn("State|Exch1");
    # printf("%s --> call=%d exch=%d\n", $0, call, exch) > "/dev/stderr";
  }
  else if (IsUScall($call))
  {
    if (lines[$call] != "")
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$call], $0) > "/dev/stderr";
    }
    else if ($exch !~ /^(AK|AL|AR|AZ|CO|CT|DE|EB|EMA|ENY|EPA|EWA|GA|IA|ID|IL|IN|KS|KY|LA|LAX|MDC|ME|MI|MN|MO|MS|MT|NC|ND|NE|NFL|NH|NLI|NM|NNJ|NNY|NTX|NV|OH|OK|OR|ORG|PAC|PR|RI|SB|SC|SCV|SD|SDG|SF|SFL|SJV|SNJ|STX|SV|TN|UT|VA|VI|VT|WCF|WI|WMA|WNY|WPA|WTX|WV|WWA|WY|R[123])$/)
    {
      printf("Problem ARRL section: \"%s\"\n", $0) > "/dev/stderr";
    }
    else
    {
      printf("%s=%s\n", $call, $exch);
      lines[$call] = $0;
    }
  }
  else if (IsVEcall($call))
  {
    if ($exch == "GTA") $exch = "GH";
    if (lines[$call] != "")
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$call], $0) > "/dev/stderr";
    }
    else if ($exch !~ /^(AB|BC|GH|MB|NB|NL|NS|ONE|ONN|ONS|PE|QC|SK|TER|R[123])$/)
    {
      printf("Problem RAC section : \"%s\"\n", $0) > "/dev/stderr";
    }
    else if (NotPredictableRAC($call, $exch))
    {
      printf("%s=%s\n", $call, $exch);
      lines[$call] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/)
  {
    printf("DX station ignored  : \"%s\"\n", $0) > "/dev/stderr";
  }
}
