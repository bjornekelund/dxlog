BEGIN {
  FS=","
  printf("#0 German DOK database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  col = 2;
  max = 0;
}
{
  if ($0 ~ "!!Order!!") {
    if ($3 ~ /Exch1/) col = 2;
    if ($4 ~ /Exch1/) col = 3;
    if ($5 ~ /Exch1/) col = 4;
    printf("%s --> Exchange column is %d\n", $0, col) > "/dev/stderr";
  } 
  else if ($1 ~ /^[0-9A-Z/]+$/ && $col ~ /^[A-Z0-9]+$/) {
    printf("%s=%s\n", $1, $col);
    if (length($col) > max) {
      longest = $col;
      max = length($col);
    }
  }
  else if ($0 !~ /^(!|#|$)/) {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
END {
  printf("Longest DOK is %s which is %d characters.\n", longest, max) > "/dev/stderr"; 
}