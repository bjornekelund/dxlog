BEGIN {
  printf("#0 JIDXC prefill database\n");
  printf("#2 Data collected and maintained by Claude VE2FK\n");
  printf("#3 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#4 Last updated %s\n", strftime("%Y-%m-%d"));
  FS=","  
}
{
  if ($1 ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/ && $2 ~/[0-9]{1,2}/)
  {
    if (lines[$1] != "")
    {
      printf("Repeated: \"%s\" and \"%s\"\n", lines[$1], $0) > "/dev/stderr";
    }
    else
    {
      printf("%s=%s\n", $1, $2);
      lines[$1] = $0;
    }
  }
  else if ($0 !~ /^(#|!| *$)/ && $2 != "")
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr"
  }
}
