BEGIN {
  printf("#00 Bavarian Contest Club QSO Party prefill database\n");
  FS = ",";
}
{
  if ($1 ~ /!!Order!!/)
  {
    call = FindColumn("Call");
    size = FindColumn("Exch1");
  # printf\("%s --> call=%d size=%d\n", $0, call, size) > "/dev/stderr";
  }
  else if ( \
    (IsValidCall($call) && $size ~ /^(XS|S|M|L|XL|2XL|3XL|4XL|5XL)$/) )
  {
    if (lines[$call] != "")
    {
      # printf("\"%s\" reoccurs as \"%s\"\n", lines[$call], $0) > "/dev/stderr";
    }
    else
    {
      printf("%s=%s\n", $call, $size);
      lines[$call] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/)
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
