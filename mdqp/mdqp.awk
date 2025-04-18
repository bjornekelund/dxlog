BEGIN {
  FS=","
  printf("#0 Maryland-DC QSO Party database\n");
  printf("#1 Based on NAQP database maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
}
{
  if ($1 ~ /^(A[A-L]|K[A-Z]?[0-9]|N[A-Z]?[0-9]|W[A-Z]?[0-9]|V[A-EOXY])/ && $3 ~ /^(AL|AK|AZ|AR|CA|CO|CT|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY|NL|LB|NF|NB|NS|PE|PEI|QC|ON|MB|SK|AB|BC|NT|NU|YT|ALY|ANA|BAL|BCT|CLV|CLN|CRL|CEC|CHS|DRC|FRD|GAR|HFD|HWD|KEN|MON|PGE|QAN|STM|SMR|TAL|WAS|WIC|WRC|WDC)$/) {
    if (lines[$1] != "") {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$1], $0) > "/dev/stderr";
    }
    else {
      printf("%s=%s\n", $1, $3);
      lines[$1] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/ && $3 !~ /^(MD|DC|)$/) {
    printf("Ignored: %s\n", $0) > "/dev/stderr";
  }
}
