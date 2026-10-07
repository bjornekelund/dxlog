BEGIN {
  printf("#00@%s\n", strftime("%Y"));
  printf("#01 YOTA prefill database\n");
  FS = ",";
}
{
  if ($1 ~ /!!Order!!/)
  {
    if ($3 ~ /Exch1/) col = 2;
    if ($4 ~ /Exch1/) col = 3;
    if ($5 ~ /Exch1/) col = 4;
  # printf\("%s --> col=%s\n", $0, col) > "/dev/stderr";
  }
  else if ($1 ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/ && $col ~ /^[1-9][0-9]?$/)
  {
    if (lines[$1] != "")
    {
      printf("Repeated: \"%s\" and \"%s\"\n", lines[$1], $0) > "/dev/stderr";
    }
    else
    {
      if ($col ~ /^[1-9]$/) $col = "0" $col;
      printf("%s,%d\n", $1, $col);
    }
  }
  else if ($0 !~ /^(!|#|$)/)
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
