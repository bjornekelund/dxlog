BEGIN {
  printf("#00 CQ 160M Contest prefill database\n");
  FS = ",";
}
{
  if ($1 ~ /!!Order!!/)
  {
    if ($2 ~ /Call/) call = 1;
    if ($3 ~ /Call/) call = 2;
    if ($4 ~ /Call/) call = 3;
    if ($5 ~ /Call/) call = 4;
    if ($3 ~ /State/) col = 2;
    if ($4 ~ /State/) col = 3;
    if ($5 ~ /State/) col = 4;
  # printf\("%s --> call=%d col=%d\n", $0, call, col) > "/dev/stderr";
  }
  if ( \
    (IsUScall($call) && $col ~ /^(AL|AK|AZ|AR|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VA|VT|WA|WV|WI|WY)$/) || \
    (IsVEcall($call) && $col ~ /^(AB|BC|LB|MB|NB|NF|NS|NT|NU|ON|PE|QC|SK|YT)$/) )
  {
    if (lines[$call] != "")
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$call], $0) > "/dev/stderr";
    }
    if (NotPredictableVE14($call, $col))
    {
      printf("%s=%s\n", $call, $col);
      lines[$call] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/ && $col != "")
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
