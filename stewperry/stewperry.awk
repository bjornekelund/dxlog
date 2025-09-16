BEGIN {
  printf("#0 Stew Perry TBDC data base\n");
  printf("#1 Also used for Makrothen, Maidenhead Mayhem, Russian 160m, Solar Eclipse QP, and CQ WW VHF contests\n");
  printf("#2 Data collected and maintained by VE2FK\n");
  printf("#3 Send new info/corrections to ve2fk@arrl.net\n");
  printf("#4 Last updated %s\n", strftime("%Y-%m-%d"));
  FS=","
}
{
  if ($1 ~ /^[0-9A-Z]/ && $3 ~ /^[A-R]{2}[0-9]{2}$/) {
    if (lines[$1] != "") {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$1], $0) > "/dev/stderr";
    }
    else {
      printf("%s=%s\n", $1, $3);
      lines[$1] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/ && $3 != "") {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
