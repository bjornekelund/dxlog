BEGIN {
  FS=","
  printf("#0 Database for Canadian Prairies QSO Party\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
}
{
  if ($1 ~ /!!Order!!/) 
  {
    if ($3 ~ /Exch1|State/) col = 2;
    if ($4 ~ /Exch1|State/) col = 3;
    if ($5 ~ /Exch1|State/) col = 4;
    printf("%s --> col=%d\n", $0, col) > "/dev/stderr";
  }
  else if ( \
      ($1 ~ /^(A[A-L]|[KNW][A-Z]?)[0-9]([A-Z]+|\/)|4U|\/W[0-9]$/ && $col ~ /^(DX|AL|AK|AZ|AR|CA|CO|CT|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MA|MD|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY)$/) || \
      ($1 ~ /^V[A-EOY][0-9]([A-Z]+|\/)|\/V[EOY][0-9]$/ && $col ~ /^(AIR|BAT|BLM|BOW|BRA|CCE|CCO|CCF|CET|CHE|CMC|CMI|CNH|CSH|CSG|CSK|CAR|CHU|DES|EDC|EGA|EDG|EDM|ENW|ERV|ESE|EST|EDW|ELM|FTH|FTM|GPR|KIL|LAK|LWT|LTH|MED|MOO|PRK|PRW|PON|POR|PRI|PRO|RED|RGL|RGQ|RGW|RDM|SKU|SKS|SKW|SEL|SPK|SOU|STS|STB|SGK|WPC|WPN|WPS|WSC|WWT|YEL|YOR)$/) || \
      ($1 ~ /^V[A-EOY][0-9]([A-Z]+|\/)|\/V[EOY][0-9]$/ && $col ~ /^(LB|NF|NL|NB|NS|PE|QC|ON|BC|NT|NU|YT)$/))
  {
    if (lines[$1] != "") 
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$1], $0) > "/dev/stderr";
    }
    else if ($col !~ /^(LB|NF|NL|NB|NS|PE|QC|ON|BC|NT|NU|YT)$/)
    {
      printf("%s=%s\n", $1, $col);
      lines[$1] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/ && $col != "") 
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
