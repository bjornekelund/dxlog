BEGIN {
  printf("#00 Maine QSO Party prefill database\n");
  FS = ",";
}
{
  if ($1 ~ /!!Order!!/)
  {
    if ($2 ~ /Call/) call = 1;
    if ($3 ~ /Call/) call = 2;
    if ($4 ~ /Call/) call = 3;
    if ($5 ~ /Call/) call = 4;
    if ($3 ~ /State|Exch1/) state = 2;
    if ($4 ~ /State|Exch1/) state = 3;
    if ($5 ~ /State|Exch1/) state = 4;
  # printf\("%s --> call=%d state=%d\n", $0, call, state) > "/dev/stderr";
  }
  else if ( \
    (IsUScall($call) && \
      ($state ~ /^(AL|AK|AZ|AR|CA|CO|CT|DE|DC|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY)$/ || \
      $state ~ /^(AND|ARO|CBL|FRA|HAN|KEN|KNO|LIN|OXF|PEN|PSQ|SAG|SOM|WAL|WAS|YOR)$/)) || \
    (IsVEcall($call) && $state ~ /^(AB|BC|LB|MB|NB|NF|NS|NT|NU|ON|PE|QC|SK|YT)$/) )
  {
    if (line[$call] != "")
    {
      printf("\"%s\" reoccurs as \"%s\"\n", line[$call], $0) > "/dev/stderr";
    }
    else if (NotPredictableVE14($call, $state))
    {
      printf("%s=%s\n", $call, $state);
      line[$call] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/ && IsNAcall($call) && $state != "")
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}

