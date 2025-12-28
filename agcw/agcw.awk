BEGIN {
  FS=";"
  max = 0;
}
{
  if ($2 ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/ && $1 ~ /[0-9]+/) 
  {
    if ($1 > max) max = $1;
    printf("%s=%s\n", $2, $1);
  }
  else if ($0 !~ /#/ && $0 !~ /SWL/) 
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr"
  }
}
END {
  printf("#0 AGCW members database\n");
  printf("#1 Based on official member roster at www.agcw.de\n");
  printf("#2 Contains members up to #%d\n", max);
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
}