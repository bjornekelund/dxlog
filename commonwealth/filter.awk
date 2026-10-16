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
  else if ($call ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/ && $state == "HQ")
  {
    printf("%s=%s\n", $1, $3);
  }
}
