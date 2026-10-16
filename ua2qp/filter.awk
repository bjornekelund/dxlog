BEGIN {
  printf("#00 UA2 QSO Party prefill database\n");
  FS = ",";
}
{
  if ($1 ~ /!!Order!!/)
  {
    call = FindColumn("Call");
    state = FindColumn("State|Exch1");
  # printf\("%s --> call=%d state=%d\n", $0, call, state) > "/dev/stderr";
  }
  else if (IsValidCall($call) && $state ~ /^KA[0-9]{2}$/)
  {
    if (lines[$call] != "")
    {
      # printf("\"%s\" reoccurs as \"%s\"\n", lines[$call], $0) > "/dev/stderr";
    }
    else
    {
      printf("%s=%s\n", $call, $state);
      lines[$call] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/ && $state ~ /^KA/)
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
