BEGIN {
  FS=","
  printf("#0 INQP, DEQP, 7QP, and NEWEQP joint database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
}
{
  state = $3 ~ /^(DX|CT|MA|ME|NH|RI|VT|NJ|NY|DE|PA|MD|DC|AL|FL|GA|KY|NC|SC|TN|VA|AR|LA|MS|NM|OK|TX|CA|HI|AK|AZ|ID|MT|NV|OR|UT|WA|WY|MI|OH|WV|IL|WI|CO|IA|KS|MN|MO|ND|NE|SD|NB|NS|QC|ON|MB|SK|AB|BC|NT|NL|NF|YT|PE|NU)$/;
  cnty1 = $3 ~ /^(IN|CT|MA|ME|NH|RI|VT|NJ|NY|DE|PA|MD|DC|AL|FL|GA|KY|NC|SC|TN|VA|AR|LA|MS|NM|OK|TX|CA|HI|AK|AZ|ID|MT|NV|OR|UT|WA|WY|MI|OH|WV|IL|WI|CO|IA|KS|MN|MO|ND|NE|SD|NB|NS|QC|ON|MB|SK|AB|BC|NT|NL|NF|YT|PE|NU)\S\S\S$/;
  cnty2 = $3 ~ /^\S\S\S(IN|CT|MA|ME|NH|RI|VT|NJ|NY|DE|PA|MD|DC|AL|FL|GA|KY|NC|SC|TN|VA|AR|LA|MS|NM|OK|TX|CA|HI|AK|AZ|ID|MT|NV|OR|UT|WA|WY|MI|OH|WV|IL|WI|CO|IA|KS|MN|MO|ND|NE|SD|NB|NS|QC|ON|MB|SK|AB|BC|NT|NL|NF|YT|PE|NU)$/;
  decnty = $3 ~ /^[KNS]DE$/;
  if ($1 ~ /^[0-9A-Z/]+$/ && (state || cnty1 || cnty2 || decnty)) {
    if (lines[$1] != "") {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$1], $0) > "/dev/stderr";
    }
    else {
      printf("%s=%s\n", $1, $3);
      lines[$1] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/ && $3 != "")
    printf("Ignored: %s\n", $0) > "/dev/stderr";
}