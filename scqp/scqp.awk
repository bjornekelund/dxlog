BEGIN {
  FS=","
  printf("#0 SCQP database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
}
{
  if ($1 ~ /^(A[A-L]|K[A-Z]?[0-9]|N[A-Z]?[0-9]|W[A-Z]?[0-9]|V[A-EOXY])/ && $3 ~ /^(\/?(DX|AL|AK|AZ|AR|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY|AB|BC|LB|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT|ABBE|AIKE|ALLE|ANDE|BAMB|BARN|BEAU|BERK|CHOU|CHAR|CHES|CHFD|CKEE|CLRN|COLL|DARL|DILL|DORC|EDGE|FAIR|FLOR|GEOR|GRWD|GVIL|HAMP|HORR|JASP|KERS|LAUR|LEE|LEXI|LNCS|MARI|MARL|MCOR|NEWB|OCON|ORNG|PICK|RICH|SALU|SPAR|SUMT|UNIO|WILL|YORK))+$/) {
    if (lines[$1] != "") {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$1], $0) > "/dev/stderr";
    }
    else {
      printf("%s=%s\n", $1, $3);
      lines[$1] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/ && $3 != "") {
    printf("Ignored: %s\n", $0) > "/dev/stderr";
  }
}