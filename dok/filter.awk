BEGIN {
  printf("#00 German DOK prefill database\n");
  FS = ",";
  longest = "";
}
{
  if ($1 ~ /!!Order!!/)
  {
    call = FindColumn("Call");
    exch = FindColumn("State|Exch1");
    # printf("%s --> call=%d exch=%d\n", $0, call, exch) > "/dev/stderr";
  }
  else if (IsValidCall($call) && $exch ~ /^[A-Z0-9]+$/)
  {
    printf("%s=%s\n", $call, $exch);
    longest = length($exch) > length(longest) ? $exch : longest;
  }
  else if ($0 !~ /^(!|#|$)/ && $exch != "")
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
END {
  printf("#04 Longest DOK is %s with %d characters.\n", longest, length(longest));
  printf("Longest DOK is \"%s\" with %d characters\n", longest, length(longest)) > "/dev/stderr";
}