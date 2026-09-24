BEGIN {
  printf("#00 ARRL Field Day prefill database\n");
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
    if ($3 ~ /Exch1/) exch = 2;
    if ($4 ~ /Exch1/) exch = 3;
    if ($5 ~ /Exch1/) exch = 4;
    if ($3 ~ /Sect/) sect = 2;
    if ($4 ~ /Sect/) sect = 3;
    if ($5 ~ /Sect/) sect = 4;
    # printf("%s --> call=%d exch=%d sect=%d\n", $0, call, exch, sect) > "/dev/stderr";
  }
  else if (line[$call] != "")
  {
    printf("\"%s\" reoccurs as \"%s\"\n", line[$call], $0) > "/dev/stderr";
  }
  else if ($exch !~ /^|[1-9][0-9]?[A-F]$/)
  {
    printf("Problem category: \"%s\"\n", $0) > "/dev/stderr";
  }
  else if ($call ~ /^((A[A-L]|[KNW][A-Z]?)[0-9][A-Z]{1,3})|^(KL7|KH6|W[0-9])\/|\/W[0-9]$|^4U1WB$/ && $call !~ /\/V[EYO][0-9]$/)
  {
    if ($sect ~ /^(AK|AL|AR|AZ|CO|CT|DE|EB|EMA|ENY|EPA|EWA|GA|IA|ID|IL|IN|KS|KY|LA|LAX|MDC|ME|MI|MN|MO|MS|MT|NC|ND|NE|NFL|NH|NLI|NM|NNJ|NNY|NTX|NV|OH|OK|OR|ORG|PAC|PR|RI|SB|SC|SCV|SD|SDG|SF|SFL|SJV|SNJ|STX|SV|TN|UT|VA|VI|VT|WCF|WI|WMA|WNY|WPA|WTX|WV|WWA|WY)$/)
    {
      printf("%s=%s;%s\n", $call, $exch, $sect);
      line[$call] = $0;
    }
    else
    {
      printf("Problem ARRL section: \"%s\"\n", $0) > "/dev/stderr";
    }
  }
  else if ($call ~ /^(V[A-GOXY]|C[F-KY]|X[J-MO])[0-9](([A-Z]{1,3})(\/[1-9PM])?$|\/)|\/V[EOY][0-9]$|^VC1933$/)
  {
    if ($sect ~ /^(AB|BC|GH|MB|NB|NL|NS|ONE|ONN|ONS|PE|QC|SK|TER)$/)
    {
      printf("%s=%s;%s\n", $call, $exch, $sect);
      line[$call] = $0;
    }
    else
    {
      printf("Problem RAC section: \"%s\"\n", $0) > "/dev/stderr";
    }
  }
  else if ($0 !~ /^(!|#|$)/)
  {
    if ($sect ~ /^DX$/)
    {
      printf("%s=%s;%s\n", $call, $exch, $sect);
      line[$call] = $0;
    }
    else
    {
      printf("Problem DX station  : \"%s\"\n", $0) > "/dev/stderr";
    }
  }
}

