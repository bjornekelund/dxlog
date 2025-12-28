BEGIN {
  FS=","
  printf("#0 Arizona QSO Party database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  state = 2;
}
{
  if ($1 ~ /!!Order!!/) 
  {
    if ($3 ~ /Exch1/) state = 2;
    if ($4 ~ /Exch1/) state = 3;
    if ($5 ~ /Exch1/) state = 4;
    printf("%s --> state=%d\n", $0, state) > "/dev/stderr";
  } else if (\
      ($1 ~ /^((A[A-L]|K[A-Z]?|N[A-Z]?|W[A-Z]?)[0-9])|\/W[0-9]$/ && $state ~ /^(AL|AK|AR|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MO|MS|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VA|VT|WA|WV|WI|WY)$/) || \
      ($1 ~ /^((A[A-L]|K[A-Z]?|N[A-Z]?|W[A-Z]?)[0-9])|\/W[0-9]$/ && $state ~ /^(APH|CHS|CNO|GLA|GHM|GLE|LPZ|MCP|MHV|NVO|PMA|PNL|SCZ|YVP|YMA)$/) || \
      ($1 ~ /^V[A-EOXY][0-9]|\/VE[0-9]$/ && $state ~ /^(AB|BC|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/)) 
  {
    if (lines[$1] != "") 
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$1], $0) > "/dev/stderr";
    }
    else if ($state !~ /^(AB|BC|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/)
    {
      printf("%s=%s\n", $1, $state);
      lines[$1] = $0;
    }
  }
  else if ($1 ~ /^(A[A-L]|K|N|W|C[F-K]|V[A-G]VX|VY9|X[LM]|C[F-Z]|V[A-Y]|X[J-O])/ && $state !~ /^$/) 
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";  
  }
}
