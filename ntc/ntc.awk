BEGIN {
  printf("#0 Netherlands Telegraphy Club QSO Party database\n");
  printf("#1 Based on data collected and maintained by Claude VE2FK\n");
  printf("#2 Send updates/corrections to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  FS=",";
  maxlen = 0;
  maxname = "";
}
{
  if ($1 ~ /!!Order!!/)
  {
    if ($3 ~ /Exch1/) exch = 2;
    if ($4 ~ /Exch1/) exch = 3;
    if ($5 ~ /Exch1/) exch = 4;
    if ($3 ~ /Name/) name = 2;
    if ($4 ~ /Name/) name = 3;
    if ($5 ~ /Name/) name = 4;
    printf("%s --> exch=%d, name=%d\n", $0, exch, name) > "/dev/stderr";
  } 
  else if ($1 ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/ && $name ~ /^(|[a-zA-Z]+$)/ && $exch ~ /^([0-9]+|NM)$/) 
  {
    if (lines[$1] != "") 
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$1], $0) > "/dev/stderr";
    }
    else 
    {
      sub(/^0+/, "", $exch);
      printf("%s=%s;%s\n", $1, $name, $exch);
      lines[$1] = $0;
    }
    if (length($name) > maxlen) 
    {
      maxlen = length($name);
      maxname = $name;
    }
  }
  else if ($0 !~ /^(!|#|$)/)
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr"
  }
}
END {
  printf("Longest name is \"%s\" which is %d characters long.\n", maxname, maxlen) > "/dev/stderr";
}