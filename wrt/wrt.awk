BEGIN {
  printf("#0 Weekly RTTY Contest database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  FS=","
  max = 0;
  maxname = "";
  maxlen = 0;
}
{
  if ($1 ~ /!!Order!!/) 
  {
    if ($3 ~ /Name/) nm = 2;
    if ($4 ~ /Name/) nm = 3;
    if ($5 ~ /Name/) nm = 4;
    if ($3 ~ /Exch1/) ex = 2;
    if ($4 ~ /Exch1/) ex = 3;
    if ($5 ~ /Exch1/) ex = 4;
    printf("%s --> name=%s exch=%s\n", $0, nm, ex) > "/dev/stderr";
  } 
  else 
  {
    call = $1;
    name = toupper($nm);
    namevalid = name ~ /^[A-Za-z]{2,}$/;
    ok = 0;

    if (!namevalid && name != "" && $0 !~ /^(#|!|$)/) 
    {
      printf("Problem name ignored: \"%s\"\n", $0) > "/dev/stderr";
      name = "";
    }

    if (call ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/ && namevalid) 
    {
#        printf("call=%s name=%s ID=%s\n", call, name, ID) > "/dev/stderr";
      if (call ~ /^(A[A-L]|[KNW][A-Z]?)|\/W[0-9]$/)
      {
        if (call ~ /^(A[A-L]|[KNW][A-Z]?)[0-9]([A-Z]+|\/)|\/W[0-9]$/ && \
          $ex ~ /^(|KP[234]|AL|AK|AZ|AR|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VA|VT|WA|WV|WI|WY)$/ && \
          $ex !~ /VE[0-9]$/ )
        {
          printf("%s=%s;%s\n", call, name, $ex);
          ok = 1;
        }
        else
        {
          printf("Problem US entry: \"%s\"\n", $0) > "/dev/stderr";
        }
      }
      else if (call ~ /^V[A-EOY]|\/V[EOY][0-9]$/) 
      {
        if (call ~ /^V[A-EOY][0-9]([A-Z]+|\/)|\/V[EOY][0-9]$/)
        {
          printf("%s=%s;%s\n", call, name, "");
          ok = 1;
        }
        else
        {
          printf("Problem Canadian entry: \"%s\"\n", $0) > "/dev/stderr";
        }
      }
      else
      {
          printf("%s=%s;%s\n", call, name, "");
          ok = 1;
      } 
  #    printf("ID=%s, max=%d\n", ID, max) > "/dev/stderr";
      if (ok != 0 && length(name) > maxlen) 
      {
        maxlen = length(name);
        maxname = name;
      }
    }
    else if ($0 !~ /^(#|!|$)/)
    {
        printf("Ignored2: \"%s\"\n", $0) > "/dev/stderr";
    }
  }
}
END {
  printf("Longest name is \"%s\" (%d)\n", maxname, maxlen) > "/dev/stderr";
}
