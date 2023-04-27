BEGIN {
  FS=",";
  prevcall = "";
  printf("#0 Tesla Memorial database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
}
{
  call = $1;
  if (call ~ /^[0-9A-Z]+$/) {
    if (lines[$1] != "") {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$1], $0) > "/dev/stderr";
    }
    else {
      if ($3 != "")
        printf("%s=%s\n", $1, $3);
      else {
        printf("Info missing: \"%s\"\n", $0) > "/dev/stderr"
        lines[$1] = $0;
      }
    }
  }
  else if ($0 !~ /^(!|#|$)/) {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr"
  }
}
