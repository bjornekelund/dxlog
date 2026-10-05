BEGIN {
  printf("#00 Pennsylvania QSO Party database\n");
  printf("#01 Based on data collected and consolidated by AA3B and K3CT\n");
  printf("#02 Last updated %s\n", strftime("%Y-%m-%d"));
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
      ($state ~ /^(^(AK|AL|AR|AZ|CO|CT|DE|EB|EMA|ENY|EWA|GA|IA|ID|IL|IN|KS|KY|LA|LAX|MDC|ME|MI|MN|MO|MS|MT|NC|ND|NE|NFL|NH|NLI|NM|NNJ|NV|NNY|NTX|OH|OK|OR|ORG|PAC|PR|RI|SB|SC|SCV|SD|SDG|SF|SFL|SJV|SNJ|STX|SV|TN|UT|VA|VI|VT|WCF|WI|WMA|WNY|WTX|WV|WWA|WY)$)$/ || \
      $state ~ /^(ADA|ALL|ARM|BEA|BED|BER|BLA|BRA|BUT|BUX|CAR|CEN|CHE|CLA|CLE|CLI|CMB|COL|CRA|CRN|CUM|DAU|DCO|ELK|ERI|FAY|FOR|FRA|FUL|GRE|HUN|INN|JEF|JUN|LAC|LAN|LAW|LEB|LEH|LUZ|LYC|MCK|MER|MGY|MIF|MOE|MTR|NHA|NUM|PER|PHI|PIK|POT|SCH|SNY|SOM|SUL|SUS|TIO|UNI|VEN|WAR|WAS|WAY|WES|WYO|YOR)(\/(ADA|ALL|ARM|BEA|BED|BER|BLA|BRA|BUT|BUX|CAR|CEN|CHE|CLA|CLE|CLI|CMB|COL|CRA|CRN|CUM|DAU|DCO|ELK|ERI|FAY|FOR|FRA|FUL|GRE|HUN|INN|JEF|JUN|LAC|LAN|LAW|LEB|LEH|LUZ|LYC|MCK|MER|MGY|MIF|MOE|MTR|NHA|NUM|PER|PHI|PIK|POT|SCH|SNY|SOM|SUL|SUS|TIO|UNI|VEN|WAR|WAS|WAY|WES|WYO|YOR))?$/)) || \
    (IsVEcall($call) && $state ~ /^(AB|BC|GH|MB|NB|NL|NS|ONE|ONN|ONS|PE|QC|SK|TER)$/))
  {
    if (lines[$call] != "")
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$call], $0) > "/dev/stderr";
    }
    else
    {
      printf("%s=%s\n", $call, $state);
      lines[$call] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/ && IsNAcall($call))
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}


