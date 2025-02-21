BEGIN {
  FS=","
  printf("#0 Wisconsin QSO Party database\n");
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
  else if ($1 ~ /^(A[A-L]|K[A-Z]?[0-9]|N[A-Z]?[0-9]|W[A-Z]?[0-9]|V[A-EOXY])/ && $col ~ /^(AL|AK|AZ|AR|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY|AB|BC|LB|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT|ADA|ASH|BAR|BAY|BRO|BUF|BUR|CAL|CHI|CLA|COL|CRA|DAN|DOD|DOO|DOU|DUN|EAU|FLO|FON|FOR|GRA|GRE|GRL|IOW|IRO|JAC|JEF|JUN|KEN|KEW|LAC|LAF|LAN|LIN|MAN|MAR|MEN|MIL|MON|MRN|MRQ|OCO|ONE|OUT|OZA|PEP|PIE|POL|POR|PRI|RAC|RIC|ROC|RUS|SAU|SAW|SHA|SHE|STC|TAY|TRE|VER|VIL|WAL|WAP|WAS|WAU|WIN|WOO|WSB|WSR)$/) {
    if (lines[$1] != "") {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$1], $0) > "/dev/stderr";
    }
    else {
      printf("%s=%s\n", $1, $col);
      lines[$1] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/ && $col != "DX") {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
} 
