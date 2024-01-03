BEGIN {
  FS=","
  printf("#0 Weekly RTTY Contest database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  maxlen = 0;
  longest = "";
}
{
  if (lines[$1] != "") {
    printf("\"%s\" reoccurs as \"%s\"\n", lines[$1], $0) > "/dev/stderr";
  }
  else {
    if ($1 ~ /^(A[A-L]|K[A-Z]?[0-9]|N[A-Z]?[0-9]|W[A-Z]?[0-9]|V[A-EOXY]|4U)/ && $3 ~ /^(AL|AK|AZ|AR|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY|AB|BC|LB|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/) {
      if (length($2) > maxlen) {
        maxlen = length($2);
        longest = $2;
      }
      printf("%s=%s;%s\n", $1, $2, $3);
      lines[$1] = $0;
    } 
    else if ($1 ~ /^[A-Z0-9]/ && $1 !~ /^(A[A-L]|K[A-Z]?[0-9]|N[A-Z]?[0-9]|W[A-Z]?[0-9]|V[A-EOXY]|4U)/ || $1 ~ /^(KG4|[KN]P[234])/) {
      if (length($2) > maxlen) {
        maxlen = length($2);
        longest = $2;
      }
      pfx = "";
      if (pfx == "") {
        printf("Unidentified: \"%s\"\n", $0) > "/dev/stderr";
      }
      printf("%s=%s;%s\n", $1, $2, pfx);
    }
    else if ($0 !~ /^(!|#|$)/) {
      printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
    }
  }
}
END {
  printf("Longest name is %s (%d)\n", longest, maxlen) > "/dev/stderr";
}