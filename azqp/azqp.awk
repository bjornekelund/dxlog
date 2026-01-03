BEGIN {
  FS=","
  printf("#00 Arizona QSO Party database\n");
  printf("#01 Data collected and maintained by Claude VE2FK\n");
  printf("#02 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#03 Last updated %s\n", strftime("%Y-%m-%d"));
}
{
  if ($1 ~ /!!Order!!/) 
  {
    if ($3 ~ /Exch1|State/) state = 2;
    if ($4 ~ /Exch1|State/) state = 3;
    if ($5 ~ /Exch1|State/) state = 4;
    printf("%s --> state=%d\n", $0, state) > "/dev/stderr";
  } 
  else if ( \
    ($1 ~ /^((A[A-L]|[KNW][A-Z]?)[0-9][A-Z]{1,3})|^(KL7|KH6|W[0-9])\/|\/W[0-9]$|^4U1WB$/ && $state ~ /^(AL|AK|AR|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MO|MS|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VA|VT|WA|WV|WI|WY)$/) || \
    ($1 ~ /^((A[A-L]|[KNW][A-Z]?)[0-9][A-Z]{1,3})|^(KL7|KH6|W[0-9])\/|\/W[0-9]$|^4U1WB$/ && $state ~ /^(APH|CHS|CNO|GLA|GHM|GLE|LPZ|MCP|MHV|NVO|PMA|PNL|SCZ|YVP|YMA)$/) || \
    ($1 ~ /^(V[A-GOXY]|C[F-KY]|X[J-M])[0-9](([A-Z]{1,3})(\/[1-9PM])?$|\/)|\/V[EOY][0-9]$/ && $state ~ /^(AB|BC|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/) ) 
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
  else if ($0 !~ /^(!|#|$)/ && $state !~ /^$/) 
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";  
  }
}
