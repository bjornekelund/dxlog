BEGIN {
  FS=","
}
{
  if ($1 ~ /!!Order!!/) 
  {
    if ($3 ~ /Sect/) col = 2;
    if ($4 ~ /Sect/) col = 3;
    if ($5 ~ /Sect/) col = 4;
    printf("%s --> col=%d\n", $0, col) > "/dev/stderr";
  } 
  else 
  {
    if ($1 ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/ && $col ~ /^(90|0[1-9]|[1-8][0-9])[A-R]{2}$/) 
    {
      printf("%s=%s\n", $1, $col);
    }
    else if ($0 !~ /^(!|#|$)/) 
    {
      printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
    }
  }
}
END {
  printf("#0 Ham Spirit Contest database\n");
  printf("#1 Based on data maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#4 Last updated %s\n", strftime("%Y-%m-%d"));
}
