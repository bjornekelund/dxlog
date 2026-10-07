BEGIN {
  FS = ",";
}
{
  if ($1 ~ /!!Order!!/)
  {
    if ($2 ~ /Call/) call = 1;
    if ($3 ~ /Call/) call = 2;
    if ($4 ~ /Call/) call = 3;
    if ($5 ~ /Call/) call = 4;
    if ($3 ~ /Exch1/) exch = 2;
    if ($4 ~ /Exch1/) exch = 3;
    if ($5 ~ /Exch1/) exch = 4;
    if ($3 ~ /Name/) name = 2;
    if ($4 ~ /Name/) name = 3;
    if ($5 ~ /Name/) name = 4;
    # printf("%s --> call=%d exch=%d, name=%d\n", $0, call, exch, name) > "/dev/stderr";
  }
  else if ($call ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/ && $name ~ /^(|[a-zA-Z]+$)/ && $exch ~ /^[0-9]+$/)
  {
    if (lines[$call] == "")
    {
      number = $exch;
      sub(/^0+/, "", number);
      printf("%s,%s,,NTC%s\n", $call, toupper($name), number);
      lines[$call] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/ && $exch !~ /NM/)
  {
    printf("NTC: Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
