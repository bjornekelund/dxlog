BEGIN {
  FS=","
  printf("#00 North Carolina QSO Party database\n");
  printf("#01 Data collected and maintained by Claude VE2FK\n");
  printf("#02 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#03 Last updated %s\n", strftime("%Y-%m-%d"));
  state = 2;
}
{
  if ($1 ~ /!!Order!!/) 
  {
    if ($3 ~ /Exch1|State/) state = 2;
    if ($4 ~ /Exch1|State/) state = 3;
    if ($5 ~ /Exch1|State/) state = 4;
    printf("%s --> state=%d\n", $0, state) > "/dev/stderr";
  } 
  else if ( \
    ($1 ~ /^(A[A-L]|[KNW][A-Z]?)[0-9]([A-Z]+|\/)|\/W[0-9]$/ && $state ~ /^(AL|AK|AR|AZ|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MO|MS|MT|NE|NV|NH|NJ|NM|NY|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VA|VT|WA|WV|WI|WY)$/) || \
    ($1 ~ /^(A[A-L]|[KNW][A-Z]?)[0-9]([A-Z]+|\/)|\/W[0-9]$/ && $state ~ /^(ALA|ALE|ALL|ANS|ASH|AVE|BEA|BER|BLA|BRU|BUN|BUR|CAB|CAL|CAM|CAR|CAS|CAT|CHA|CHE|CHO|CLA|CLE|COL|CRA|CUM|CUR|DAR|DVD|DAV|DUP|DUR|EDG|FOR|FRA|GAS|GAT|GRM|GRA|GRE|GUI|HAL|HAR|HAY|HEN|HER|HOK|HYD|IRE|JAC|JOH|JON|LEE|LEN|LIN|MAC|MAD|MAR|MCD|MEC|MIT|MON|MOO|NAS|NEW|NOR|ONS|ORA|PAM|PAS|PEN|PEQ|PER|PIT|POL|RAN|RIC|ROB|ROC|ROW|RUT|SAM|SCO|STA|STO|SUR|SWA|TRA|TYR|UNI|VAN|WAK|WAR|WAS|WAT|WAY|WLK|WIL|YAD|YAN)$/) || \
    ($1 ~ /^V[A-EOXY][0-9]([A-Z]+|\/)|\/V[EOY][0-9]$/ && $state ~ /^(AB|BC|LB|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/) )
  {
    if (lines[$1] != "") 
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$1], $0) > "/dev/stderr";
    }
    else if ($state !~ /^(AB|BC|LB|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/)
    {
      printf("%s=%s\n", $1, $state);
      lines[$1] = $0;
    }
  }
  else if ($0 !~ /^(#|!|$)/) 
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
