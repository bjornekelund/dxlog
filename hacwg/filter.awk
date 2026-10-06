BEGIN {
  printf("#00 HACWG members prefill database\n");
  FS = ",";
}
{
  if ($1 ~ /!!Order!!/)
  {
    if ($2 ~ /Call/) call = 1;
    if ($3 ~ /Call/) call = 2;
    if ($4 ~ /Call/) call = 3;
    if ($5 ~ /Call/) call = 4;
    if ($2 ~ /Misc/) col = 1;
    if ($3 ~ /Misc/) col = 2;
    if ($4 ~ /Misc/) col = 3;
    if ($5 ~ /Misc/) col = 4;
  # printf\("%s --> call=%d col=%d\n", $0, call, col) > "/dev/stderr";
  }
  else if ($call ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/ && $col ~ /^[1-9][0-9]*$/)
  {
    if (lines[$call] != "")
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$call], $0) > "/dev/stderr";
    }
    else
    {
      printf("%s=%s\n", $call, $col);
      lines[$call] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/ && $col != "")
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
