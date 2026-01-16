BEGIN {
  printf("#00 POTA activation prefill database\n");
  printf("#01 Last updated %s\n", strftime("%Y-%m-%d"));
  FS = ",";
}
{
  if ($1 ~ /!!Order!!/)
  {
    if ($2 ~ /Call/) call = 1;
    if ($3 ~ /Call/) call = 2;
    if ($4 ~ /Call/) call = 3;
    if ($5 ~ /Call/) call = 4;
    if ($3 ~ /Name/) name = 2;
    if ($4 ~ /Name/) name = 3;
    if ($5 ~ /Name/) name = 4;
    printf("%s --> call=%d name=%d\n", $0, call, name) > "/dev/stderr";
  }
  else if ($call ~ /^[A-Z0-9]+$/ && $call ~ /[0-9]+/ && $call ~ /[A-Z]+/)
  {
    if (lines[$call] != "")
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$call], $0) > "/dev/stderr";
    }
    else
    {
      printf("%s=%s\n", $call, $name);
      lines[$call] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/ && $call !~ /\//)
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
