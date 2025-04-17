BEGIN {
  printf("#0 JIDXC prefill database\n");
  printf("#2 Data collected and maintained by Claude VE2FK\n");
  printf("#3 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#4 Last updated %s\n", strftime("%Y-%m-%d"));
  FS=","  
}
{
  if ($1 ~ /^[0-9A-Z/]+$/ && $2 ~/[0-9]{1,2}/)
    printf("%s=%s\n", $1, $2);
  else if ($0 !~ /^(#|!| *$)/ && $2 != "")
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr"
}
