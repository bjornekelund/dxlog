BEGIN {
  FS=","
  printf("#0 Montana QSO Party database\n");
  printf("#1 Based on NAQP database maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
}
{
  if ($1 ~ /^(A[A-L]|K[A-Z]?[0-9]|N[A-Z]?[0-9]|W[A-Z]?[0-9]|V[A-EOXY]|4U)/ && $3 ~ /^(AL|AK|AR|AZ|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MO|MS|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VA|VT|WA|WV|WI|WY|AB|BC|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT|BEA|BIG|BLA|BRO|CAS|CHO|CRB|CRT|CUS|DAN|DAW|DEE|FAL|FER|FLA|GAL|GAR|GLA|GOL|GRA|HIL|JEF|JUD|LAK|LEW|LIB|LIN|MAD|MCC|MEA|MIN|MIS|MUS|PAR|PET|PHI|PON|PRA|PWD|PWL|RAV|RIC|ROO|ROS|SAN|SHE|SIL|STI|SWE|TET|TOO|TRE|VAL|WHE|WIB|YEL)$/) {
    if (lines[$1] != "") {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$1], $0) > "/dev/stderr";
    }
    else {
      printf("%s=%s\n", $1, $3);
      lines[$1] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/ && $3 !~/^(MT|)$/) {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
