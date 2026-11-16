BEGIN {
  FS = ",";
}
{
  if ($1 ~ /!!Order!!/)
  {
    call = FindColumn("Call");
    exch = FindColumn("Misc");
    name = FindColumn("Name");
    printf("%s --> call=%d exch=%d, name=%d\n", $0, call, exch, name) > "/dev/stderr";
  }
  else if (IsValidCall($call) && $name ~ /^(|[a-zA-Z]+$)/ && $exch ~ /^([0-9]+|)$/)
  {
    if (lines[$call] == "")
    {
      number = $exch;
      sub(/^0+/, "", number);
      if (number ~ /^[0-9]+$/) number = "NTC" number;
      printf("%s,%s,,%s\n", $call, toupper($name), number);
      lines[$call] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/ && $exch !~ /NM/)
  {
    printf("NTC: Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
