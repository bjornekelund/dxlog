BEGIN {
  FS=",";
}
{
  if ($1 ~ /!!Order!!/) 
  {
    if ($3 ~ /State|Exch1/) col = 2;
    if ($4 ~ /State|Exch1/) col = 3;
    if ($5 ~ /State|Exch1/) col = 4;
#    printf("\"%s\" --> col=%d\n", $0, col) > "/dev/stderr";
  } 
  else 
  {
    if ($1 ~ /^[0-9A-Z/]+$/ && $col ~ /(19|20)[0-9]{2}$/) 
    {
      if (year[$1] != $col && year[$1] != "")
        printf("Replaced %s with %s for %s\n", year[$1], $2, $1) > "/dev/stderr";
      year[$1] = $2;
    }
    else if ($0 !~ /^(!|#|$)/)
    {
      printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
    }
  }
}
END {
  for (call in year)
    printf("%s,%s,\n", call, year[call]);
}