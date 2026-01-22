BEGIN {
  printf("#00 AGCW members prefill database\n");
  printf("#01 Based on official member roster at www.agcw.de\n");
  printf("#03 Last updated %s\n", strftime("%Y-%m-%d"));
  FS = ";";
  max = 0;
  mem = 1;
  call = 2;
  name = 3;
}
{
  if ($call ~ /^[1-9]?[A-Z]{1,2}[0-9]{1,2}[A-Z]{1,3}$/ && $mem ~ /^[1-9][0-9]*$/)
  {
    if (lines[$call] != "")
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$call], $0) > "/dev/stderr";
    }
    else 
    {
      max = ($1 > max) ? $1 : max;
      printf("%s=%s\n", $2, $1);
      lines[$call] = $0;
    }
  }
  else if ($0 !~ /#/ && $0 !~ /SWL/)
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
END {
  printf("#02 Contains members up to #%d\n", max);
  printf("Highest member number is %d\n", max) > "/dev/stderr";
}