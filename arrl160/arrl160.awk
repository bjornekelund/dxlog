BEGIN {
  printf("#0 ARRL 160m database - ARRL/RAC sections\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  FS=",";
}
{
  if ($0 ~ /^(!|#|$)/) 
  {
    if ($1 ~ /!!Order!!/) 
    {
      if ($3 ~ /Exch1/) col = 2;
      if ($4 ~ /Exch1/) col = 3;
      if ($5 ~ /Exch1/) col = 4;
      printf("%s --> col=%d\n", $0, col) > "/dev/stderr";
    }
  } 
  else if (lines[$1] != "") 
  {
  } 
  else if (lines[$1] != "") 
  {
    printf("\"%s\" reoccurs as \"%s\"\n", lines[$1], $0) > "/dev/stderr";
  } 
  else if ($1 ~ /^(A[A-L]|[KNW][A-Z]?[0-9]([A-Z]+|\/)|4U1WB)|\/W[0-9]$/ && $1 !~ /\/VE[0-9]$/) 
  {
  } 
  else if ($1 ~ /^(A[A-L]|[KNW][A-Z]?[0-9]([A-Z]+|\/)|4U1WB)|\/W[0-9]$/ && $1 !~ /\/VE[0-9]$/) 
  {
    if ($2 !~ /^(AK|AL|AR|AZ|CO|CT|DE|EB|EMA|ENY|EPA|EWA|GA|IA|ID|IL|IN|KS|KY|LA|LAX|MDC|ME|MI|MN|MO|MS|MT|NC|ND|NE|NFL|NH|NLI|NM|NNJ|NNY|NTX|NV|OH|OK|OR|ORG|PAC|PR|RI|SB|SC|SCV|SD|SDG|SF|SFL|SJV|SNJ|STX|SV|TN|UT|VA|VI|VT|WCF|WI|WMA|WNY|WPA|WTX|WV|WWA|WY)$/) {
      printf("Problem ARRL section: \"%s\"\n", $0) > "/dev/stderr";
    }
    else 
    {
    else 
    {
      printf("%s=%s\n", $1, $2);
      lines[$1] = $0;
    }
  } 
  else if ($1 ~ /^(V[A-EOXY]|C[F-K]|CY)|\/(V[A-EOXY][0-9])/ || $1 ~ /\/VE/) 
  {
    lines[$1] = $0;
    if ($2 !~ /^(|AB|BC|GH|MB|NB|NL|NS|ONE|ONN|ONS|PE|QC|SK|TER)$/) 
    {
      printf("Problem RAC section : \"%s\"\n", $0) > "/dev/stderr";
    }
    else 
    {
    else 
    {
      printf("%s=%s\n", $1, $2);
      lines[$1] = $0;
    }
  } 
  else if ($2 !~ /^DX$/) 
  {
  } 
  else if ($2 !~ /^DX$/) 
  {
    printf("Problem DX station  : \"%s\"\n", $0) > "/dev/stderr";
  }
}
