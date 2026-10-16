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
    call = FindColumn("Call");
    col1 = FindColumn("State|Exch1");
    col2 = FindColumn("Power");
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
    else if (IsValidCall($call) && $col2 ~ /^([0-9T]{0,4}|1?KW?)$/)
    {
      gsub(/T/, "0", exch); // convert T to 0
      sub(/^0+/, "", exch); // Remove leading zeroes
      calls[$call] = $call;
      exchanges[$call] = exch;
      lines[$call] = $0;
    }
    else if ($0 !~ /^(!|#|$)/ && IsNAcall($call) && exch != "")
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
