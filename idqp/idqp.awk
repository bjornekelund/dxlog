BEGIN {
  printf("#00 Idaho QSO Party database\n");
  printf("#01 Data collected and maintained by Claude VE2FK\n");
  printf("#02 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#03 Last updated %s\n", strftime("%Y-%m-%d"));
  FS=","
}
{
  if ($1 ~ /!!Order!!/) 
  {
    if ($2 ~ /Call/) call = 1;
    if ($3 ~ /Call/) call = 2;
    if ($4 ~ /Call/) call = 3;
    if ($5 ~ /Call/) call = 4;
    if ($3 ~ /Exch1|State/) col = 2;
    if ($4 ~ /Exch1|State/) col = 3;
    if ($5 ~ /Exch1|State/) col = 4;
    printf("%s --> call=%d col=%d\n", $0, call, col) > "/dev/stderr";
  } 
  else if ( \
    ($call ~ /^(A[A-L]|[KNW][A-Z]?)[0-9]([A-Z]+|\/)|\/W[0-9]$/ && $col ~ /^(AL|AK|AZ|AR|CA|CO|CT|DC|DE|FL|GA|HI|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VA|VT|WA|WV|WI|WY)$/) || \
    ($call ~ /^(A[A-L]|[KNW][A-Z]?)[0-9]([A-Z]+|\/)|\/W[0-9]$/ && $col ~ /^(ADA|ADM|BAN|BEA|BEN|BIN|BLA|BOI|BNR|BNV|BOU|BUT|CAM|CAN|CAR|CAS|CLA|CLE|CUS|ELM|FRA|FRE|GEM|GOO|IDA|JEF|JER|KOO|LAT|LEM|LEW|LIN|MAD|MIN|NEZ|ONE|OWY|PAY|POW|SHO|TET|TWI|VAL|WAS)$/) || \
    ($call ~ /^V[A-GOXY][0-9]([A-Z]+|\/)|\/V[EOY][0-9]$/ && $col ~ /^(AB|BC|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/) )
  {
    if (lines[$call] != "") 
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$call], $0) > "/dev/stderr";
    }
    else if ($col !~ /^(AB|BC|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/)
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
