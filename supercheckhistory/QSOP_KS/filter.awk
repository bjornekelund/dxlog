BEGIN {
  printf("#00 Kansas QSO Party prefill database\n");
  printf("#01 Based on data from https://supercheckhistory.com\n");
  printf("#02 Last updated %s\n", strftime("%Y-%m-%d"));
  FS = ",";
  call = 1;
  state = 2;
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
  else if (\
    ($call ~ /^(A[A-L]|[KNW][A-Z]?)[0-9](([A-Z]{1,3})(\/([0-9MP]|QRP))?$|\/)|\/(W[0-9]|KL7|KH6)$/ && \
      ($state ~ /^(AL|AK|AR|AZ|CA|CO|CT|DE|FL|GA|HI|ID|IL|IN|IA|KY|LA|ME|MD|MA|MI|MN|MO|MS|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VA|VT|WA|WV|WI|WY)$/ || \
      $state ~ /^(ALL|AND|ATC|BAR|BOU|BRO|BRT|BUT|CHE|CHS|CHT|CHY|CLK|CLO|CLY|COF|COM|COW|CRA|DEC|DIC|DON|DOU|EDW|ELK|ELL|ELS|FIN|FOR|FRA|GEA|GLY|GOV|GRE|GRM|GRT|GRY|HAM|HAS|HOG|HPR|HVY|JAC|JEF|JEW|JOH|KEA|KIN|KIO|LAB|LAN|LCN|LEA|LIN|LOG|LYO|MCP|MEA|MGY|MIA|MIT|MOR|MRN|MSH|MTN|NEM|NEO|NES|NOR|OSA|OSB|OTT|PAW|PHI|POT|PRA|RAW|REN|REP|RIC|RIL|ROO|RSL|RUS|SAL|SCO|SED|SEW|SHA|SHE|SMI|SMN|STA|STE|STN|SUM|THO|TRE|WAB|WAL|WAS|WIC|WIL|WOO|WYA)$/)) || \
    ($call ~ /^V[A-GOXY][0-9]([A-Z]+|\/)|\/V[EOY][0-9]$/ && $state ~ /^(AB|BC|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/) )
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
