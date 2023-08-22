BEGIN {
  printf("#0 Kansas QSO Party database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  FS=","
  col = 2;
}
{
  if ($0 ~ "!!Order!!") {
    if ($3 ~ /Exch1|State/) col = 2;
    if ($4 ~ /Exch1|State/) col = 3;
    if ($5 ~ /Exch1|State/) col = 4;
    printf("%s --> col=%d\n", $0, col) > "/dev/stderr";
  } 
  else if ($1 ~ /^(A[A-L]|K[A-Z]?[0-9]|N[A-Z]?[0-9]|W[A-Z]?[0-9]|V[A-EOXY]|4U)/ && $col ~ /^(DX|AL|AK|AR|AZ|CA|CO|CT|DE|FL|GA|HI|ID|IL|IN|IA|KY|LA|ME|MD|MA|MI|MN|MO|MS|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VA|VT|WA|WV|WI|WY|AB|BC|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT|ALL|AND|ATC|BAR|BOU|BRO|BRT|BUT|CHE|CHS|CHT|CHY|CLK|CLO|CLY|COF|COM|COW|CRA|DEC|DIC|DON|DOU|EDW|ELK|ELL|ELS|FIN|FOR|FRA|GEA|GLY|GOV|GRE|GRM|GRT|GRY|HAM|HAS|HOG|HPR|HVY|JAC|JEF|JEW|JOH|KEA|KIN|KIO|LAB|LAN|LCN|LEA|LIN|LOG|LYO|MCP|MEA|MGY|MIA|MIT|MOR|MRN|MSH|MTN|NEM|NEO|NES|NOR|OSA|OSB|OTT|PAW|PHI|POT|PRA|RAW|REN|REP|RIC|RIL|ROO|RSL|RUS|SAL|SCO|SED|SEW|SHA|SHE|SMI|SMN|STA|STE|STN|SUM|THO|TRE|WAB|WAL|WAS|WIC|WIL|WOO|WYA)$/) {
    if (lines[$1] != "") {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$1], $0) > "/dev/stderr";
    }
    else {
      printf("%s=%s\n", $1, $col);
      lines[$1] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/ && $col != "") {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
