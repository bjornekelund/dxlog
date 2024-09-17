BEGIN {
  FS=","
  printf("#0 New Jersey QSO Party database\n");
  printf("#1 Based data maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
}
{
    if ($0 ~ "!!Order!!") {
    if ($3 ~ /Exch1|State/) col = 2;
    if ($4 ~ /Exch1|State/) col = 3;
    if ($5 ~ /Exch1|State/) col = 4;
    printf("%s --> col=%d\n", $0, col) > "/dev/stderr";
  } 
 else if ($1 ~ /^(A[A-L]|K[A-Z]?[0-9]|N[A-Z]?[0-9]|W[A-Z]?[0-9]|V[A-EOXY]|4U)/ && $col ~ /^(DX|AL|AK|AZ|AR|CA|CT|CO|DC|DE|FL|GA|HI|ID|IL|IA|IN|KS|KY|LA|ME|MD|MA|MI|MN|MO|MS|MT|NE|NV|NH|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY|AB|BC|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT|ATLA|BERG|BURL|CAPE|CMDN|CUMB|ESSE|GLOU|HUDS|HUNT|MERC|MIDD|MONM|MORR|OCEA|PASS|SALE|SOME|SUSS|UNIO|WRRN)$/) {
    if (lines[$1] != "") {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$1], $0) > "/dev/stderr";
    }
    else {
      printf("%s=%s\n", $1, $col);
      lines[$1] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/ && $col != "NJ") {
    printf("Ignored: %s\n", $0) > "/dev/stderr";
  }
}
