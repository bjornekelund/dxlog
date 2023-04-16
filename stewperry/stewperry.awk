BEGIN {
  FS=","
}
{
  if ($1 ~ /^[0-9,A-Z]/ && $3 ~ /^[A-R][A-R][0-9][0-9]$/)
  {
    printf("%s=%s\n", $1, $3);
  }
  else if ($0 !~ /^(!|#|$)/ && $3 != "")
  {
    printf("Ignored: %s\n", $0) > "/dev/stderr";
  }
}
END {
  printf("#0 Stew Perry TBDC data base\n");
  printf("#1 Also used for Makrothen and CQ WW VHF contests\n");
  printf("#2 Data collected and maintained by VE2FK\n");
  printf("#3 Send new info/corrections to ve2fk@arrl.net\n");
  printf("#4 Last updated %s\n", strftime("%Y-%m-%d"));
}