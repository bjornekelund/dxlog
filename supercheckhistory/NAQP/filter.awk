BEGIN {
  printf("#00 North American QSO Party prefill database\n");
  printf("#01 Based on data from https://supercheckhistory.com\n");
  printf("#02 Last updated %s\n", strftime("%Y-%m-%d"));
  FS = ",";
  longest = "";
  call = 1;
  state = 3;
  name = 2;
}
{
  if ( \
    ($call ~ /^(A[A-L]|[KNW][A-Z]?)[0-9](([A-Z]{1,3})(\/([0-9MP]|QRP))?$|\/)|\/(W[0-9]|KL7|KH6)$|^4U1W/ && $state ~ /^(|AL|AK|AZ|AR|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY)$/) || \
    ($call ~ /^V[A-GOXY][0-9]([A-Z]+|\/)|\/V[EOY][0-9]$/ && $state ~ /^(|AB|BC|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/))
  {
    if (lines[$call] != "")
    {
      if (names[$call] != "" && names[$call] != $name || states[$call] != "" && states[$call] != $state)
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$call], $0) > "/dev/stderr";

      if (names[$call] == "") names[$call] = $name;
      if (states[$call] == "") states[$call] = $state;

    }
    else if (notpredictableve13($call, $state) || $name !~ /^$/)
    {
      printf("%s=%s;%s\n", toupper($call), toupper($name), toupper($state));
      longest = length($name) > length(longest) ? $name : longest;
      states[$call] = $state;
      names[$call] = $name;
      lines[$call] = $0;
    }
  }
  else if ($call ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/ && $state ~ /^(|8P|VI|PR|C6|KP[24]|HI|HP|HH|HR|ZF|V[23]|TI|XE|KG4|CM|FS|V4|J8|VP5|VP2[EMV])$/)
  {
    printf("%s=%s;%s\n", toupper($call), toupper($name), toupper($state));
    longest = length($name) > length(longest) ? $name : longest;
    states[$call] = $state;
    names[$call] = $name;
    lines[$call] = $0;
  }
  else if ($0 !~ /^(!|#|$)/)
  {
    # printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
END {
  printf("Longest name is \"%s\" with %d characters\n", longest, length(longest)) > "/dev/stderr";
  printf("#03 Longest name is \"%s\" with %d characters\n", longest, length(longest));
}