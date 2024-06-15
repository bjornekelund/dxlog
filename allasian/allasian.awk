BEGIN {
  FS=","
  col = 2;
  printf("#0@%s\n", strftime("%Y"));
  printf("#1 All Asian database for %s\n", strftime("%Y"));
  printf("#2 Data collected and maintained by Claude VE2FK\n");
  printf("#3 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#4 Last updated %s\n", strftime("%Y-%m-%d"));

}
{
  if ($1 ~ /^[0-9A-Z/]+$/ && $col ~ /^[0-9]{1,2}?$/) 
  {
    if (lines[$1] != "")
      printf("Repeated: \"%s\" and \"%s\"\n", lines[$1], $0) > "/dev/stderr";
    else
      printf("%s=%s\n", $1, $col);
  }
  else if ($0 !~ /^(!|#|$)/) 
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
