BEGIN {
  printf("!!Order!!,Call,Name,UserText,\n");
  longest = "";
  FS = ",";
}
{
  if ($1 ~ /!!Order!!/)
  {
    if ($2 ~ /Call/) call = 1;
    if ($3 ~ /Call/) call = 2;
    if ($4 ~ /Call/) call = 3;
    if ($5 ~ /Call/) call = 4;
    if ($3 ~ /Name/) name = 2;
    if ($4 ~ /Name/) name = 3;
    if ($5 ~ /Name/) name = 4;
    if ($3 ~ /UserText/) text = 2;
    if ($4 ~ /UserText/) text = 3;
    if ($5 ~ /UserText/) text = 4;
    # printf("%s --> call=%d name=%d text=%d\n", $0, call, name, text) > "/dev/stderr";
  }
  else
  {
    if ($call ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/)
    {
      if (calls[$call] != "")
      {
        if (toupper(names[$call]) != toupper($name)) {
          if (names[$call] != "") {
            printf("Using Name \"%s\" instead of \"%s\" for %s\n", names[$call], $name, $call) > "/dev/stderr";
          }
          else {
            names[$call] = $name;
          }
        }
        if (texts[$call] == "" && $text != "") {
          # printf("Updating UserText to \"%s\" for %s\n", $text, $call) > "/dev/stderr";
          texts[$call] = $text;
        }
      }
      else
      {
        calls[$call] = $call;
        names[$call] = $name;
        texts[$call] = $text;
      }
    }
    else if ($0 !~ /^(!|#)/)
    {
      printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
    }
  }
}
END {
  for (call in calls) {
    # printf("%s,%s,%s\n", call, names[call], texts[call]);
    printf("%s,%s,\n", call, toupper(names[call]));
    longest = length(names[call]) > length(longest) ? names[call] : longest;
  }
  printf("Longest name is \"%s\" with %d characters\n", longest, length(longest)) > "/dev/stderr";
}