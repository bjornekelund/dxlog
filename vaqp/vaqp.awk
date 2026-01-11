BEGIN {
  printf("#00 Virginia QSO Party prefill database\n");
  printf("#01 Based on data maintained by Claude VE2FK\n");
  printf("#02 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#03 Last updated %s\n", strftime("%Y-%m-%d"));
  FS=",";
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
    printf("%s --> call=%d state=%d\n", $0, call, state) > "/dev/stderr";
  } 
  else if ( \
    ($call ~ /^(A[A-L]|[KNW][A-Z]?)[0-9](([A-Z]{1,3})(\/([0-9MP]|QRP))?$|\/)|\/(W[0-9]|KL7|KH6)$/ && \
      ($state ~ /^(AL|AK|AZ|AR|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|WA|WV|WI|WY)$/ || \
      $state ~ /^(ACC|ALB|ALL|ALX|AME|AMH|APP|ARL|AUG|BAT|BCH|BED|BHM|BLA|BOT|BRU|BRX|BVX|CAM|CCY|CHA|CHE|CHX|CLA|CLN|COX|CPX|CRA|CRL|CUL|CUM|CVX|DAX|DIC|DIN|EMX|ESS|FAU|FBX|FCX|FFX|FLO|FLU|FRA|FRE|FRX|FXX|GAX|GIL|GLO|GOO|GRA|GRN|GVL|HAL|HAN|HAX|HBX|HCO|HIG|HOX|HRY|IOW|JAM|KGE|KQN|KWM|LAN|LDN|LEE|LEX|LSA|LUN|LYX|MAD|MAT|MAX|MEC|MID|MON|MPX|MVX|NEL|NEW|NFX|NHA|NNX|NOT|NRX|NUM|ORG|PAG|PAT|PBX|PIT|POW|POX|PQX|PRE|PRG|PRW|PUL|RAP|RAX|RBR|RHM|RIC|RIX|ROA|ROX|RUS|SAX|SCO|SHA|SHE|SMY|SPO|STA|STX|SUR|SUS|SUX|TAZ|VBX|WAR|WAS|WAX|WES|WIS|WIX|WMX|WYT|YOR)$/)) || \
    ($call ~ /^V[A-GOXY][0-9]([A-Z]+|\/)|\/V[EOY][0-9]$/ && $state ~ /^(AB|BC|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/) )
  {
    if (lines[$call] != "") 
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$call], $0) > "/dev/stderr";
    }
    else if ($state !~ /^(AB|BC|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/)
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
