BEGIN {
  printf("#00 Weekly RTTY Contest prefill database\n");
  FS = ",";
  longest = "";
}
{
  if ($1 ~ /!!Order!!/)
  {
    call = FindColumn("Call");
    nm = FindColumn("Name");
    exch = FindColumn("Exch1");
  # printf\("%s --> call=%d name=%s exch=%s\n", $0, call, nm, exch) > "/dev/stderr";
  }
  else
  {
    name = toupper($nm);
    namevalid = name ~ /^[A-Za-z]{2,}$/;
    ok = 0;

    if (!namevalid && name != "" && $0 !~ /^(#|!|$)/)
    {
      printf("Problem name ignored: \"%s\"\n", $0) > "/dev/stderr";
      name = "";
    }

    if ($call ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/ && namevalid)
    {
      # printf("$call=%s name=%s ID=%s\n", $call, name, ID) > "/dev/stderr";
      if ($call ~ /^(A[A-L]|[KNW][A-Z]?)|\/(KL|KH|W)[0-9]$/ && $call !~ /V[EOY][0-9]$/)
      {
        if ($call ~ /^(A[A-L]|[KNW][A-Z]?[0-9]([A-Z]+(\/[0-9M])?$|\/))|\/(KL|KH|W)[0-9]$/ && \
            $exch ~ /^(|KP[234]|AL|AK|AZ|AR|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VA|VT|WA|WV|WI|WY)$/ && \
            $exch !~ /VE[0-9]$/ )
        {
          printf("%s=%s;%s\n", $call, name, $exch);
          longest = length(name) > length(longest) ? name : longest;
          ok = 1;
        }
      }
      else if ($call ~ /^V[A-GOXY]|\/V[EOY][0-9]$/)
      {
        if (IsVEcall($call) && $exch ~ /^(AB|BC|MB|NB|NL|NT|NS|NU|ON|PE|QC|SK|YT)$/)
        {
          printf("%s=%s;%s\n", $call, name, "");
          longest = length(name) > length(longest) ? name : longest;
          ok = 1;
        }
        else
        {
          printf("Problem Canadian entry: \"%s\"\n", $0) > "/dev/stderr";
        }
      }
      else
      {
        printf("%s=%s;%s\n", $call, name, "");
        longest = length(name) > length(longest) ? name : longest;
        ok = 1;
      }
    }
    else if ($0 !~ /^(#|!|$)/)
    {
        printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
    }
  }
}
END {
  printf("Longest name is \"%s\" with %d characters\n", longest, length(longest)) > "/dev/stderr";
  printf("#04 Longest name is \"%s\" with %d characters\n", longest, length(longest));
}
