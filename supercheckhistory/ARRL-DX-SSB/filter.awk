BEGIN {
  printf("#00 ARRL DX Contest prefill database\n");
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
    if ($3 ~ /State|Exch1/) col = 2;
    if ($4 ~ /State|Exch1/) col = 3;
    if ($5 ~ /State|Exch1/) col = 4;
    # printf("%s --> call=%d col=%d col=%d\n", $0, call, col, col) > "/dev/stderr";
  }
  else if (lines[$call] != "")
  {
    printf("Repeated entry: \"%s\" and \"%s\"\n", lines[$call], $0) > "/dev/stderr";
  }
  else if ( \
    ($call ~ /^((A[A-L]|[KNW][A-Z]?)[0-9][A-Z]{1,3})|^(KL7|KH6|W[0-9])\/|\/W[0-9]$|^4U1WB$/ && $col ~ /^(AL|AZ|AR|CA|CO|CT|DC|DE|FL|GA|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VA|VT|WA|WV|WI|WY)$/) || \
    ($call ~ /^(V[A-EOXY]|C[F-KY]|XM)[0-9](([A-Z]{1,3})(\/[1-9PM])?$|\/)|\/V[EOY][0-9]$/ && $col ~ /^(AB|BC|LB|MB|NB|NF|NS|NT|NU|ON|PE|QC|SK|YT)$/) )
  {
        calls[$call] = $call;
        exchanges[$call] = $col;
        lines[$call] = $0;
  }
  else if ($call ~/^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/ && $col ~ /^([0-9T]{0,4}|1?KW?)$/)
  {
    gsub(/T/, "0", $col); // convert T to 0
    sub(/^0+/, "", $col); // Remove leading zeroes
    calls[$call] = $call;
    exchanges[$call] = $col;
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
