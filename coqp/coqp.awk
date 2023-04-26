BEGIN {
  FS=","
  printf("#0 Colorado QSO Party database\n");
  printf("#1 Based on NAQP database maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  maxlen = 0;
  longest = "";
}
{
  if ($0 ~ "!!Order!!") {
    if ($2 ~ /State/) state = 1;
    if ($3 ~ /State/) state = 2;
    if ($4 ~ /State/) state = 3;
    if ($5 ~ /State/) state = 4;
    if ($2 ~ /Name/) name = 1;
    if ($3 ~ /Name/) name = 2;
    if ($4 ~ /Name/) name = 3;
    if ($5 ~ /Name/) name = 4;
    printf("%s --> state=%d\n", $0, $state) > "/dev/stderr";
  } else {
    if (lines[$1] != "") {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$1], $0) > "/dev/stderr";
    }
    else {
      if ($1 ~ /^(A[A-L]|K[A-Z]?[0-9]|N[A-Z]?[0-9]|W[A-Z]?[0-9]|V[A-EOXY]|4U)/ && $state ~ /^(AL|AK|AZ|AR|CA|CT|DC|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY|AB|BC|LB|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/) {
        if (length($name) > maxlen) {
          maxlen = length($name);
          longest = $name;
        }
        printf("%s=%s;%s\n", toupper($1), toupper($name), toupper($state));
        line[$1] = $0;
      }
      else if ($0 !~ /^(!|#|$)/ && $state !~ /^(CO|)$/) {
        printf("Ignored: %s\n", $0) > "/dev/stderr";
      }
    }
  }
}
END {
  printf("Longest name is %s (%d)\n", longest, maxlen) > "/dev/stderr";
}
