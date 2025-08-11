BEGIN {
  FS=","
  printf("#0 A1 CLUB Weekly Contest database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  col = 2;
  maxlen = 0;
  maxname = "";
  limit = 10;
  printf("Name length limit set to %d\n", limit) > "/dev/stderr";
}
{
  if ($0 ~ "^!!Order!!") {
    if ($2 ~ /Name/) col = 1;
    if ($3 ~ /Name/) col = 2;
    if ($4 ~ /Name/) col = 3;
    if ($5 ~ /Name/) col = 4;
    printf("%s --> col=%d\n", $0, col) > "/dev/stderr";
  } else {
    nm = toupper($col);
    if ($1 ~ /^[0-9A-Z]/ && nm ~ /^[A-Z]+$/ && length(nm) <= limit) {
      if (call[$1] != "") {
        printf("\"%s\" reoccurs as \"%s\"\n", line[$1], $0) > "/dev/stderr";
      }
      else {
        line[$1] = $0;
        call[$1] = $1;
        name[$1] = nm;
        if (length(nm) > maxlen) {
          maxlen = length(nm);
          maxname = nm;
        }
      }
    }
    else if ($0 !~ /^(!|#|$)/)
      printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
END {
  for (cl in call) {
    printf("%s=%s\n", cl, name[cl]);
  }
  printf("Longest name is \"%s\" (%d)\n", maxname, maxlen) > "/dev/stderr";
}
