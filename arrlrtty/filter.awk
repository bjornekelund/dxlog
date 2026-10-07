BEGIN {
  printf("#00 ARRL RTTY Contest prefill database\n");
  FS = ",";
}
{
  if ($1 ~ /!!Order!!/)
  {
    if ($2 ~ /Call/) call = 1;
    if ($3 ~ /Call/) call = 2;
    if ($4 ~ /Call/) call = 3;
    if ($5 ~ /Call/) call = 4;
    if ($3 ~ /State/) state = 2;
    if ($4 ~ /State/) state = 3;
    if ($5 ~ /State/) state = 4;
    # printf("%s --> call=%d state=%d\n", $0, call, state) > "/dev/stderr";
  }
else if ( \
    (IsUScall($call) && $state ~ /^(AL|AK|AZ|AR|CA|CO|CT|DE|DC|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|MD|MA|ME|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY)$/) || \
    (IsVEcall($call) && $state ~ /^(AB|BC|LB|MB|NB|NF|NS|NT|NU|ON|PE|QC|SK|YT)$/) )
  {
      if (lines[$call] != "")
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$call], $0) > "/dev/stderr";
    }
    else
    {
      if ($state !~ /^(AB|BC|LB|MB|NB|NF|NT|NS|NU|ON|PE|QC|SK|YT)$/)
      {
        printf("%s=%s\n", $call, $state);
      }
      lines[$call] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/)
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
