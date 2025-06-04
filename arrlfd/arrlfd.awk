BEGIN {
  printf("#0 ARRL Field Day database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  FS=",";
}
{
  if ($0 ~ /^(!|#|$)/) { ##
    if ($1 ~ /!!Order!!/) {
      if ($3 ~ /Exch1/) exch = 2;
      if ($4 ~ /Exch1/) exch = 3;
      if ($5 ~ /Exch1/) exch = 4;
      if ($3 ~ /Sect/) sect = 2;
      if ($4 ~ /Sect/) sect = 3;
      if ($5 ~ /Sect/) sect = 4;
      call = 1;
      printf("%s --> call=%d exch=%d sect=%d\n", $0, call, exch, sect) > "/dev/stderr";
    }
  } 
  else {
    if (line[$call] != "") {
      printf("\"%s\" reoccurs as \"%s\"\n", line[$call], $0) > "/dev/stderr";
    }
    else if ($exch !~ /^|[1-9][0-9]?[A-F]$/) { 
      printf("Problem category: \"%s\"\n", $0) > "/dev/stderr";
      line[$call] = $0;
    }
    else if ($call ~ /^(A[A-L]|[KNW][A-Z]?[0-9]|4U1WB)|\/W[0-9]$/ && $call !~ /\/V[AEOY]/) {
      if ($sect ~ /^(AK|AL|AR|AZ|CO|CT|DE|EB|EMA|ENY|EPA|EWA|GA|IA|ID|IL|IN|KS|KY|LA|LAX|MDC|ME|MI|MN|MO|MS|MT|NC|ND|NE|NFL|NH|NLI|NM|NNJ|NNY|NTX|NV|OH|OK|OR|ORG|PAC|PR|RI|SB|SC|SCV|SD|SDG|SF|SFL|SJV|SNJ|STX|SV|TN|UT|VA|VI|VT|WCF|WI|WMA|WNY|WPA|WTX|WV|WWA|WY)$/) {
        printf("%s=%s;%s\n", $call, $exch, $sect);
      }
      else {
        printf("Problem ARRL section: \"%s\"\n", $0) > "/dev/stderr";
      }
      line[$call] = $0;
    }
    else if ($call ~ /^(V[A-GOXY]|C[F-K]|CY|X[JM])|\/(V[A-EOY][0-9])$/ && $call !~ /\/W/) {
      if ($3 ~ /^(AB|BC|GH|MB|NB|NL|NS|ONE|ONN|ONS|PE|QC|SK|TER)$/) {
        printf("%s=%s;%s\n", $call, $exch, $sect);
      }
      else {
        printf("Problem RAC section: \"%s\"\n", $0) > "/dev/stderr";
      }
      line[$call] = $0;
    }
    else if ($0 !~ /^(!|#|$)/) { ##
      if ($3 ~ /^DX$/) {
        printf("%s=%s;%s\n", $call, $exch, $sect);
      }
      else {
        printf("Problem DX station  : \"%s\"\n", $0) > "/dev/stderr";
      }
      line[$call] = $0;
    }
  }
}

# {
# #   printf("$1=%s $2=%s $3=%s\n", $1, $2, $3) > "/dev/stderr";
#    if ($1 ~ /^[0-9A-Z]/ && $2 ~ /^(|[1-9][0-9]?[A-Z])$/ && $3 ~ /^(|DX|AK|AL|AR|AZ|CO|CT|DE|EB|EMA|ENY|EPA|EWA|GA|IA|ID|IL|IN|KS|KY|LA|LAX|MDC|ME|MI|MN|MO|MS|MT|NC|ND|NE|NFL|NH|NLI|NM|NNJ|NNY|NTX|NV|OH|OK|OR|ORG|PAC|PR|RI|SB|SC|SCV|SD|SDG|SF|SFL|SJV|SNJ|STX|SV|TN|UT|VA|VI|VT|WCF|WI|WMA|WNY|WPA|WTX|WV|WWA|WY|AB|BC|GH|MB|NB|NL|NS|ONE|ONN|ONS|PE|QC|SK|TER)$/) {
#      printf("%s=%s;%s\n", toupper($1), toupper($2), toupper($3));
#    }
#    else if ($0 !~ /^(!|#|$)/) {
#      printf("Ignored: %s\n", $0) > "/dev/stderr";
#    }
# }
