BEGIN {
  FS=","
  printf("#0 YU DX contest database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  col = 2;
}
{
  if ($0 ~ "!!Order!!") {
    if ($3 ~ /Exch1/) col = 2;
    if ($4 ~ /Exch1/) col = 3;
    if ($5 ~ /Exch1/) col = 4;
    printf("%s --> col=%d\n", $0, col) > "/dev/stderr";
  } else {
    if ($1 ~ /^[0-9A-Z/]+$/ && $col ~ /^(BGD|BOR|BRA|JAB|JBB|JBN|KMO|KOL|KOS|KPO|MAC|MOR|NIS|PCI|PEC|PIR|POD|POM|PRI|RAN|RAS|SBB|SBN|SBT|SRM|SUM|TOP|ZAJ|ZBB|ZLA)$/)
      printf("%s=%s\n", $1, $col);
    else if ($0 !~ /^(!|#|$)/)
      printf("Invalid exchange: \"%s\"\n", $0) > "/dev/stderr";
  } 
}
