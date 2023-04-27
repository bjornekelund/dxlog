BEGIN {
  printf("#0 Netherlands Telegraphy Club QSO Party database\n");
  printf("#1 Based on data collected and maintained by Claude VE2FK\n");
  printf("#2 Send updates/corrections to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  FS=",";
  maxlen = 0;
  maxname = "";
}
{
  if ($1 ~ /^[A-Z0-9/]+$/ && $2 ~ /^(|[a-zA-Z]+$)/ && $3 ~ /^([0-9]+|NM)$/) {
    if (lines[$1] != "") {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$1], $0) > "/dev/stderr";
    }
    else {
      printf("%s=%s;%s\n", $1, $2, $3);
      lines[$1] = $0;
    }
    if (length($2) > maxlen) {
      maxlen = length($2);
      maxname = $2;
    }
  }
  else if ($0 !~ /^(!|#|$)/)
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr"
}
END {
  printf("Longest name is \"%s\" which is %d characters long.\n", maxname, maxlen) > "/dev/stderr";
}