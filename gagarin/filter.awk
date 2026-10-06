BEGIN {
  printf("#00 Yuri Gagarin International DX Contest prefill database\n");
  FS = ",";
}
{
  if ($1 ~ /!!Order!!/)
  {
    if ($2 ~ /Call/) call = 1;
    if ($3 ~ /Call/) call = 2;
    if ($4 ~ /Call/) call = 3;
    if ($5 ~ /Call/) call = 4;
    if ($2 ~ /Sect/) col = 1;
    if ($3 ~ /Sect/) col = 2;
    if ($4 ~ /Sect/) col = 3;
    if ($5 ~ /Sect/) col = 4;
  # printf\("%s --> call=%d col=%d\n", $0, call, col) > "/dev/stderr";
  }
  else if ($call ~ /[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+$/ && $col ~ /^[A-Z]{2}$/)
  {
    printf("%s=%s\n", $call, $col);
  }
  else if ($0 !~ /^(!|#|$)/)
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
