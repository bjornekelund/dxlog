BEGIN {
  FS=","
  printf("#0 POTA activation database\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  col = 2;
}
{
  if ($1 ~ /!!Order!!/) 
  {
    if ($3 ~ /Name/) col = 2;
    if ($4 ~ /Name/) col = 3;
    if ($5 ~ /Name/) col = 4;
    printf("%s --> col=%d\n", $0, col) > "/dev/stderr";
  } 
  else if ($1 ~ /^[A-Z0-9]+$/ && $1 ~ /[0-9]+/ && $1 ~ /[A-Z]+/) 
  {
    if (lines[$1] != "") 
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$1], $0) > "/dev/stderr";
    }
    else 
    {
      printf("%s=%s\n", $1, $col);
      lines[$1] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/ && $1 !~ /\//) 
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
} 
