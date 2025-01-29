BEGIN {
  FS=","
  maxlen = 0;
  longest = "";
  printf("#0 Minnesota QSO Party database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
}
{
  stateok = $3 ~ /^(|AL|AK|AZ|AR|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IA|IN|KS|KY|LA|ME|MD|MA|MI|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY|AB|BC|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT|AIT|ANO|BEC|BEL|BEN|BIG|BLU|BRO|CAS|CHP|CHS|CLA|CLE|COO|COT|CRL|CRO|CRV|DAK|DOD|DOU|FAI|FIL|FRE|GOO|GRA|HEN|HOU|HUB|ISA|ITA|JAC|KIT|KNB|KND|KOO|LAC|LAK|LES|LIN|LKW|LYO|MAH|MCL|MEE|MIL|MOR|MOW|MRS|MRT|MUR|NIC|NOB|NOR|OLM|OTT|PEN|PIN|PIP|POL|POP|RAM|RDL|RDW|REN|RIC|ROC|ROS|SCO|SHE|SIB|STE|STL|STR|STV|SWI|TOD|TRA|WAB|WAD|WAT|WIL|WIN|WRI|WSC|WSH|YEL)$/;
  nameok = $2 ~ /^([A-Z][A-Za-z]+|)$/;
  callok = $1 ~ /^(A[A-L]|K[A-Z]?[0-9]|N[A-Z]?[0-9]|W[A-Z]?[0-9]|V[A-EOXY])/;
  notempty = $2 != "" || $3 != "";
  if ((callok && stateok && nameok && notempty) ||(nameok && $3 == "DX")) {
    if (lines[$1] != "") {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$1], $0) > "/dev/stderr";
    }
    else {
      printf("%s=%s;%s\n", $1, $2, $3);
      lines[$1] = $0;
      if (length($2) > maxlen) 
      {
        maxlen = length($2);
        longest = $2;
      }
    }
  }
  else if ($0 !~ /^(!|#|$)/)
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr"
  }
}
END {
  printf("Longest name is %s (%d)\n", longest, maxlen) > "/dev/stderr";
}