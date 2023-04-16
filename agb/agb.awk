BEGIN {
  FS=" "
  printf("#0 AGB members database\n");
  printf("#1 Based on http://ev5agb.com/club/agb-list.txt\n");
  printf("#2 Last updated %s\n", strftime("%Y-%m-%d"));
  col = 2;
}
{
  if ($1 ~ /^[0-9]+$/ && $2 ~ /^[A-Z0-9\/]+$/)
    printf("%s=%s\n", $2, $1);
  else if ($0 !~ /^N/)
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
}
