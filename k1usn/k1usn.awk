BEGIN {
  FS=","
  maxlen = 0;
  maxname = "";
}
{
  bad = 0;
  if ($0 ~ /^(!|#|$)/) { ##
    if ($0 ~ "^!!Order!!") {
      if ($2 ~ /Name/) nm = 1;
      if ($3 ~ /Name/) nm = 2;
      if ($4 ~ /Name/) nm = 3;
      if ($5 ~ /Name/) nm = 4;
      if ($2 ~ /Exch1/) ex = 1;
      if ($3 ~ /Exch1/) ex = 2;
      if ($4 ~ /Exch1/) ex = 3;
      if ($5 ~ /Exch1/) ex = 4;
      cs = 1;
      printf("%s --> call=%d nm=%d ex=%d\n", $0, cs, nm, ex) > "/dev/stderr";
    } 
  }
  else {
    exch = $ex;
    if ($nm !~ /^([A-Z][A-Za-z]+)?$/) {
      printf("Problem name: \"%s\"\n", $0) > "/dev/stderr";
      bad = 1;
    }
    else if (($cs ~ /^(A[A-L]|K[A-Z]?[0-9]|N[A-Z]?[0-9]|W[A-Z]?[0-9])/ && $cs !~ /\/VE[0-9]$/) || $cs ~ /\/W[0-9]$/) {
      if (exch !~ /^(DX|AL|AK|AZ|AR|CA|CO|CT|DE|DC|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|ND|NE|NV|NH|NJ|NM|NY|NC|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY|)$/) {
        printf("Problem exchange1: \"%s\"\n", $0) > "/dev/stderr";
        bad = 1;
      }
    }
    else if (($cs ~ /^(V[A-EOXY]|C[FGJK]|X[LM])[0-9]/ && $cs !~ /\/W[0-9]$/) || $cs ~ /\/V/) {
      if (exch !~ /^(AB|BC|LB|MB|NB|NF|NS|NT|NU|ON|PE|QC|SK|YT|)$/) {
        printf("Problem exchange2: \"%s\"\n", $0) > "/dev/stderr";
        bad = 1;
      } 
    }
    else if (exch !~ /^DX$/) {
        printf("Exchange changed to DX: \"%s\"\n", $0) > "/dev/stderr";
        exch = "DX"
    }
    if (!bad && ($2 != "" || exch != "")) {
      if (call[$1] != "") {
        printf("\"%s\" reoccurs as \"%s\"\n", line[$cs], $0) > "/dev/stderr";
      }
      line[$1] = $0;
      call[$1] = $cs;
      name[$1] = toupper($nm);
      exchange[$1] = exch;
      if (length($2) > maxlen) {
        maxlen = length($2);
        maxname = $2;
      }
    }
  }
}
END {
  printf("#0 K1USN Slow Speed Test participants database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  for (c in call) {
    if (name[c] != "") {
      printf("%s=%s;%s\n", call[c], name[c], exchange[c]);
    }
  }
  printf("Longest name is \"%s\" with %d characters\n", maxname, maxlen) > "/dev/stderr";
}