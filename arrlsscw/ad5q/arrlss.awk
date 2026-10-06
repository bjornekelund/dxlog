BEGIN {
  printf("#00 ARRL CW Sweepstakes database\n");
  printf("#01 Based on data maintained by AD5Q\n");
  printf("#02 Last updated %s\n", strftime("%Y-%m-%d"));
  FS = ",";
}
BEGIN {
  FS = " ";
  callcol = 1;
  preccol = 2;
  checkcol = 4;
  sectcol = 5;
}
{
  if ($0 !~ /^(#|!)/)
  {
    if (call[$callcol] != "")
    {
      printf("Duplicate entry     : \"%s\" and \"%s\"\n", line[$callcol], $0) > "/dev/stderr";
    }

    if ($checkcol !~ /^[0-9]{1,2}$/)
    {
      printf("Problem Check       : \"%s\"\n", $0) > "/dev/stderr";
    }

    if ($callcol ~ /^((A[A-L]|[KNW][A-Z]?)[0-9][A-Z]{1,3})|^(KL7|KH6|W[0-9])\/|\/W[0-9]$|^4U1WB$/ && $callcol !~ /\/V[EOY][0-9]$/)
    {
      if ($sectcol !~ /^(AK|AL|AR|AZ|CO|CT|DE|EB|EMA|ENY|EPA|EWA|GA|IA|ID|IL|IN|KS|KY|LA|LAX|MDC|ME|MI|MN|MO|MS|MT|NC|ND|NE|NFL|NH|NLI|NM|NNJ|NNY|NTX|NV|OH|OK|OR|ORG|PAC|PR|RI|SB|SC|SCV|SD|SDG|SF|SFL|SJV|SNJ|STX|SV|TN|UT|VA|VI|VT|WCF|WI|WMA|WNY|WPA|WTX|WV|WWA|WY)$/)
      {
        printf("Problem ARRL section: \"%s\"\n", $0) > "/dev/stderr";
      }
    }
    else if ($callcol ~ /^(V[A-GOXY]|C[F-KY]|X[J-M])[0-9](([A-Z]{1,3})(\/[1-9PM])?$|\/)|\/V[EOY][0-9]$/)
    {
      if ($sectcol !~ /^(|AB|BC|GH|MB|NB|NL|NS|ONE|ONN|ONS|PE|QC|SK|TER)$/)
      {
        printf("Problem RAC section : \"%s\"\n", $0) > "/dev/stderr";
      }
    } else
    {
      if ($sectcol !~ /^DX$/)
      {
        printf("Problem DX station : \"%s\"\n", $0) > "/dev/stderr";
      }
    }
    line[$callcol] = $0;
    call[$callcol] = $callcol;
    prec[$callcol] = $preccol;
    check[$callcol] =  $checkcol;
    sect[$callcol] = $sectcol;
  }
}
END {
  for (cs in call)
  {
    printf("%s=%s;%s;%s\n", cs, prec[cs], check[cs], sect[cs]);
  }
}
