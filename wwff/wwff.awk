BEGIN {
  FS=","
  printf("#0 WWFF activation database\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  col = 2;
}
{
  if ($0 ~ "!!Order!!") {
    if ($3 ~ /Name|NAME/) col = 2;
    if ($4 ~ /Name|NAME/) col = 3;
    if ($5 ~ /Name|NAME/) col = 4;
      printf("%s --> col=%d\n", $0, col) > "/dev/stderr";
  } 
  else if ($1 ~ /^[A-Z0-9]+$/ && $1 ~ /[0-9]+/ && $1 ~ /[A-Z]+/) {
    printf("%s=%s\n", $1, $col);
    lines[$1] = $0;
  }
  else if ($0 !~ /^(!|#|$)/) {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
} 
