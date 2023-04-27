BEGIN {
  FS=","
  printf("#0 Database for SRR Digital Cup\n");
  printf("#1 Based on call history data by Valery UR7QM\n");
  printf("#2 Last updated %s\n", strftime("%Y-%m-%d"));
  col = 2;
}
{
  if ($0 ~ "!!Order!!") {
    if ($2 ~ /Loc1/) col = 1;
    if ($3 ~ /Loc1/) col = 2;
    if ($4 ~ /Loc1/) col = 3;
    if ($5 ~ /Loc1/) col = 4;
    printf("%s --> col=%d\n", $0, col) > "/dev/stderr";
  } else {
    if ($1 ~ /^[0-9A-Z\/]+$/ && $col ~ /^[A-Z]{2}[0-9]{2}$/)
      printf("%s=%s\n", $1, $col);
    else
      printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
