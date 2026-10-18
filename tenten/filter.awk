BEGIN {
  printf("#00 10-10 QSO Party prefill database\n");
  FS = ",";
  longest = "";
}
{
  if ($1 ~ /!!Order!!/)
  {
    call = FindColumn("Call");
    name = FindColumn("Name");
    loc = FindColumn("Exch1");
    memnumber = FindColumn("Misc");
  # printf\("%s --> call=%d name=%d loc=%d memnumber=%d\n", $0, call, name, loc, memnumber) > "/dev/stderr";
  }
  else if (IsValidCall($call) && $name ~ /^([a-zA-Z]*|)$/ && $loc ~ /^[A-Z]+|$/ && $memnumber ~ /^([0-9]*|)$/)
  {
    if (calls[$call] != "")
    {
      printf("\"%s\" reoccurs as \"%s\"\n", line[$call], $0) > "/dev/stderr";
    }
    line[$call] = $0;
    calls[$call] = $call;

    if (toupper($name) !~ /CLUB/)
    {
      names[$call] = toupper($name);
    }
    else
    {
      names[$call] = "";
      printf("Name is \"%s\" for %s\n", $name, $call) > "/dev/stderr";
    }
 
    num[$call] = $memnumber ~ /^[0-9]+$/ ? $memnumber : "0";

    if ( \
      (IsUScall($call) && $loc ~ /^(AL|AK|AZ|AR|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY|KH[02]|GU)$/) || \
      (IsVEcall($call) && $loc ~ /^(AB|BC|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/) )
    {
      location[$call] = $loc;
    }
    else if (\
      (($call ~ /^(A[A-L]|[KNW][A-OQ-Z]?)[0-9]([A-Z]+|\/)|\/W[0-9]$/ && $loc !~ /^(AL|AK|AZ|AR|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY|KH[02]|GU)$/) || \
      (IsVEcall($call) && $loc !~ /^(AB|BC|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/)) || \
      $loc ~ /^[0-9]+$/)
    {
      printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
    }
    else
    {
      location[$call] = "";
    }
    longest = length($name) > length(longest) ? $name : longest;
  }
  else if ($0 !~ /^(!|#|$)/)
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
END {
  printf("Longest name is \"%s\" with %d characters\n", longest, length(longest)) > "/dev/stderr";
  printf("#04 Longest name is \"%s\" with %d characters)\n", longest, length(longest));
  for (c in calls)
  {
    printf("%s=%s;%s;%s\n", calls[c], names[c], num[c], location[c]);
  }
}