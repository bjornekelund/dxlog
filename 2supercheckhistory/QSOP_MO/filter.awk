BEGIN {
  printf("#00 Montana QSO Party prefill database\n");
  printf("#01 Based on data from https://supercheckhistory.com/\n");
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
      ($state ~ /^(AL|AK|AZ|AR|CA|CO|CT|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VA|VT|WA|WV|WI|WY)$/ || \
      $state ~ /^(ADR|AND|ATC|AUD|BAR|BAT|BEN|BOL|BOO|BTN|BTR|BUC|CAL|CAM|CAR|CAS|CED|CHN|CHR|CLA|CLK|CLN|COL|COP|CPG|CRA|CRL|CWL|DAD|DAL|DEK|DEN|DGL|DUN|DVS|FRA|GAS|GEN|GRN|GRU|HAR|HEN|HIC|HLT|HOW|HWL|IRN|JAC|JAS|JEF|JON|KNX|LAC|LAF|LAW|LCN|LEW|LIN|LIV|MAC|MAD|MAR|MCD|MER|MGM|MIL|MIS|MNT|MON|MOR|MRE|NMD|NOD|NWT|ORE|OSA|OZA|PEM|PER|PET|PHE|PIK|PLA|POL|PUL|PUT|RAL|RAN|RAY|REY|RIP|SAL|SCH|SCL|SCO|SCT|SHA|SHL|SLC|STC|STD|STF|STG|STL|STN|SUL|TAN|TEX|VRN|WAR|WAS|WAY|WEB|WOR|WRT)(\/(ADR|AND|ATC|AUD|BAR|BAT|BEN|BOL|BOO|BTN|BTR|BUC|CAL|CAM|CAR|CAS|CED|CHN|CHR|CLA|CLK|CLN|COL|COP|CPG|CRA|CRL|CWL|DAD|DAL|DEK|DEN|DGL|DUN|DVS|FRA|GAS|GEN|GRN|GRU|HAR|HEN|HIC|HLT|HOW|HWL|IRN|JAC|JAS|JEF|JON|KNX|LAC|LAF|LAW|LCN|LEW|LIN|LIV|MAC|MAD|MAR|MCD|MER|MGM|MIL|MIS|MNT|MON|MOR|MRE|NMD|NOD|NWT|ORE|OSA|OZA|PEM|PER|PET|PHE|PIK|PLA|POL|PUL|PUT|RAL|RAN|RAY|REY|RIP|SAL|SCH|SCL|SCO|SCT|SHA|SHL|SLC|STC|STD|STF|STG|STL|STN|SUL|TAN|TEX|VRN|WAR|WAS|WAY|WEB|WOR|WRT))?$/)) || \
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
  else if ($0 !~ /^(!|#|$)/ && IsNAcall($call))
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}

