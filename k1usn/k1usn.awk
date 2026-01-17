BEGIN {
  printf("#00 K1USN Slow Speed Test prefill database\n");
  printf("#01 Based on data maintained by Claude VE2FK\n");
  printf("#02 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#04 Last updated %s\n", strftime("%Y-%m-%d"));
  FS = ",";
  longest = "";
}
{
  bad = 0;
  if ($0 ~ /^(!|#|$)/)
  {
    if ($1 ~ /!!Order!!/)
    {
      if ($2 ~ /Call/) call = 1; else
      if ($3 ~ /Call/) call = 2; else
      if ($4 ~ /Call/) call = 3; else
      if ($5 ~ /Call/) call = 4; else printf("Problem !!Order!! line: \"%s\"\n", $0) > "/dev/stderr";
      if ($2 ~ /Name/) nm = 1; else
      if ($3 ~ /Name/) nm = 2; else
      if ($4 ~ /Name/) nm = 3; else
      if ($5 ~ /Name/) nm = 4; else printf("Problem !!Order!! line: \"%s\"\n", $0) > "/dev/stderr";
      if ($2 ~ /Exch1/) ex = 1; else
      if ($3 ~ /Exch1/) ex = 2; else
      if ($4 ~ /Exch1/) ex = 3; else
      if ($5 ~ /Exch1/) ex = 4; else printf("Problem !!Order!! line: \"%s\"\n", $0) > "/dev/stderr";
      printf("%s --> call=%d nm=%d ex=%d\n", $0, call, nm, ex) > "/dev/stderr";
    }
  }
  else if ($call ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/)
  {
    if (calls[$1] != "")
    {
      printf("\"%s\" reoccurs as \"%s\"\n", line[$call], $0) > "/dev/stderr";
      bad = 1;
    }
    else if ($nm !~ /^([A-Z][A-Za-z]+)?$/)
    {
      printf("Problem name: \"%s\"\n", $0) > "/dev/stderr";
      bad = 1;
    }
    else if ( \
      $call ~ /^(A[A-L]|[KNW][A-z]?)[0-9](([A-Z]{1,3})(\/([0-9MP]|QRP))?$|\/)|\/(W[0-9]|KL7|KH6)$/ && \
      $call !~ /\/V[EOY][0-9]$/ && \
      $call !~ /^KG4[A-Z]{2}$|^[KNW]P[234][A-Z]{1,3}$/)
    {
      if ($ex !~ /^(AL|AK|AZ|AR|CA|CO|CT|DE|DC|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|ND|NE|NV|NH|NJ|NM|NY|NC|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY|)$/)
      {
        printf("Problem US exchange: \"%s\"\n", $0) > "/dev/stderr";
        bad = 1;
      }
    }
    else if ( \
      $call ~ /^KG4[A-Z]{2}$|^[KNW]P[234][A-Z]{1,3}$/ && $call !~ /\/V[EOY][0-9]$/)
    {
      if ($ex !~ /^(DX|AL|AK|AZ|AR|CA|CO|CT|DE|DC|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|ND|NE|NV|NH|NJ|NM|NY|NC|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY|)$/)
      {
        printf("Problem KP[234] exchange: \"%s\"\n", $0) > "/dev/stderr";
        bad = 1;
      }
    }
    else if (($call ~ /^(V[A-EOXY]|C[FGJK]|X[LM])[0-9]([A-Z]+|\/)|V[EOY][0-9]$/))
    {
      if ($ex !~ /^(AB|BC|LB|MB|NB|NF|NS|NT|NU|ON|PE|QC|SK|YT|)$/)
      {
        printf("Problem Canadian exchange: \"%s\"\n", $0) > "/dev/stderr";
        bad = 1;
      }
    }
    else if ($ex !~ /^DX$/)
    {
        printf("Exchange should be: \"%s\"\n", $0) > "/dev/stderr";
        bad = 1;
    }
    if (!bad && ($nm != "" || $ex != ""))
    {
      line[$1] = $0;
      calls[$1] = $call;
      name[$1] = toupper($nm);
      exchange[$1] = $ex;
      longest = length($nm) > length(longest) ? $nm : longest;
    }
    else
    {
      printf("Problem line: \"%s\"\n", $0) > "/dev/stderr";
    }
  }
  else if ($0 != /^(!|#|$)/)
  {
    printf("Problem call: \"%s\"\n", $0) > "/dev/stderr";
  }
}
END {
  printf("Longest name is \"%s\" with %d characters\n", longest, length(longest)) > "/dev/stderr";
  printf("#03 Longest name is \"%s\" with %d characters\n", longest, length(longest));
  for (c in calls)
  {
    if (name[c] != "")
    {
      printf("%s=%s;%s\n", calls[c], name[c], exchange[c]);
    }
  }
}