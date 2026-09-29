BEGIN {
  printf("#00 ARRL DX Contest prefill database\n");
  printf("#01 Based on data from https://supercheckhistory.com\n");
  printf("#02 Last updated %s\n", strftime("%Y-%m-%d"));
  FS = ",";
  call = 1;
  
}
{
  if ($1 ~ /!!Order!!/)
  {
    if ($2 ~ /Call/) call = 1;
    if ($3 ~ /Call/) call = 2;
    if ($4 ~ /Call/) call = 3;
    if ($5 ~ /Call/) call = 4;
    if ($3 ~ /Power/) pcol = 2;
    if ($4 ~ /Power/) pcol = 3;
    if ($5 ~ /Power/) pcol = 4;
    if ($3 ~ /State/) scol = 2;
    if ($4 ~ /State/) scol = 3;
    if ($5 ~ /State/) scol = 4;
    # printf("%s --> call=%d pcol=%d scol=%d\n", $0, call, pcol, scol) > "/dev/stderr";
  }
  else if (lines[$call] != "")
  {
    printf("Repeated entry: \"%s\" and \"%s\"\n", lines[$call], $0) > "/dev/stderr";
  }
  else if ( \
    ($call ~ /^((A[A-L]|[KNW][A-Z]?)[0-9][A-Z]{1,3})|^(KL7|KH6|W[0-9])\/|\/W[0-9]$|^4U1WB$/ && $scol ~ /^(AL|AZ|AR|CA|CO|CT|DC|DE|FL|GA|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VA|VT|WA|WV|WI|WY)$/) || \
    ($call ~ /^(V[A-EOXY]|C[F-KY]|XM)[0-9](([A-Z]{1,3})(\/[1-9PM])?$|\/)|\/V[EOY][0-9]$/ && $scol ~ /^(AB|BC|LB|MB|NB|NF|NS|NT|NU|ON|PE|QC|SK|YT)$/) )
  {
        calls[$call] = $call;
        exchanges[$call] = $scol;
        lines[$call] = $0;
  }
  else if ($call ~/^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/ && $pcol ~ /^(99|73|1[0-9]|[1-9]([25]0?0?|0{,3})|1?KW?)$/)
  {
    calls[$call] = $call;
    exchanges[$call] = $pcol;
    lines[$call] = $0;
  }
  else if ($0 !~ /^(!|#|$)/)
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
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
