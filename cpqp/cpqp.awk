BEGIN {
  printf("#00 Canadian Prairies QSO Party prefill database\n");
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
    if ($3 ~ /Exch1|State/) state = 2;
    if ($4 ~ /Exch1|State/) state = 3;
    if ($5 ~ /Exch1|State/) state = 4;
    # printf("%s --> state=%d\n", $0, state) > "/dev/stderr";
  }
  else if ( \
      ($call ~ /^(A[A-L]|[KNW][A-Z]?)[0-9](([A-Z]{1,3})(\/([0-9MP]|QRP))?$|\/)|\/(W[0-9]|KL7|KH6)$/ &&
        $state ~ /^(DX|AL|AK|AZ|AR|CA|CO|CT|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MA|MD|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY)$/) || \
      ($call ~ /^V[A-GOXY][0-9]([A-Z]+|\/)|\/V[EOY][0-9]$/ && \
        ($state ~ /^(AIR|BAT|BLM|BOW|BRA|CCE|CCO|CCF|CET|CHE|CMC|CMI|CNH|CSH|CSG|CSK|CAR|CHU|DES|EDC|EGA|EDG|EDM|ENW|ERV|ESE|EST|EDW|ELM|FTH|FTM|GPR|KIL|LAK|LWT|LTH|MED|MOO|PRK|PRW|PON|POR|PRI|PRO|RED|RGL|RGQ|RGW|RDM|SKU|SKS|SKW|SEL|SPK|SOU|STS|STB|SGK|WPC|WPN|WPS|WSC|WWT|YEL|YOR)$/ || \
        $state ~ /^(NL|NB|NS|PE|QC|ON|BC|NT|NU|YT)$/)))
  {
    if (lines[$call] != "")
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$call], $0) > "/dev/stderr";
    }
    else if (notpredictableve13($call, $state))
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
