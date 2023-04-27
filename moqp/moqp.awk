BEGIN {
  FS=","
  printf("#0 Montana QSO Party database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  col = 2;
}
{
  if ($0 ~ "!!Order!!") {
    if ($3 ~ /Exch1|State/) col = 2;
    if ($4 ~ /Exch1|State/) col = 3;
    if ($5 ~ /Exch1|State/) col = 4;
    printf("%s --> col=%d\n", $0, col) > "/dev/stderr";
  } 
  else {
    if ($1 ~ /^(A[A-L]|K[A-Z]?[0-9]|N[A-Z]?[0-9]|W[A-Z]?[0-9]|V[A-EOXY])/ && $col ~ /^(AL|AK|AZ|AR|CA|CO|CT|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VA|VT|WA|WV|WI|WY|AB|BC|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT|ADR|AND|ATC|AUD|BAR|BAT|BEN|BOL|BOO|BTN|BTR|BUC|CAL|CAM|CAR|CAS|CED|CHN|CHR|CLA|CLK|CLN|COL|COP|CPG|CRA|CRL|CWL|DAD|DAL|DEK|DEN|DGL|DUN|DVS|FRA|GAS|GEN|GRN|GRU|HAR|HEN|HIC|HLT|HOW|HWL|IRN|JAC|JAS|JEF|JON|KNX|LAC|LAF|LAW|LCN|LEW|LIN|LIV|MAC|MAD|MAR|MCD|MER|MGM|MIL|MIS|MNT|MON|MOR|MRE|NMD|NOD|NWT|ORE|OSA|OZA|PEM|PER|PET|PHE|PIK|PLA|POL|PUL|PUT|RAL|RAN|RAY|REY|RIP|SAL|SCH|SCL|SCO|SCT|SHA|SHL|SLC|STC|STD|STF|STG|STL|STN|SUL|TAN|TEX|VRN|WAR|WAS|WAY|WEB|WOR|WRT)$/) {
      if (lines[$1] != "") {
        printf("\"%s\" reoccurs as \"%s\"\n", lines[$1], $0) > "/dev/stderr";
      }
      else {
        printf("%s=%s\n", $1, $col);
        lines[$1] = $0;
      }
    }
    else if ($0 !~ /^(!|#|$)/ && $col != "" && $col != "DX") {
      printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
    }
  } 
}
