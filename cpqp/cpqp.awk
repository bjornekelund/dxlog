BEGIN {
  FS=","
  printf("#0 Database for Canadian Prairies QSO Party\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
}
{
  if ($0 ~ "!!Order!!") {
    if ($3 ~ /Exch1/) col = 2;
    if ($4 ~ /Exch1/) col = 3;
    if ($5 ~ /Exch1/) col = 4;
    printf("%s --> col=%d\n", $0, col) > "/dev/stderr";
  } else if ($1 ~ /^(A[A-L]|K[A-Z]?[0-9]|N[A-Z]?[0-9]|W[A-Z]?[0-9]|V[A-EOXY]|4U)/ && $col ~ /^(DX|AL|AK|AZ|AR|CA|CO|CT|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MA|MD|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY|NL|NB|NS|PE|QC|ON|BC|NT|NU|YT|BAR|BOW|BRC|CCE|CCF|CFL|CHE|CMD|CNH|CRR|CSD|CSH|CSK|EDC|EDG|EDM|EDW|EMW|ERB|EST|EWE|FTH|FTM|GPM|LAK|LTH|MED|PRW|RDL|RDM|SPK|STA|STR|YEL|BTL|CAR|CYP|DES|MOO|PRA|RGL|RGQ|RGW|SKG|SKU|SKW|SOU|YOR|BRS|CHA|CHR|DAU|ELM|KIL|POR|PRO|SEL|STB|WPC|WPN|WPS|WSC)$/) {
    if (lines[$1] != "") {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$1], $0) > "/dev/stderr";
    }
    else {
      printf("%s=%s\n", $1, $col);
      lines[$1] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/ && $col != "") {
    printf("Ignored: %s\n", $0) > "/dev/stderr";
  }
}
