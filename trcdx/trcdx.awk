BEGIN {
  printf("#00 TRC members prefill database\n");
  printf("#01 Based on data maintained by LZ1ONK and VE2FK\n");
  printf("#03 Last updated %s\n", strftime("%Y-%m-%d"));
  FS = ",";
}
{
  if ($1 ~ /!!Order!!/)
  {
    call = FindColumn("Call");
    col = FindColumn("Sect");
  # printf\("%s --> call=%d col=%d\n", $0, call, col) > "/dev/stderr";
  }
  else if (IsValidCall($call) && $col ~ /^TRC$/)
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
  else if ($0 !~ /^(#|!|$)/)
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
