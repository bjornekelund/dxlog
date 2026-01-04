BEGIN {
  printf("#01 K1USN Slow Speed Test participants database\n");
  printf("#02 Data collected and maintained by Claude VE2FK\n");
  printf("#03 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#04 Last updated %s\n", strftime("%Y-%m-%d"));
  FS=","
  longest = "";
}
{
  bad = 0;
  if ($0 ~ /^(!|#|$)/) 
  {
    if ($1 ~ /!!Order!!/) 
    {
      if ($2 ~ /Call/) call = 1;
      if ($3 ~ /Call/) call = 2;
      if ($4 ~ /Call/) call = 3;
      if ($5 ~ /Call/) call = 4;
      if ($2 ~ /Name/) nm = 1;
      if ($3 ~ /Name/) nm = 2;
      if ($4 ~ /Name/) nm = 3;
      if ($5 ~ /Name/) nm = 4;
      if ($2 ~ /Exch1/) ex = 1;
      if ($3 ~ /Exch1/) ex = 2;
      if ($4 ~ /Exch1/) ex = 3;
      if ($5 ~ /Exch1/) ex = 4;
      printf("%s --> call=%d nm=%d ex=%d\n", $0, call, nm, ex) > "/dev/stderr";
    } 
  }
  else 
  {
    exch = $ex;
    if ($nm !~ /^([A-Z][A-Za-z]+)?$/) 
    {
      printf("Problem name: \"%s\"\n", $0) > "/dev/stderr";
      bad = 1;
    }
    else if (($call ~ /^(A[A-L]|[KNW][A-Z]?)[0-9]([A-Z]+|\/)|\/W[0-9]$/ && $call !~ /\/V[EOY][0-9]$/)) 
    {
      if (exch !~ /^(DX|AL|AK|AZ|AR|CA|CO|CT|DE|DC|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|ND|NE|NV|NH|NJ|NM|NY|NC|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY|)$/) 
      {
        printf("Problem exchange1: \"%s\"\n", $0) > "/dev/stderr";
        bad = 1;
      }
    }
    else if (($call ~ /^(V[A-EOXY]|C[FGJK]|X[LM])[0-9]([A-Z]+|\/)|V[EOY][0-9]$/ && $call !~ /\/W[0-9]$/)) 
    {
      if (exch !~ /^(AB|BC|LB|MB|NB|NF|NS|NT|NU|ON|PE|QC|SK|YT|)$/) 
      {
        printf("Problem exchange2: \"%s\"\n", $0) > "/dev/stderr";
        bad = 1;
      } 
    }
    else if (exch !~ /^DX$/) 
    {
        printf("Exchange changed to DX: \"%s\"\n", $0) > "/dev/stderr";
        exch = "DX"
    }
    if (!bad && ($2 != "" || exch != "")) 
    {
      if (calls[$1] != "") 
      {
        printf("\"%s\" reoccurs as \"%s\"\n", line[$call], $0) > "/dev/stderr";
      }
      else 
      {
        line[$1] = $0;
        calls[$1] = $call;
        name[$1] = toupper($nm);
        exchange[$1] = exch;
        longest = length($nm) > length(longest) ? $nm : longest;
      }
    }
  }
}
END {
  printf("Longest name is \"%s\" with %d characters\n", longest, length(longest)) > "/dev/stderr";
  for (c in calls) 
  {
    if (name[c] != "") 
    {
      printf("%s=%s;%s\n", calls[c], name[c], exchange[c]);
    }
  }
}