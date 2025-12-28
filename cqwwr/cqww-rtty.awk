BEGIN {
  printf("#0 CQ WW RTTY database - States and provinces but AK HI PR VI not included\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  FS=","
}
{
  if ($1 ~ /!!Order!!/) 
  {
    if ($3 ~ /Exch1|State/) state = 2;
    if ($4 ~ /Exch1|State/) state = 3;
    if ($5 ~ /Exch1|State/) state = 4;
    printf("%s --> state=%d\n", $0, state) > "/dev/stderr";
  } 
  else if (\
      ($1 ~ /^((A[A-L]|[KNW][A-Z]?)[0-9]([A-Z]+|\/)|^4U1W|\/W[0-9]$)|\/W[0-9]$/ && $state ~ /^(AL|AK|AZ|AR|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VA|VT|WA|WV|WI|WY)$/) || \
      ($1 ~ /^V[A-EOXY][0-9]([A-Z]+|\/)|\/VE[0-9]$/ && $state ~ /^(AB|BC|LB|MB|NB|NF|NS|NWT|NU|ON|PE|QC|SK|YT)$/) \
    )
  {
    if ($state !~ /^(AB|BC|LB|MB|NB|NF|NS|NWT|NU|ON|PE|QC|SK|YT)$/)
    {
      printf("%s=%s\n", $1, $state);
    }
  }
  else if ($0 !~ /^(!|#|$)/ && $state != "")
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr"
  }
}
