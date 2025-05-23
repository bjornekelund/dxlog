BEGIN {
  FS=","
  maxlen = 0;
  maxname = "";
}
{
  bad = 0;
  exch = $3;
  if ($0 !~ /^(!|#|$)/) {
    if ($2 !~ /^([A-Z][A-Za-z]+)?$/) {
        printf("Problem name: \"%s\"\n", $0) > "/dev/stderr";
    }
    if ($1 ~ /^(A[A-L]|K[A-Z]?[0-9]|N[A-Z]?[0-9]|W[A-Z]?[0-9]|V[A-EOXY]|C[FGJK]|XL)/) {
      if (exch !~ /^(DX|AL|AK|AZ|AR|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY|AB|BC|LB|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)?$/) {
        printf("Problem exchange: \"%s\"\n", $0) > "/dev/stderr";
        bad = 1;
      }
    } else {
      if ($3 !~ /^DX$/) {
        printf("Exchange changed to DX: \"%s\"\n", $0) > "/dev/stderr";
        exch = "DX"
      }
    }
    if (!bad && ($2 != "" || exch != "")) {
      if (call[$1] != "") {
        printf("\"%s\" reoccurs as \"%s\"\n", line[$1], $0) > "/dev/stderr";
      }
      line[$1] = $0;
      call[$1] = $1;
      name[$1] = toupper($2);
      exchange[$1] = exch;
      if (length($2) > maxlen) {
        maxlen = length($2);
        maxname = $2;
      }
    }
  }
}
END {
  printf("#0 K1USN Slow Speed Test participants database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  for (c in call) {
    if (name[c] != "" && exchange[c] != "") {
      printf("%s=%s;%s\n", call[c], name[c], exchange[c]);
    }
  }
  printf("Longest name is \"%s\" with %d characters\n", maxname, maxlen) > "/dev/stderr";
}