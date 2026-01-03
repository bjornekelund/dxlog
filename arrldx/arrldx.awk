BEGIN {
  printf("#00 ARRL DX database\n");
  printf("#01 Data collected and maintained by Claude VE2FK\n");
  printf("#02 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#03 Last updated %s\n", strftime("%Y-%m-%d"));
  FS=",";
}
{
  if ($1 ~ /!!Order!!/) 
  {
    if ($3 ~ /Power/) pcol = 2;
    if ($4 ~ /Power/) pcol = 3;
    if ($5 ~ /Power/) pcol = 4;
    if ($3 ~ /State/) scol = 2;
    if ($4 ~ /State/) scol = 3;
    if ($5 ~ /State/) scol = 4;
    printf("%s --> pcol=%d scol=%d\n", $0, pcol, scol) > "/dev/stderr";
  }
  else 
  {
    if (lines[$1] != "") 
    { 
      printf("Repeated entry: \"%s\" and \"%s\"\n", lines[$1], $0) > "/dev/stderr";
    }
    else if ( \
      ($1 ~ /^((A[A-L]|[KNW][A-Z]?)[0-9][A-Z]{1,3})|^(KL7|KH6|W[0-9])\/|\/W[0-9]$|^4U1WB$/ && $scol ~ /^(AL|AK|AZ|AR|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VA|VT|WA|WV|WI|WY)$/) || \
      ($1 ~ /^(V[A-EOXY]|C[F-KY])[0-9](([A-Z]{1,3})(\/[1-9PM])?$|\/)|\/V[EOY][0-9]$/ && $scol ~ /^(AB|BC|LB|MB|NB|NF|NS|NT|NU|ON|PE|QC|SK|YT)$/) )
    {
      calls[$1] = $1;
      exchanges[$1] = $scol;
      lines[$1] = $0;
    }
    else if ($1 ~/^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/ && $pcol ~ /^([1-9][0-9]{,3}W?|1?KW?)$/) 
    {
      calls[$1] = $1;
      exchanges[$1] = $pcol;
      lines[$1] = $0;
    }
    else if ($0 !~ /^(!|#|$)/) 
    {
      printf("Ignored: \"%s\"\n", $0) > "/dev/stderr"
    }
  }
}
END {
  for (c in calls) 
  {
    if (exchanges[c] !~ /^(AB|BC|LB|MB|NB|NF|NT|NS|NU|ON|PE|QC|SK|YT)$/)
    {
        printf("%s=%s\n", c, exchanges[c]);
    }
  }
}
