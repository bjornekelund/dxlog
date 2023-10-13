BEGIN {
  FS=","
  printf("#0 Nevada QSO Party database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  col = 3;
}
{
  if ($1 ~ /!!Order!!/) {
    if ($3 ~ /Exch1|State/) col = 2;
    if ($4 ~ /Exch1|State/) col = 3;
    if ($5 ~ /Exch1|State/) col = 4;
    printf("%s --> Column is %d\n", $0, col) > "/dev/stderr";
  } 
  else if ($1 ~ /^(A[A-L]|K[A-Z]?[0-9]|N[A-Z]?[0-9]|W[A-Z]?[0-9]|V[A-EOXY]|C[FG])/ && $col ~ /^(DX|AB|AK|AL|AR|AZ|BC|CO|CT|DE|EB|EMA|ENY|EPA|EWA|GA|GH|IA|ID|IL|IN|KS|KY|LA|LAX|MB|MDC|ME|MI|MN|MO|MS|MT|NB|NC|ND|NE|NFL|NH|NL|NLI|NM|NNJ|NNY|NS|NTX|OH|OK|ONE|ONN|ONS|OR|ORG|PAC|PE|PR|QC|RI|SB|SC|SCV|SD|SDG|SF|SFL|SJV|SK|SNJ|STX|SV|TER|TN|UT|VA|VI|VT|WCF|WI|WMA|WNY|WPA|WTX|WV|WWA|WY|NVCAR|NVCHU|NVCLA|NVDOU|NVELK|NVESM|NVEUR|NVHUM|NVLAN|NVLIN|NVLYO|NVMIN|NVNYE|NVPER|NVSTO|NVWAS|NVWHI)$/) {
    if (lines[$1] != "") {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$1], $0) > "/dev/stderr";
    }
    else {
      printf("%s=%s\n", $1, $col);
      lines[$1] = $0;
    }
  }
	else if ($0 !~ /^(!|#|$)/ && $col != "") {
    printf("Ignored: %s\n", $0) > "/dev/stderr";
  }
}