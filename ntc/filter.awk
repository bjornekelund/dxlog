BEGIN {
  printf("#00 Netherlands Telegraphy Club QSO Party prefill database\n");
  FS = ",";
  longest = "";
  highest = 0;
}
{
  if ($1 ~ /!!Order!!/)
  {
    call = FindColumn("Call");
    exch = FindColumn("Exch1|Misc");
    name = FindColumn("Name");
    # printf("%s --> call=%d exch=%d, name=%d\n", $0, call, exch, name) > "/dev/stderr";
  }
  else if (IsValidCall($call) && $name ~ /^(|[a-zA-Z]+$)/ && $exch ~ /^([0-9]+|NM|)$/ && !($name == "" && $exch ~ /^(NM|)$/))
  {
    calls[$call] = $call;
    if (names[$call] == "") names[$call] = toupper($name);
    number = $exch;
    sub(/^0+/, "", number);
    if (exchs[$call] == "") exchs[$call] = number;
    longest = length($name) > length(longest) ? toupper($name) : longest;
    highest = int(number) > highest ? int(number) : highest;
  }
  else if ($0 !~ /^(!|#|$)/ && exch != "")
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
END {
  for (c in calls)
  {
      printf("%s=%s;%s\n", c, names[c], exchs[c] == "" ? "NM" : exchs[c]);
  }
  printf("Longest name is \"%s\" with %d characters\n", longest, length(longest)) > "/dev/stderr";
  printf("#04 Longest name is \"%s\" with %d characters\n", longest, length(longest));
  printf("Contains members up to #%d\n", highest) > "/dev/stderr";
  printf("#05 Contains members up to #%d\n", highest);
}
