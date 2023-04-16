BEGIN {
  FS=","
  col = 2;
}
{
  if ($1 ~ /^[0-9,A-Z,\/]+$/ && $col ~ /^[1-9][0-9]?$/) 
    printf("%s,%s,\n", $1, $col < 99 && $col > 0 ? $col + 1 : $col);
  else if ($0 !~ /^(!|#|$)/)
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  else
    printf("%s\n", $0);
}
