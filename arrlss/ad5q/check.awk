BEGIN {
  FS = " ";
  calcol = 1;
  precol = 2;
  chkcol = 4;
  seccol = 5;
}
{
  if ($0 !~ /^(#|!)/) 
  {
    if (call[$calcol] != "") 
    {
      printf("Duplicate entry     : \"%s\" and \"%s\"\n", line[$calcol], $0) > "/dev/stderr";
    }

    if ($chkcol !~ /^[0-9]{1,2}$/) 
    {
      printf("Problem Check       : \"%s\"\n", $0) > "/dev/stderr";
    }

    if ($calcol ~ /^(A[A-L]|[KNW][A-Z]?[0-9]|4U1WB)|\/W[0-9]$/ && $1 !~ /V[A-Z][0-9]$/) 
    {
      if ($seccol !~ /^(AK|AL|AR|AZ|CO|CT|DE|EB|EMA|ENY|EPA|EWA|GA|IA|ID|IL|IN|KS|KY|LA|LAX|MDC|ME|MI|MN|MO|MS|MT|NC|ND|NE|NFL|NH|NLI|NM|NNJ|NNY|NTX|NV|OH|OK|OR|ORG|PAC|PR|RI|SB|SC|SCV|SD|SDG|SF|SFL|SJV|SNJ|STX|SV|TN|UT|VA|VI|VT|WCF|WI|WMA|WNY|WPA|WTX|WV|WWA|WY)$/) 
      {
        printf("Problem ARRL section: \"%s\"\n", $0);
      }
    } 
    else if ($calcol ~ /^(V[A-EOXY]|C[F-K]|CY)|\/(V[A-EOXY][0-9])$/) 
    {
      if ($seccol !~ /^(|AB|BC|GH|MB|NB|NL|NS|ONE|ONN|ONS|PE|QC|SK|TER)$/) 
      {
        printf("Problem RAC section : \"%s\"\n", $0) > "/dev/stderr";
      }
    } else 
    {
      if ($seccol !~ /^DX$/) 
      {
        printf("Problem DX station : \"%s\"\n", $0) > "/dev/stderr";
      }
    }
    line[$calcol] = $0;
    call[$calcol] = $calcol;
  }
}
