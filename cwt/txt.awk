BEGIN {
  printf("#00 CWOps CWT prefill database\n");
  printf("#01 Based on data maintained by Claude VE2FK\n");
  printf("#02 Send new info/corrections to ve2fk@arrl.net\n");
  printf("#05 Last updated %s\n", strftime("%Y-%m-%d"));
  FS = ",";
  max = 0;
  longest = "";
}
{
  call = toupper($1);
  name = $2;
  OID = toupper($3);
  ID = "";
  if (call ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]{1,2}[A-Z]{1,4}(\/[A-Z0-9]+)?$/ && (name != "" || OID != ""))
  {
#    printf("call=%s name=%s ID=%s\n", call, name, ID) > "/dev/stderr"; 
    if (1)
    {
      if (ID == "" && call ~ /^3B9/) ID = "3B9";
      if (ID == "" && call ~ /^3DA/) ID = "3DA";
      if (ID == "" && call ~ /^4O/) ID = "4O";
      if (ID == "" && call ~ /^4[X-Z]/) ID = "4Z";
      if (ID == "" && call ~ /^5T/) ID = "5T";
      if (ID == "" && call ~ /^6Y/) ID = "6Y";
      if (ID == "" && call ~ /^8P/) ID = "8P";
      if (ID == "" && call ~ /^9A/) ID = "9A";
      if (ID == "" && call ~ /^9M6/) ID = "9M6";
      if (ID == "" && call ~ /^(7[X-Z]|HZ)/) ID = "HZ";
      if (ID == "" && call ~ /^9H/) ID = "9H";
      if (ID == "" && call ~ /^B[ADY]/) ID = "BY";
      if (ID == "" && call ~ /^(CE|X[QR])/) ID = "CE";
      if (ID == "" && call ~ /^C6/) ID = "C6";
      if (ID == "" && call ~ /^CO/) ID = "CM";
      if (ID == "" && call ~ /^C[R-T]/) ID = "CT";
      if (ID == "" && call ~ /^CU/) ID = "CU";
      if (ID == "" && call ~ /^D[A-R]/) ID = "DL";
      if (ID == "" && call ~ /^E2/) ID = "HS";
      if (ID == "" && call ~ /^E7/) ID = "E7";
      if (ID == "" && call ~ /^E[A-F]6/) ID = "EA6";
      if (ID == "" && call ~ /^E[A-F]8/) ID = "EA8";
      if (ID == "" && call ~ /^E[A-F]9/) ID = "EA9";
      if (ID == "" && call ~ /^E[A-F][0123457]/) ID = "EA";
      if (ID == "" && call ~ /^E[I-J]/) ID = "EI";
      if (ID == "" && call ~ /^ER/) ID = "ER";
      if (ID == "" && call ~ /^ES/) ID = "ES";
      if (ID == "" && call ~ /^E[U-W]/) ID = "EU";
      if (ID == "" && call ~ /^EX/) ID = "EX";
      if (ID == "" && call ~ /^EY/) ID = "EY";
      if (ID == "" && call ~ /^F[0-9]/ || call ~ /^F\//) ID = "F";
      if (ID == "" && call ~ /^([GM][0-9KR]|2E)/) ID = "G";
      if (ID == "" && call ~ /^[GM]D/) ID = "GD";
      if (ID == "" && call ~ /^[GM]M/) ID = "GM";
      if (ID == "" && call ~ /^[GM]W/) ID = "GW";
      if (ID == "" && call ~ /^[GM]U/) ID = "GU";
      if (ID == "" && call ~ /^[GM]I/) ID = "GI";
      if (ID == "" && call ~ /^[GM]J/) ID = "GJ";
      if (ID == "" && call ~ /^H[AG]/) ID = "HA";
      if (ID == "" && call ~ /^HB[1-9]/) ID = "HB";
      if (ID == "" && call ~ /^HC/) ID = "HC";
      if (ID == "" && call ~ /^HK/) ID = "HK";
      if (ID == "" && call ~ /^(HL|DS)/) ID = "HL";
      if (ID == "" && call ~ /^HR/) ID = "HR";
      if (ID == "" && call ~ /^I[0-9,K-N,T-Z\/]/) ID = "I";
      if (ID == "" && call ~ /^IS0/) ID = "IS0";
      if (ID == "" && call ~ /^(J[A-S]|7L)/) ID = "JA";
      if (ID == "" && call ~ /^JT/) ID = "JT";
      if (ID == "" && call ~ /^[KNW]P2/) ID = "VI";
      if (ID == "" && call ~ /^[KNW]P4/) ID = "PR";
      if (ID == "" && call ~ /^L[A-N]/) ID = "LA";
      if (ID == "" && call ~ /^L[O-W]/) ID = "LU";
      if (ID == "" && call ~ /^LX/) ID = "LX";
      if (ID == "" && call ~ /^LY/) ID = "LY";
      if (ID == "" && call ~ /^LZ/) ID = "LZ";
      if (ID == "" && call ~ /^OD/) ID = "OD";
      if (ID == "" && call ~ /^OE/) ID = "OE";
      if (ID == "" && call ~ /^O[G-J]/) ID = "OH";
      if (ID == "" && call ~ /^O[KL]/) ID = "OK";
      if (ID == "" && call ~ /^OM/) ID = "OM";
      if (ID == "" && call ~ /^O[N-T]/) ID = "ON";
      if (ID == "" && call ~ /^O[U-Z]/) ID = "OZ";
      if (ID == "" && call ~ /^P4/) ID = "P4";
      if (ID == "" && call ~ /^P[A-I]/) ID = "PA";
      if (ID == "" && call ~ /^PJ7/) ID = "PJ7";
      if (ID == "" && call ~ /^P[P-Y]/) ID = "PY";
      if (ID == "" && call ~ /^PZ/) ID = "PZ";
      if (ID == "" && call ~ /^(R[089][A-Z]|R[A-Z][089]|UA[089])/) ID = "UA9";
      if (ID == "" && call ~ /^(R[1-7][A-Z]|R[A-Z][1-9]|UA[1-7])/) ID = "UA";
      if (ID == "" && call ~ /^S5/) ID = "S5";
      if (ID == "" && call ~ /^(S[A-M]|[78]S)/) ID = "SM";
      if (ID == "" && call ~ /^(S[N-R]|3Z|HF)/) ID = "SP";
      if (ID == "" && call ~ /^ST/) ID = "ST";
      if (ID == "" && call ~ /^S[V-Z][01234678]/) ID = "SV";
      if (ID == "" && call ~ /^S[V-Z]5/) ID = "SV5";
      if (ID == "" && call ~ /^S[V-Z]9/) ID = "SV9";
      if (ID == "" && call ~ /^(T6|YA)/) ID = "YA";
      if (ID == "" && call ~ /^T[ABC]/) ID = "TA";
      if (ID == "" && call ~ /^TF/) ID = "TF";
      if (ID == "" && call ~ /^TG/) ID = "TG";
      if (ID == "" && call ~ /^TI/) ID = "TI";
      if (ID == "" && call ~ /^TY/) ID = "TY";
      if (ID == "" && call ~ /^UN/) ID = "UN";
      if (ID == "" && call ~ /^U[R-Z]/) ID = "UR";
      if (ID == "" && call ~ /^V3/) ID = "V3";
      if (ID == "" && call ~ /^V3/) ID = "V3";

      if (ID == "" && call ~ /^((V[A-GX]|C[FG])1|CY[09])[A-Z]{1,3}$|(V[A-GX]|C[FG]).+\/1$|\/VE1$/) ID = "NS";
      if (ID == "" && call ~ /^(V[A-GX]|X[LM]|C[FG])2[A-Z]{1,3}$|(V[A-GX]|C[FG]).+\/2$|\/VE2$/) ID = "QC";
      if (ID == "" && call ~ /^(V[A-GX]|X[LM]|C[FG])3[A-Z]{1,3}$|(V[A-GX]|C[FG]).+\/3$|\/VE3$/) ID = "ON";
      if (ID == "" && call ~ /^(V[A-GX]|C[FG])4[A-Z]{1,3}$|(V[A-GX]|C[FG]).+\/4$|\/VE4$/) ID = "MB";
      if (ID == "" && call ~ /^(V[A-GX]|C[FG])5[A-Z]{1,3}$|(V[A-GX]|C[FG]).+\/5$|\/VE5$/) ID = "SK";
      if (ID == "" && call ~ /^(V[A-GX]|C[FG])6[A-Z]{1,3}$|(V[A-GX]|C[FG]).+\/6$|\/VE6$/) ID = "AB";
      if (ID == "" && call ~ /^(V[A-GX]|C[FG])7[A-Z]{1,3}$|(V[A-GX]|C[FG]).+\/7$|\/VE7$/) ID = "BC";
      if (ID == "" && call ~ /^(VE|C[FG])8[A-Z]{1,3}$|(V[A-GX]|C[FG]).+\/8$\/VE8$/) ID = "NT";
      if (ID == "" && call ~ /^(V[CE]|C[FG])9[A-Z]{1,3}$|(V[A-GX]|C[FG]).+\/9$|\/VE9$/) ID = "NB";
      if (ID == "" && call ~ /^VO[12][A-Z]{1,3}$|\/VO[12]$/) ID = "NL";
      if (ID == "" && call ~ /^VY0[A-Z]{1,3}$|\/VY0$/) ID = "NU";
      if (ID == "" && call ~ /^(VY|XO)1[A-Z]{1,3}$|\/VY1$/) ID = "YT";
      if (ID == "" && call ~ /^VY2[A-Z]{1,3}$|\/VY2$/) ID = "PE";

      if (ID == "" && call ~ /^VK[1-8]/) ID = "VK";
      if (ID == "" && call ~ /^VP2M/) ID = "VP2M";
      if (ID == "" && call ~ /^VP9|\/VP9$/) ID = "VP2M";
      if (ID == "" && call ~ /^VU/) ID = "VU";
      if (ID == "" && call ~ /^XE/) ID = "XE";
      if (ID == "" && call ~ /^YL/) ID = "YL";
      if (ID == "" && call ~ /^Y[BCDE]/) ID = "YB";
      if (ID == "" && call ~ /^YO/) ID = "YO";
      if (ID == "" && call ~ /^Y[UTQ]/) ID = "YU";
      if (ID == "" && call ~ /^ZA/) ID = "ZA";
      if (ID == "" && call ~ /^ZB/) ID = "ZB";
      if (ID == "" && call ~ /^Z3/) ID = "Z3";
      if (ID == "" && call ~ /^ZD7/) ID = "ZD7";
      if (ID == "" && call ~ /^ZD8/) ID = "ZD8";
      if (ID == "" && call ~ /^ZF/) ID = "ZF";
      if (ID == "" && call ~ /^Z[KLM]/) ID = "ZL";
      if (ID == "" && call ~ /^ZP/) ID = "ZP";
      if (ID == "" && call ~ /^Z[R-S]/) ID = "ZS";
    }
    if (ID != "" && OID != "" && ID != OID && OID !~ /^([1-9][0-9]{0,3}|CWA)$/)
    {
      if ( \
        !(call == "VE1ASE" && OID == "NB") && \
        !(call == "VE1EJ" && OID == "ON") && \
        !(call == "ZF2DO" && OID == "TX") && \
        !(call == "ZF2LZ" && OID == "MA") \
        )
      {
        printf("Exchange is \"%s\" for %s but should probably be \"%s\"\n", OID, call, ID) > "/dev/stderr";
      }
    }
 
    # if (OID == ID || OID == "")
    # {
    #   ID = ""; # Rule based prefill will handle predictable exchanges
    # }
    # else 
    if (OID != "")
    {
      ID = OID; # The source file had an exchange, use it
    }
    else if (ID == "" && call != "N4DL")
    {
      printf("Empty member/location for %s\n", call) > "/dev/stderr";
    }
 
    idvalid = ID ~ /^(|[1-9][0-9]{0,3}|CWA|[IGF]|3DA|9M[26]|VP2M|[0-9][A-Z]|[A-Z]{1,2}[0-9]?)$/;
    problemid = !idvalid && !(ID == "" && call ~ /^(N|K|W|V[A-G])/)

    namevalid = name ~ /^[A-Za-z]{1,}$/;

    if (!namevalid && name != "")
    {
      printf("Problem name ignored: \"%s\"\n", $0) > "/dev/stderr";
      name = "";
    }

    if ((!namevalid && !idvalid) || problemid || (!namevalid && ID !~ /^([0-9]+|[A-Z]{2})$/))
    {
      printf("namevalid=%d idvalid=%d ID=%s\n", namevalid, idvalid, ID) > "/dev/stderr";
      printf("Ignored1: \"%s\"\n", $0) > "/dev/stderr";
    }
    else
    {
      printf("%s=%s;%s\n", call, name, ID);
      max = (int(ID) > max) ? int(ID) : max;
      longest = length(name) > length(longest) ? name : longest;
#      printf("ID=%s, max=%d\n", ID, max) > "/dev/stderr";
    }
  }
  else if ($0 !~ /^(#|!|$)/ && !(name == "" && ID == ""))
  {
    printf("Ignored2: \"%s\"\n", $0) > "/dev/stderr";
  }
}
END {
  printf("#04 Contains members up to #%d\n", max);
  printf("Highest member number is %d\n", max) > "/dev/stderr";
  printf("Longest name is \"%s\" with %d characters\n", longest, length(longest)) > "/dev/stderr";
  printf("#03 Longest name is \"%s\" with %d characters\n", longest, length(longest));
}
