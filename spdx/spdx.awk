BEGIN {
  FS=","
  max = 0;
  printf("#0 SP DX participants database\n");
  printf("#1 Based on call history data by Chris SP5KP, SN5N\n");
  printf("#2 Last updated %s\n", strftime("%Y-%m-%d"));
  col = 2;
}
{
  if ($1 ~ /!!Order!!/)
  {
    if ($3 ~ /Sect/) col = 2;
    if ($4 ~ /Sect/) col = 3;
    if ($5 ~ /Sect/) col = 4;
    printf("%s --> Column is %d\n", $0, col) > "/dev/stderr";
  }
  else if ($1 ~ /^(SP\/[A-Z0-9]+|(3Z|HF|S[NOPQ]))[0-9]{1,4}[A-Z]{1,4}(\/[1-9PM])?$/ && $col ~/^[BCDFGJKLMOPRSUWZ]$/)
  { 
    if (lines[$1] != "")
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$1], $0) > "/dev/stderr";
    }
    else
    {
      lines[$1] = $0;
      printf("%s=%s\n", $1, $col);
    }
  }
  else if ($0 !~ /^(!|#|$)/)
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
