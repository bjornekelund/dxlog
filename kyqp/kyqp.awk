BEGIN {
  FS=","
  printf("#0 Kentucky QSO Party database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  col = 2;
}
{
  if ($0 ~ "!!Order!!") {
    if ($2 ~ /Exch1|State/) col = 1;
    if ($3 ~ /Exch1|State/) col = 2;
    if ($4 ~ /Exch1|State/) col = 3;
    if ($5 ~ /Exch1|State/) col = 4;
    printf("%s --> col=%d\n", $0, col) > "/dev/stderr";
  } else {
    exch = $col;
    if (exch == "DC") 
      exch = "MD";
    if ($1 ~ /^[0-9,A-Z,\/]+$/ && exch ~ /^(AL|AK|AZ|AR|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IA|IN|KS|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY|AB|BC|MB|NB|NL|NS|ON|PE|QC|SK|NT|ADA|ALL|AND|BAL|BAR|BAT|BEL|BOL|BOO|BOU|BOY|BRA|BRE|BRK|BUL|BUT|CAE|CAL|CAM|CAS|CAW|CHR|CLA|CLI|CLY|CRI|CRL|CTR|CUM|DAV|EDM|ELL|EST|FAY|FLE|FLO|FRA|FUL|GAL|GAR|GRE|GRP|GRT|GRV|GRY|HAN|HAR|HEN|HIC|HNY|HOP|HRL|HRT|HSN|JAC|JEF|JES|JOH|KEN|KNT|KNX|LAR|LAU|LAW|LEE|LES|LET|LEW|LIN|LIV|LOG|LYO|MAD|MAG|MAR|MAS|MAT|MCC|MCL|MCY|MEA|MEN|MER|MET|MON|MOR|MOT|MSL|MUH|NEL|NIC|OHI|OLD|OWE|OWS|PEN|PER|PIK|POW|PUL|ROB|ROC|ROW|RUS|SCO|SHE|SIM|SPE|TAY|TOD|TRI|TRM|UNI|WAR|WAS|WAY|WEB|WHI|WOL|WOO)$/)
      printf("%s=%s\n", $1, exch);
    else if ($0 !~ /^(!|#|$)/)
      printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  } 
}
