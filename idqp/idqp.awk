BEGIN {
  FS=","
  printf("#0 Idaho QSO Party database\n");
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
    if (lines[$1] != "") {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$1], $0) > "/dev/stderr";
    }
    else {
      if ($1 ~ /^[0-9,A-Z,\/]+$/ && $col ~ /^(AL|AK|AZ|AR|CA|CO|CT|DC|DE|FL|GA|HI|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VA|VT|WA|WV|WI|WY|AB|BC|MB|NB|NL|NT|NS|NU|ON|PE|QC|SK|YT|ADA|ADM|BAN|BEA|BEN|BIN|BLA|BOI|BNR|BNV|BOU|BUT|CAM|CAN|CAR|CAS|CLA|CLE|CUS|ELM|FRA|FRE|GEM|GOO|IDA|JEF|JER|KOO|LAT|LEM|LEW|LIN|MAD|MIN|NEZ|ONE|OWY|PAY|POW|SHO|TET|TWI|VAL|WAS)$/) {
        printf("%s=%s\n", $1, $col);
        lines[$1] = $0;
      }
      else if ($0 !~ /^(!|#|$)/ && $col !~ /^$/)
        printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
    }
  } 
}
