BEGIN {
  printf("#00 10-10 QSO Party database\n");
  printf("#01 Data collected and maintained by Claude VE2FK\n");
  printf("#02 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#03 Last updated %s\n", strftime("%Y-%m-%d"));
  FS=","
  longest = "";
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
    if ($3 ~ /Exch1/) loc = 2;
    if ($4 ~ /Exch1/) loc = 3;
    if ($5 ~ /Exch1/) loc = 4;
    if ($3 ~ /Misc/) mem = 2;
    if ($4 ~ /Misc/) mem = 3;
    if ($5 ~ /Misc/) mem = 4;
    printf("%s --> call=%d name=%d loc=%d mem=%d\n", $0, call, name, loc, mem) > "/dev/stderr";
  } 
  else if ( \
    $call ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/ && \
    $name ~ /^([a-zA-Z]*|)$/ && $loc ~ /^[A-Z]+|$/ && $mem ~ /^([0-9]*|)$/)
  {
    if (calls[$call] != "") 
    {
      printf("\"%s\" reoccurs as \"%s\"\n", line[$call], $0) > "/dev/stderr"
    }
    line[$call] = $0;
    calls[$call] = $call;
    names[$call] = toupper($name);
    num[$call] = $mem ~ /^[0-9]+$/ ? $mem : "0";
    if ($loc ~ /^(AL|AK|AZ|AR|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY|AB|BC|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/)
    {
      location[$call] = $loc;
    }
    else
    {
      location[$call] = "";
    }
    longest = length($name) > length(longest) ? $name : longest;
  }
  else if ($0 !~ /^(!|#|$)/) 
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr"
  }
}
END {
  printf("Longest name is %s (%d)\n", longest, length(longest)) > "/dev/stderr";
  for (c in calls) 
  {
    printf("%s=%s;%s;%s\n", calls[c], names[c], num[c], location[c]);
  }
}