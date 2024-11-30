BEGIN {
  FS=","
  printf("#1 Operator names based on data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  maxlen = 0;
  maxname = "";
}
{
  call = toupper($1)
  if (call ~ /^[0-9A-Z/]+$/ && $2 ~ /^[A-Za-z .\-0-9]+$/) {
    if ($2 != "") {
      printf("%s=%s\n", call, toupper($2));
      if (length($2) > maxlen) {
        maxlen = length($2);
        maxname = $2;
      }
    }
  }
  else if ($0 !~ /^(!|#|$)/) {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
END {
  printf("#3 Longest name is %s (%d)\n", maxname, maxlen);
  printf("Longest name is %s (%d)\n", maxname, maxlen) > "/dev/stderr";
  printf("#4 Last updated %s\n", strftime("%Y-%m-%d"));
}
