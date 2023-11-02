BEGIN {
  FS=","
  col = 2;
}
{
  if ($1 ~ /^[0-9A-Z/]+$/ && $col ~ /^[0-9]{1,2}?$/) 
    printf("%s,%s,\n", $1, $col + 1);
  else if ($0 !~ /^(!|#|$)/)
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  else
    printf("%s\n", $0);
}
