BEGIN {
  printf("#00 Idaho QSO Party prefill database\n");
  FS = ",";
}
{
  if ($1 ~ /!!Order!!/)
  {
    if ($2 ~ /Call/) call = 1;
    if ($3 ~ /Call/) call = 2;
    if ($4 ~ /Call/) call = 3;
    if ($5 ~ /Call/) call = 4;
    if ($3 ~ /Exch1/) state = 2;
    if ($4 ~ /Exch1/) state = 3;
    if ($5 ~ /Exch1/) state = 4;
  # printf\("%s --> call=%d state=%d\n", $0, call, state) > "/dev/stderr";
  }
  else if ( \
    (IsUScall($call) && \
      ($state ~ /^(AL|AK|AZ|AR|CA|CO|CT|DC|DE|FL|GA|HI|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VA|VT|WA|WV|WI|WY)$/ || \
      $state ~ /^(ADA|ADM|BAN|BEA|BEN|BIN|BLA|BOI|BNR|BNV|BOU|BUT|CAM|CAN|CAR|CAS|CLA|CLE|CUS|ELM|FRA|FRE|GEM|GOO|IDA|JEF|JER|KOO|LAT|LEM|LEW|LIN|MAD|MIN|NEZ|ONE|OWY|PAY|POW|SHO|TET|TWI|VAL|WAS)(\/(ADA|ADM|BAN|BEA|BEN|BIN|BLA|BOI|BNR|BNV|BOU|BUT|CAM|CAN|CAR|CAS|CLA|CLE|CUS|ELM|FRA|FRE|GEM|GOO|IDA|JEF|JER|KOO|LAT|LEM|LEW|LIN|MAD|MIN|NEZ|ONE|OWY|PAY|POW|SHO|TET|TWI|VAL|WAS))?$/)) || \
    (IsVEcall($call) && $state ~ /^(AB|BC|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/) )
  {
    if (lines[$call] != "")
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$call], $0) > "/dev/stderr";
    }
    else if (NotPredictableVE13($call, $state))
    {
      printf("%s=%s\n", $call, $state);
      lines[$call] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/ && $state != "")
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
