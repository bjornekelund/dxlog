BEGIN {
  printf("#00 SP DX Contest prefill database\n");
  FS = ",";
  col = 2;
  call = 1;
}
{
  if ($call ~ /!!Order!!/)
  {
    if ($3 ~ /Sect/) col = 2;
    if ($4 ~ /Sect/) col = 3;
    if ($5 ~ /Sect/) col = 4;
  # printf\("%s --> Column is %d\n", $0, col) > "/dev/stderr";
  }
  else if ($call ~ /^(SP[0-9]?\/[A-Z0-9]+|(3Z|HF|S[NOPQ])[0-9]{1,4}[A-Z]{1,5}(\/[1-9PM])?)$/ && $col ~/^[BCDFGJKLMOPRSUWZ]$/)
  {
    if (lines[$call] != "")
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$call], $0) > "/dev/stderr";
    }
    else
    {
      lines[$call] = $0;
      printf("%s=%s\n", $call, $col);
    }
  }
  else if ($0 !~ /^(!|#|$)/)
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
