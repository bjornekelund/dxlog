BEGIN {
  printf("#00 ARRL 160m Contest prefill database\n");
  printf("#01 Based on data from https://supercheckhistory.com\n");
  printf("#02 Last updated %s\n", strftime("%Y-%m-%d"));
  FS = ",";
  call = 1;
  col = 2;
}
{
  if ($call ~ /^((A[A-L]|[KNW][A-Z]?)[0-9][A-Z]{1,3})|^(KL7|KH6|W[0-9])\/|\/W[0-9]$|^4U1WB$/ && $call !~ /\/V[EOY][0-9]$/)
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
  else if ($call ~ /^(V[A-EOXY]|C[F-KY])[0-9](([A-Z]{1,3})(\/[1-9PM])?$|\/)|\/V[EOY][0-9]$/)
  {
    if (lines[$call] != "")
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$call], $0) > "/dev/stderr";
    }
    else if ($col !~ /^(AB|BC|GH|MB|NB|NL|NS|ONE|ONN|ONS|PE|QC|SK|TER)$/)
    {
      printf("Problem RAC section : \"%s\"\n", $0) > "/dev/stderr";
    }
    else if (notpredictablerac($call, $col))
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
