BEGIN {
  printf("#00 Netherlands Telegraphy Club QSO Party prefill database\n");
  printf("#01 Based on data maintained by Claude VE2FK\n");
  printf("#02 Send updates/corrections to ve2fk@arrl.net\n");
  printf("#05 Last updated %s\n", strftime("%Y-%m-%d"));
  FS = ",";
  longest = "";
  highest = 0;
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
  else if ($call ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/ && $name ~ /^(|[a-zA-Z]+$)/ && $exch ~ /^([0-9]+|NM)$/)
  {
    if (lines[$call] != "")
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$call], $0) > "/dev/stderr";
    }
    else
    {
      number = $exch;
      sub(/^0+/, "", number);
      printf("%s=%s;%s\n", $call, toupper($name), number);
      lines[$call] = $0;
      longest = length($name) > length(longest) ? toupper($name) : longest;
      highest = int(number) > highest ? int(number) : highest;
    }
  }
  else if ($0 !~ /^(!|#|$)/)
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
END {
  printf("Longest name is \"%s\" with %d characters\n", longest, length(longest)) > "/dev/stderr";
  printf("#03 Longest name is \"%s\" with %d characters\n", longest, length(longest));
  printf("Contains members up to #%d\n", highest) > "/dev/stderr";
  printf("#04 Contains members up to #%d\n", highest);
}