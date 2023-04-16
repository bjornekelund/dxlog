BEGIN {
  FS=","
  printf("#0 Yuri Gagarin International DX Contest database\n");
  printf("#1 Data maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  col = 3;
}
{
  if ($1 ~ /!!Order!!/) {
    if ($2 ~ /Sect/) col = 1;
    if ($3 ~ /Sect/) col = 2;
    if ($4 ~ /Sect/) col = 3;
    if ($5 ~ /Sect/) col = 4;
#    printf("%s --> Column is %d\n", $0, col) > "/dev/stderr";
  } else {
    exch = $col;
    if ($1 ~ /^[0-9,A-Z,\/]+$/ && $col ~ /^[A-Z][A-Z]$/)
      printf("%s=%s\n", $1, exch);
	else if ($0 !~ /^(!|#|$)/)
      printf("Ignored: %s\n", $0) > "/dev/stderr";
  }
}