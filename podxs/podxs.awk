BEGIN {
  FS=","
  printf("#0 PODXS 070 members database\n");
  printf("#1 Based on data from https://www.podxs070.com/070-club-member-list\n");
  printf("#2 Cleaned and formatted by SM7IUN sm7iun@sm7iun.se\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
}
{
  if ($1 ~ /^[1-9][0-9]*$/ && $2 ~ /^[0-9A-Z/]+$/ )
    printf("%s=%s\n", $2, $1);
  else if ($0 !~ /^(!|#|$)/)
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
}
