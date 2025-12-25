BEGIN {
  FS=","
  printf("#0 Pennsylvania QSO Party database\n");
  printf("#1 Credits to AA3B and K3CT for collecting and consolidating the data\n");
  printf("#2 Last updated %s\n", strftime("%Y-%m-%d"));
  state = 2;
}
{
  if ($0 ~ "!!Order!!")
  {
    if ($3 ~ /Exch1|State/) state = 2;
    if ($4 ~ /Exch1|State/) state = 3;
    if ($5 ~ /Exch1|State/) state = 4;
    printf("%s --> state=%d\n", $0, state) > "/dev/stderr";
  } 
  else if (\
    ($1 ~ /^(A[A-L]|[KNW][A-Z]?|C[FG]|V[A-EOXY])[0-9]|\/W[0-9]$|\/VE[0-9]$/ && $state ~ /^(AB|AK|AL|AR|AZ|BC|CO|CT|DE|EB|EMA|ENY|EWA|GA|GH|IA|ID|IL|IN|KS|KY|LA|LAX|MB|MDC|ME|MI|MN|MO|MS|MT|NB|NC|ND|NE|NFL|NH|NL|NLI|NM|NNJ|NNY|NS|NTX|NV|OH|OK|ONE|ONN|ONS|OR|ORG|PAC|PE|PR|QC|RI|SB|SC|SCV|SD|SDG|SF|SFL|SJV|SK|SNJ|STX|SV|TER|TN|UT|VA|VI|VT|WCF|WI|WMA|WNY|WTX|WV|WWA|WY)$/) || \
    ($1 ~ /^(A[A-L]|[KNW][A-Z]?)[0-9]|\/W[0-9]$/ && $state ~ /^(ADA|ALL|ARM|BEA|BED|BER|BLA|BRA|BUT|BUX|CAR|CEN|CHE|CLA|CLE|CLI|CMB|COL|CRA|CRN|CUM|DAU|DCO|ELK|ERI|FAY|FOR|FRA|FUL|GRE|HUN|INN|JEF|JUN|LAC|LAN|LAW|LEB|LEH|LUZ|LYC|MCK|MER|MGY|MIF|MOE|MTR|NHA|NUM|PER|PHI|PIK|POT|SCH|SNY|SOM|SUL|SUS|TIO|UNI|VEN|WAR|WAS|WAY|WES|WYO|YOR)(\/(ADA|ALL|ARM|BEA|BED|BER|BLA|BRA|BUT|BUX|CAR|CEN|CHE|CLA|CLE|CLI|CMB|COL|CRA|CRN|CUM|DAU|DCO|ELK|ERI|FAY|FOR|FRA|FUL|GRE|HUN|INN|JEF|JUN|LAC|LAN|LAW|LEB|LEH|LUZ|LYC|MCK|MER|MGY|MIF|MOE|MTR|NHA|NUM|PER|PHI|PIK|POT|SCH|SNY|SOM|SUL|SUS|TIO|UNI|VEN|WAR|WAS|WAY|WES|WYO|YOR))?$/))
  {
    if (lines[$1] != "") 
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$1], $0) > "/dev/stderr";
    }
    else 
    {
      printf("%s=%s\n", $1, $state);
      lines[$1] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/) {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}


