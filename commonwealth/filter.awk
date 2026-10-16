BEGIN {
  printf("#00 Commonwealth Contest HQ stations prefill database\n");
  FS = ",";
}
{
  if ($1 ~ /!!Order!!/)
  {
    call = FindColumn("Call");
    state = FindColumn("State|Exch1");
    # printf("%s --> call=%d state=%d\n", $0, call, state) > "/dev/stderr";
  }
  else if (IsValidCall($call) && $state == "HQ")
  {
    printf("%s=%s\n", $call, $state);
  }
}
