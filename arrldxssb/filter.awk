BEGIN {
  printf("#00 ARRL DX Contest prefill database\n");
  FS = ",";
  call = 1;
  col1 = 2;
  col2 = 3;
}
{
  if ($1 ~ /!!Order!!/)
  {
    if ($2 ~ /Call/) call = 1;
    if ($3 ~ /Call/) call = 2;
    if ($3 ~ /State|Exch1/) col1 = 2;
    if ($4 ~ /State|Exch1/) col1 = 3;
    if ($5 ~ /State|Exch1/) col1 = 4;
    if ($3 ~ /Power/) col2 = 2;
    if ($4 ~ /Power/) col2 = 3;
    if ($5 ~ /Power/) col2 = 4;
    # printf("%s --> call=%d col1=%d col2=%d\n", $0, call, col1, col2) > "/dev/stderr";
  }
  else 
  {
    exch = $col1 == "" ? $col2 : $col1;
    if (lines[$call] != "")
    {
      printf("Repeated entry: \"%s\" and \"%s\"\n", lines[$call], $0) > "/dev/stderr";
    }
    else if ( \
      (IsUScall($call) && exch ~ /^(AL|AK|AZ|AR|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VA|VT|WA|WV|WI|WY)$/) || \
      (IsVEcall($call) && exch ~ /^(AB|BC|LB|MB|NB|NF|NS|NT|NU|ON|PE|QC|SK|YT)$/) )
    {
      calls[$call] = $call;
      exchanges[$call] = exch;
      lines[$call] = $0;
    }
    else if ($call ~/^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/ && $col2 ~ /^([0-9T]{0,4}|1?KW?)$/)
    {
      gsub(/T/, "0", exch); // convert T to 0
      sub(/^0+/, "", exch); // Remove leading zeroes
      calls[$call] = $call;
      exchanges[$call] = exch;
      lines[$call] = $0;
    }
    else if ($0 !~ /^(!|#|$)/ && IsNAcall($call))
    {
      printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
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
