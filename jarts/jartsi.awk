BEGIN {
  FS=",";
  col = 2;
}
{
  if ($1 ~ /^[0-9A-Z/]+$/ && $col ~ /^[0-9]{1,2}?$/) 
  {
    if (lines[$1] != "")
      printf("Repeated: \"%s\" and \"%s\"\n", lines[$1], $0) > "/dev/stderr";
    if ($col != "00" && $col != "99")
      printf("%s,%s,\n", $1, $col + 1);
    else
      printf("%s,%s,\n", $1, $col);
  }
  else if ($0 !~ /^(!|#|$)/) 
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  else
    printf("%s\n", $0);
}
