#bin/bash
DBFILE=CWT_db.txt
gawk '
BEGIN {
  FS=","
  max = 0;
}
{
  if ($1 ~ /^[0-9A-Z]/ && $2 != "") {
#    printf("$1=%s $2=%s $3=%s\n", $1, $2, $3) > "/dev/stderr";    
    ID = $3;
    if (ID == "") {
      if ($1 ~ /^3B9/) ID = "3B9";
      if ($1 ~ /^3DA/) ID = "3DA";
      if ($1 ~ /^4O/) ID = "4O";
      if ($1 ~ /^4[X-Z]/) ID = "4Z";
      if ($1 ~ /^5T/) ID = "5T";
      if ($1 ~ /^6Y/) ID = "6Y";
      if ($1 ~ /^8P/) ID = "8P";
      if ($1 ~ /^9A/) ID = "9A";
      if ($1 ~ /^9M6/) ID = "9M6";
      if ($1 ~ /^(7[X-Z]|HZ)/) ID = "HZ";
      if ($1 ~ /^9H/) ID = "9H";
      if ($1 ~ /^B[A-Z]/) ID = "BY";
      if ($1 ~ /^(CE|X[QR])/) ID = "CE";
      if ($1 ~ /^C6/) ID = "C6";
      if ($1 ~ /^CO/) ID = "CO";
      if ($1 ~ /^C[R-T]/) ID = "CT";
      if ($1 ~ /^CU/) ID = "CU";
      if ($1 ~ /^D[A-R]/) ID = "DL";
      if ($1 ~ /^E7/) ID = "E7";
      if ($1 ~ /^E[A-F]/) ID = "EA";
      if ($1 ~ /^E[I-J]/) ID = "EI";
      if ($1 ~ /^ER/) ID = "ER";
      if ($1 ~ /^ES/) ID = "ES";
      if ($1 ~ /^E[U-W]/) ID = "EU";
      if ($1 ~ /^EX/) ID = "EX";
      if ($1 ~ /^EY/) ID = "EY";
      if ($1 ~ /^F[0-9]/) ID = "F";
      if ($1 ~ /^([GM][0-9,K]|2E)/) ID = "G";
      if ($1 ~ /^[GM]D/) ID = "GD";
      if ($1 ~ /^[GM]M/) ID = "GM";
      if ($1 ~ /^[GM]W/) ID = "GW";
      if ($1 ~ /^[GM]U/) ID = "GU";
      if ($1 ~ /^[GM]I/) ID = "GI";
      if ($1 ~ /^[GM]J/) ID = "GJ";
      if ($1 ~ /^H[AG]/) ID = "HA";
      if ($1 ~ /^HB[1-9]/) ID = "HB";
      if ($1 ~ /^HC/) ID = "HC";
      if ($1 ~ /^HK/) ID = "HK";
      if ($1 ~ /^I[0-9,K-N,T-Z]/) ID = "I";
      if ($1 ~ /^IS0/) ID = "IS0";
      if ($1 ~ /^J[A-S]/) ID = "JA";
      if ($1 ~ /^JT/) ID = "JT";
      if ($1 ~ /^KP2/) ID = "KP2";
      if ($1 ~ /^L[A-N]/) ID = "LA";
      if ($1 ~ /^L[O-W]/) ID = "LU";
      if ($1 ~ /^LX/) ID = "LX";
      if ($1 ~ /^LY/) ID = "LY";
      if ($1 ~ /^LZ/) ID = "LZ";
      if ($1 ~ /^OD/) ID = "OD";
      if ($1 ~ /^OE/) ID = "OE";
      if ($1 ~ /^O[G-J]/) ID = "OH";
      if ($1 ~ /^O[KL]/) ID = "OK";
      if ($1 ~ /^OM/) ID = "OM";
      if ($1 ~ /^O[N-T]/) ID = "ON";
      if ($1 ~ /^O[U-Z]/) ID = "OZ";
      if ($1 ~ /^P4/) ID = "P4";
      if ($1 ~ /^P[A-I]/) ID = "PA";
      if ($1 ~ /^P[P-Y]/) ID = "PY";
      if ($1 ~ /^PZ/) ID = "PZ";
      if ($1 ~ /^(R[1-7][A-Z]|R[A-Z][1-9]|UA[1-7])/) ID = "UA";
      if ($1 ~ /^(R[089][A-Z]|R[A-Z][089]|UA[089])/) ID = "UA9";
      if ($1 ~ /^S5/) ID = "S5";
      if ($1 ~ /^(S[A-M]|[78]S)/) ID = "SM";
      if ($1 ~ /^(S[N-R]|3Z|HF)/) ID = "SP";
      if ($1 ~ /^ST/) ID = "ST";
      if ($1 ~ /^S[V-Z][01234678]/) ID = "SV";
      if ($1 ~ /^S[V-Z]5/) ID = "SV5";
      if ($1 ~ /^S[V-Z]9/) ID = "SV9";
      if ($1 ~ /^(T6|YA)/) ID = "YA";
      if ($1 ~ /^T[ABC]/) ID = "TA";
      if ($1 ~ /^TF/) ID = "TF";
      if ($1 ~ /^TG/) ID = "TG";
      if ($1 ~ /^UN/) ID = "UN";
      if ($1 ~ /^U[R-Z]/) ID = "UR";
      if ($1 ~ /^V3/) ID = "V3";
      if ($1 ~ /^VK/) ID = "VK";
      if ($1 ~ /^VP2M/) ID = "VP2M";
      if ($1 ~ /^VU/) ID = "VU";
      if ($1 ~ /^XE/) ID = "XE";
      if ($1 ~ /^YL/) ID = "YL";
      if ($1 ~ /^YO/) ID = "YO";
      if ($1 ~ /^YT/) ID = "YT";
      if ($1 ~ /^ZB/) ID = "ZB";
      if ($1 ~ /^Z3/) ID = "Z3";
      if ($1 ~ /^ZD7/) ID = "ZD7";
      if ($1 ~ /^ZD8/) ID = "ZD8";
      if ($1 ~ /^ZF/) ID = "ZF";
      if ($1 ~ /^Z[LK]/) ID = "ZL";
      if ($1 ~ /^ZP/) ID = "ZP";
      if ($1 ~ /^Z[R-S]/) ID = "ZS";
    }
    if (ID == "" && $2 == "")
      printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
    else {
      printf("%s=%s;%s\n", $1, $2, ID);
      max = (int($3) > max) ? int($3) : max;
#      printf("$3=%s, max=%d\n", $3, max) > "/dev/stderr";
    }
  }
}
END {
  printf("#0 CWOps CWT participants database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Send new info/corrections to ve2fk@arrl.net\n");
  printf("#3 Contains members up to #%d\n", max);
  printf("#4 Last updated %s\n", strftime("%Y-%m-%d"));
}' < $1 | sort | sed 's/^\#. /\# /g' > $DBFILE
echo $DBFILE "created"
unix2dos -q $DBFILE
exit
