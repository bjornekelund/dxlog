BEGIN {
  FS=";"
  max = 0;
}
{
  if ($2 ~ /^[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+$/ && $1 ~ /^[1-9][0-9]*$/) 
  {
    max = ($1 > max) ? $1 : max;
    printf("%s=%s\n", $2, $1);
  }
  else if ($0 !~ /#/ && $0 !~ /SWL/) 
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr"
  }
}
END {
  printf("#00 AGCW members database\n");
  printf("#01 Based on official member roster at www.agcw.de\n");
  printf("#02 Contains members up to #%d\n", max);
  printf("#03 Last updated %s\n", strftime("%Y-%m-%d"));
}