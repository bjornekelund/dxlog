BEGIN {
  FS=","
  printf("#0 North Carolina QSO Party database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  col = 2;
}
{
  if ($1 == "!!Order!!") {
    if ($3 == "Exch1") col = 2;
    if ($4 == "Exch1") col = 3;
    if ($5 == "Exch1") col = 4;
    printf("%s --> col=%d\n", $0, col) > "/dev/stderr";
  } 
  else if ($1 ~ /^(A[A-L]|K[A-Z]?[0-9]|N[A-Z]?[0-9]|W[A-Z]?[0-9]|V[A-EOXY])/ && $col ~ /^(AB|AK|AL|AR|AZ|BC|CA|CO|CT|DC|DE|DX|FL|GA|HI|IA|ID|IL|IN|KS|KY|LA|MA|MB|MD|ME|MI|MN|MO|MS|MT|NB|ND|NE|NH|NJ|NL|NM|NS|NU|NV|NWT|NY|OH|OK|ON|OR|PA|PE|QC|RI|SC|SD|SK|TN|TX|UT|VA|VT|WA|WI|WV|WY|YT|ALA|ALE|ALL|ANS|ASH|AVE|BEA|BER|BLA|BRU|BUN|BUR|CAB|CAL|CAM|CAR|CAS|CAT|CHA|CHE|CHO|CLA|CLE|COL|CRA|CUM|CUR|DAR|DVD|DAV|DUP|DUR|EDG|FOR|FRA|GAS|GAT|GRM|GRA|GRE|GUI|HAL|HAR|HAY|HEN|HER|HOK|HYD|IRE|JAC|JOH|JON|LEE|LEN|LIN|MAC|MAD|MAR|MCD|MEC|MIT|MON|MOO|NAS|NEW|NOR|ONS|ORA|PAM|PAS|PEN|PEQ|PER|PIT|POL|RAN|RIC|ROB|ROC|ROW|RUT|SAM|SCO|STA|STO|SUR|SWA|TRA|TYR|UNI|VAN|WAK|WAR|WAS|WAT|WAY|WLK|WIL|YAD|YAN)$/) {
    if (lines[$1] != "") {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$1], $0) > "/dev/stderr";
    }
    else {
      printf("%s=%s\n", $1, $col);
      lines[$1] = $0;
    }
  }
  else if ($0 !~ /^(#|!|$)/) {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
