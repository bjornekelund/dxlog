BEGIN {
  printf("#00 ARRL 160m Contest prefill database\n");
  printf("#01 Based on data maintained by Claude VE2FK\n");
  printf("#02 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#03 Last updated %s\n", strftime("%Y-%m-%d"));
  FS = ",";
}
{
  if ($1 ~ /!!Order!!/)
  {
    if ($2 ~ /Call/) call = 1;
    if ($3 ~ /Call/) call = 2;
    if ($4 ~ /Call/) call = 3;
    if ($5 ~ /Call/) call = 4;
    if ($3 ~ /Exch1/) col = 2;
    if ($4 ~ /Exch1/) col = 3;
    if ($5 ~ /Exch1/) col = 4;
    # printf("%s --> call=%d col=%d\n", $0, call, col) > "/dev/stderr";
  }
  else if (IsUScall($call))
  {
    if (lines[$call] != "")
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$call], $0) > "/dev/stderr";
    }
    else if ($col !~ /^(AK|AL|AR|AZ|CO|CT|DE|EB|EMA|ENY|EPA|EWA|GA|IA|ID|IL|IN|KS|KY|LA|LAX|MDC|ME|MI|MN|MO|MS|MT|NC|ND|NE|NFL|NH|NLI|NM|NNJ|NNY|NTX|NV|OH|OK|OR|ORG|PAC|PR|RI|SB|SC|SCV|SD|SDG|SF|SFL|SJV|SNJ|STX|SV|TN|UT|VA|VI|VT|WCF|WI|WMA|WNY|WPA|WTX|WV|WWA|WY)$/)
    {
      printf("Problem ARRL section: \"%s\"\n", $0) > "/dev/stderr";
    }
    else
    {
      printf("%s=%s\n", $call, $col);
      lines[$call] = $0;
    }
  }
  else if (IsVEcall($call))
  {
    if (lines[$call] != "")
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$call], $0) > "/dev/stderr";
    }
    else if ($col !~ /^(AB|BC|GH|MB|NB|NL|NS|ONE|ONN|ONS|PE|QC|SK|TER)$/)
    {
      printf("Problem RAC section : \"%s\"\n", $0) > "/dev/stderr";
    }
    else if (NotPredictableRAC($call, $col))
    {
      printf("%s=%s\n", $call, $col);
      lines[$call] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/)
  {
    printf("DX station ignored  : \"%s\"\n", $0) > "/dev/stderr";
  }
}
