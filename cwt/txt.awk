BEGIN {
  printf("#0 CWOps CWT participants database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Send new info/corrections to ve2fk@arrl.net\n");
  printf("#4 Last updated %s\n", strftime("%Y-%m-%d"));
  FS=","
  max = 0;
  maxname = "";
  maxlen = 0;
}
{
  call = $1;
  name = $2;
  ID = toupper($3);
  if (call ~ /^[A-Z0-9/]{3,}$/ && (name != "" || ID != "")) {
#    printf("call=%s name=%s ID=%s\n", call, name, ID) > "/dev/stderr";    
    if (ID ~ /^ *$/) {
      if (call ~ /^3B9/) ID = "3B9";
      if (call ~ /^3DA/) ID = "3DA";
      if (call ~ /^4O/) ID = "4O";
      if (call ~ /^4[X-Z]/) ID = "4Z";
      if (call ~ /^5T/) ID = "5T";
      if (call ~ /^6Y/) ID = "6Y";
      if (call ~ /^8P/) ID = "8P";
      if (call ~ /^9A/) ID = "9A";
      if (call ~ /^9M6/) ID = "9M6";
      if (call ~ /^(7[X-Z]|HZ)/) ID = "HZ";
      if (call ~ /^9H/) ID = "9H";
      if (call ~ /^B[AY]/) ID = "BY";
      if (call ~ /^(CE|X[QR])/) ID = "CE";
      if (call ~ /^C6/) ID = "C6";
      if (call ~ /^CO/) ID = "CO";
      if (call ~ /^C[R-T]/) ID = "CT";
      if (call ~ /^CU/) ID = "CU";
      if (call ~ /^D[A-R]/) ID = "DL";
      if (call ~ /^E2/) ID = "HS";
      if (call ~ /^E7/) ID = "E7";
      if (call ~ /^E[A-F]/) ID = "EA";
      if (call ~ /^E[I-J]/) ID = "EI";
      if (call ~ /^ER/) ID = "ER";
      if (call ~ /^ES/) ID = "ES";
      if (call ~ /^E[U-W]/) ID = "EU";
      if (call ~ /^EX/) ID = "EX";
      if (call ~ /^EY/) ID = "EY";
      if (call ~ /^F[0-9]/) ID = "F";
      if (call ~ /^([GM][0-9KR]|2E)/) ID = "G";
      if (call ~ /^[GM]D/) ID = "GD";
      if (call ~ /^[GM]M/) ID = "GM";
      if (call ~ /^[GM]W/) ID = "GW";
      if (call ~ /^[GM]U/) ID = "GU";
      if (call ~ /^[GM]I/) ID = "GI";
      if (call ~ /^[GM]J/) ID = "GJ";
      if (call ~ /^H[AG]/) ID = "HA";
      if (call ~ /^HB[1-9]/) ID = "HB";
      if (call ~ /^HC/) ID = "HC";
      if (call ~ /^HK/) ID = "HK";
      if (call ~ /^HR/) ID = "HR";
      if (call ~ /^I[0-9,K-N,T-Z]/) ID = "I";
      if (call ~ /^IS0/) ID = "IS0";
      if (call ~ /^J[A-S]/) ID = "JA";
      if (call ~ /^JT/) ID = "JT";
      if (call ~ /^KP2/) ID = "KP2";
      if (call ~ /^[KNW]P4/) ID = "PR";
      if (call ~ /^L[A-N]/) ID = "LA";
      if (call ~ /^L[O-W]/) ID = "LU";
      if (call ~ /^LX/) ID = "LX";
      if (call ~ /^LY/) ID = "LY";
      if (call ~ /^LZ/) ID = "LZ";
      if (call ~ /^OD/) ID = "OD";
      if (call ~ /^OE/) ID = "OE";
      if (call ~ /^O[G-J]/) ID = "OH";
      if (call ~ /^O[KL]/) ID = "OK";
      if (call ~ /^OM/) ID = "OM";
      if (call ~ /^O[N-T]/) ID = "ON";
      if (call ~ /^O[U-Z]/) ID = "OZ";
      if (call ~ /^P4/) ID = "P4";
      if (call ~ /^P[A-I]/) ID = "PA";
      if (call ~ /^PJ7/) ID = "PJ7";
      if (call ~ /^P[P-Y]/) ID = "PY";
      if (call ~ /^PZ/) ID = "PZ";
      if (call ~ /^(R[1-7][A-Z]|R[A-Z][1-9]|UA[1-7])/) ID = "UA";
      if (call ~ /^(R[089][A-Z]|R[A-Z][089]|UA[089])/) ID = "UA9";
      if (call ~ /^S5/) ID = "S5";
      if (call ~ /^(S[A-M]|[78]S)/) ID = "SM";
      if (call ~ /^(S[N-R]|3Z|HF)/) ID = "SP";
      if (call ~ /^ST/) ID = "ST";
      if (call ~ /^S[V-Z][01234678]/) ID = "SV";
      if (call ~ /^S[V-Z]5/) ID = "SV5";
      if (call ~ /^S[V-Z]9/) ID = "SV9";
      if (call ~ /^(T6|YA)/) ID = "YA";
      if (call ~ /^T[ABC]/) ID = "TA";
      if (call ~ /^TF/) ID = "TF";
      if (call ~ /^TG/) ID = "TG";
      if (call ~ /^TI/) ID = "TI";
      if (call ~ /^TY/) ID = "TY";
      if (call ~ /^UN/) ID = "UN";
      if (call ~ /^U[R-Z]/) ID = "UR";
      if (call ~ /^V3/) ID = "V3";
      if (call ~ /^V[EOY]/) ID = "VE";
      if (call ~ /^VK/) ID = "VK";
      if (call ~ /^VP2M/) ID = "VP2M";
      if (call ~ /^VU/) ID = "VU";
      if (call ~ /^XE/) ID = "XE";
      if (call ~ /^YL/) ID = "YL";
      if (call ~ /^Y[BCD]/) ID = "YB";
      if (call ~ /^YO/) ID = "YO";
      if (call ~ /^Y[UTQ]/) ID = "YT";
      if (call ~ /^ZB/) ID = "ZB";
      if (call ~ /^Z3/) ID = "Z3";
      if (call ~ /^ZD7/) ID = "ZD7";
      if (call ~ /^ZD8/) ID = "ZD8";
      if (call ~ /^ZF/) ID = "ZF";
      if (call ~ /^Z[KLM]/) ID = "ZL";
      if (call ~ /^ZP/) ID = "ZP";
      if (call ~ /^Z[R-S]/) ID = "ZS";
    }
    if (ID != ID && ID != "")
      printf("Exchange is \"%s\" when it should be \"%s\" for %s\n", ID, ID, call) > "/dev/stderr";

    if (call == "N5OT") ID = "2197";
    idvalid = ID ~ /^[1-9][0-9]{0,3}$|^CWA$|^[IGF]$|^3DA$|^9M[26]$|^VP2M$|^[0-9][A-Z]$|^[A-Z]{1,2}[0-9]?$/;
    problemid = !idvalid && !(ID == "" && call ~ /^(N|K|W)/)

    namevalid = name ~ /^[A-Za-z]{2,}$/;

    if (!namevalid && name != "") {
      printf("Problem name ignored: \"%s\"\n", $0) > "/dev/stderr";
      name = "";
    }

    if ((!namevalid && !idvalid) || problemid || (!namevalid && ID !~ /^([0-9]+|[A-Z]{2})$/)) {
#      printf("namevalid=%d idvalid=%d ID=%s\n", namevalid, idvalid, ID) > "/dev/stderr";
      printf("Ignored1: \"%s\"\n", $0) > "/dev/stderr";
    }
    else {
      printf("%s=%s;%s\n", call, name, ID);
      max = (int(ID) > max) ? int(ID) : max;
      if (length(name) > maxlen) {
        maxlen = length(name);
        maxname = name;
      }
#      printf("ID=%s, max=%d\n", ID, max) > "/dev/stderr";
    }
  }
  else if ($0 !~ /^(#|!|$)/ && !(name == "" && ID == "")){
      printf("Ignored2: \"%s\"\n", $0) > "/dev/stderr";
  }
}
END {
  printf("#3 Contains members up to #%d\n", max);
  printf("Longest name is \"%s\" (%d)\n", maxname, maxlen) > "/dev/stderr";
}
