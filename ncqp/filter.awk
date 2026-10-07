BEGIN {
  printf("#00 North Carolina QSO Party prefill database\n");
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
      ($state ~ /^(AL|AK|AR|AZ|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MO|MS|MT|NE|NV|NH|NJ|NM|NY|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VA|VT|WA|WV|WI|WY)$/ || \
      $state ~ /^(ALA|ALE|ALL|ANS|ASH|AVE|BEA|BER|BLA|BRU|BUN|BUR|CAB|CAL|CAM|CAR|CAS|CAT|CHA|CHE|CHO|CLA|CLE|COL|CRA|CUM|CUR|DAR|DVD|DAV|DUP|DUR|EDG|FOR|FRA|GAS|GAT|GRM|GRA|GRE|GUI|HAL|HAR|HAY|HEN|HER|HOK|HYD|IRE|JAC|JOH|JON|LEE|LEN|LIN|MAC|MAD|MAR|MCD|MEC|MIT|MON|MOO|NAS|NEW|NOR|ONS|ORA|PAM|PAS|PEN|PEQ|PER|PIT|POL|RAN|RIC|ROB|ROC|ROW|RUT|SAM|SCO|STA|STO|SUR|SWA|TRA|TYR|UNI|VAN|WAK|WAR|WAS|WAT|WAY|WLK|WIL|YAD|YAN)(\/(ALA|ALE|ALL|ANS|ASH|AVE|BEA|BER|BLA|BRU|BUN|BUR|CAB|CAL|CAM|CAR|CAS|CAT|CHA|CHE|CHO|CLA|CLE|COL|CRA|CUM|CUR|DAR|DVD|DAV|DUP|DUR|EDG|FOR|FRA|GAS|GAT|GRM|GRA|GRE|GUI|HAL|HAR|HAY|HEN|HER|HOK|HYD|IRE|JAC|JOH|JON|LEE|LEN|LIN|MAC|MAD|MAR|MCD|MEC|MIT|MON|MOO|NAS|NEW|NOR|ONS|ORA|PAM|PAS|PEN|PEQ|PER|PIT|POL|RAN|RIC|ROB|ROC|ROW|RUT|SAM|SCO|STA|STO|SUR|SWA|TRA|TYR|UNI|VAN|WAK|WAR|WAS|WAT|WAY|WLK|WIL|YAD|YAN))?$/)) || \
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
  else if ($0 !~ /^(#|!|$)/ && IsNAcall($call) && $state != "")
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
