#bin/bash
DBFILE=CWT_db.txt
gawk '
BEGIN {
  FS=","
  max = 0;
}
{
  if (substr($1, 1, 1) ~ /[0-9,A-Z]/ && $2 != "") {
#    printf("$1=%s $2=%s $3=%s\n", $1, $2, $3) > "/dev/stderr";    
    ID = $3;
    if (ID == "") {
      if (substr($1, 1, 3) ~ /3B9/) ID = "3B9";
      if (substr($1, 1, 3) ~ /3DA/) ID = "3DA";
      if (substr($1, 1, 2) ~ /4O/) ID = "4O";
      if (substr($1, 1, 2) ~ /4[X-Z]/) ID = "4Z";
      if (substr($1, 1, 2) ~ /5T/) ID = "5T";
      if (substr($1, 1, 2) ~ /6Y/) ID = "6Y";
      if (substr($1, 1, 2) ~ /8P/) ID = "8P";
      if (substr($1, 1, 2) ~ /9A/) ID = "9A";
      if (substr($1, 1, 3) ~ /9M6/) ID = "9M6";
      if (substr($1, 1, 2) ~ /7[X-Z]|HZ/) ID = "HZ";
      if (substr($1, 1, 2) ~ /9H/) ID = "9H";
      if (substr($1, 1, 2) ~ /B[A-Z]/) ID = "BY";
      if (substr($1, 1, 2) ~ /CE|X[QR]/) ID = "CE";
      if (substr($1, 1, 2) ~ /C6/) ID = "C6";
      if (substr($1, 1, 2) ~ /CO/) ID = "CO";
      if (substr($1, 1, 2) ~ /C[R-T]/) ID = "CT";
      if (substr($1, 1, 2) ~ /CU/) ID = "CU";
      if (substr($1, 1, 2) ~ /D[A-R]/) ID = "DL";
      if (substr($1, 1, 2) ~ /E7/) ID = "E7";
      if (substr($1, 1, 2) ~ /E[A-F]/) ID = "EA";
      if (substr($1, 1, 2) ~ /E[I-J]/) ID = "EI";
      if (substr($1, 1, 2) ~ /ER/) ID = "ER";
      if (substr($1, 1, 2) ~ /ES/) ID = "ES";
      if (substr($1, 1, 2) ~ /E[U-W]/) ID = "EU";
      if (substr($1, 1, 2) ~ /EX/) ID = "EX";
      if (substr($1, 1, 2) ~ /EY/) ID = "EY";
      if (substr($1, 1, 2) ~ /F[0-9]/) ID = "F";
      if (substr($1, 1, 2) ~ /[GM][0-9,K]|2E/) ID = "G";
      if (substr($1, 1, 2) ~ /[GM]D/) ID = "GD";
      if (substr($1, 1, 2) ~ /[GM]M/) ID = "GM";
      if (substr($1, 1, 2) ~ /[GM]W/) ID = "GW";
      if (substr($1, 1, 2) ~ /[GM]U/) ID = "GU";
      if (substr($1, 1, 2) ~ /[GM]I/) ID = "GI";
      if (substr($1, 1, 2) ~ /[GM]J/) ID = "GJ";
      if (substr($1, 1, 2) ~ /H[AG]/) ID = "HA";
      if (substr($1, 1, 3) ~ /HB[1-9]/) ID = "HB";
      if (substr($1, 1, 2) ~ /HC/) ID = "HC";
      if (substr($1, 1, 2) ~ /HF/) ID = "SP";
      if (substr($1, 1, 2) ~ /HK/) ID = "HK";
      if (substr($1, 1, 2) ~ /I[0-9,K-N,T-Z]/) ID = "I";
      if (substr($1, 1, 3) ~ /IS0/) ID = "IS0";
      if (substr($1, 1, 2) ~ /J[A-S]/) ID = "JA";
      if (substr($1, 1, 2) ~ /JT/) ID = "JT";
      if (substr($1, 1, 3) ~ /KP2/) ID = "KP2";
      if (substr($1, 1, 2) ~ /L[A-N]/) ID = "LA";
      if (substr($1, 1, 2) ~ /L[O-W]/) ID = "LU";
      if (substr($1, 1, 2) ~ /LX/) ID = "LX";
      if (substr($1, 1, 2) ~ /LY/) ID = "LY";
      if (substr($1, 1, 2) ~ /LZ/) ID = "LZ";
      if (substr($1, 1, 2) ~ /OD/) ID = "OD";
      if (substr($1, 1, 2) ~ /OE/) ID = "OE";
      if (substr($1, 1, 2) ~ /O[G-J]/) ID = "OH";
      if (substr($1, 1, 2) ~ /O[KL]/) ID = "OK";
      if (substr($1, 1, 2) ~ /OM/) ID = "OM";
      if (substr($1, 1, 2) ~ /O[N-T]/) ID = "ON";
      if (substr($1, 1, 2) ~ /O[U-Z]/) ID = "OZ";
      if (substr($1, 1, 2) ~ /P4/) ID = "P4";
      if (substr($1, 1, 2) ~ /P[A-I]/) ID = "PA";
      if (substr($1, 1, 2) ~ /P[P-Y]/) ID = "PY";
      if (substr($1, 1, 2) ~ /PZ/) ID = "PZ";
      if (substr($1, 1, 3) ~ /R[1-7][A-Z]|R[A-Z][1-9]|UA[1-9]/) ID = "UA";
      if (substr($1, 1, 3) ~ /R[089][A-Z]|R[A-Z][089]|UA[089]/) ID = "UA9";
      if (substr($1, 1, 2) ~ /S5/) ID = "S5";
      if (substr($1, 1, 2) ~ /S[A-M]|[78]S/) ID = "SM";
      if (substr($1, 1, 2) ~ /S[N-R]|3Z/) ID = "SP";
      if (substr($1, 1, 2) ~ /ST/) ID = "ST";
      if (substr($1, 1, 3) ~ /S[V-Z][01234678]/) ID = "SV";
      if (substr($1, 1, 3) ~ /S[V-Z]5/) ID = "SV5";
      if (substr($1, 1, 3) ~ /S[V-Z]9/) ID = "SV9";
      if (substr($1, 1, 2) ~ /T6|YA/) ID = "YA";
      if (substr($1, 1, 2) ~ /TA/) ID = "TA";
      if (substr($1, 1, 2) ~ /TF/) ID = "TF";
      if (substr($1, 1, 2) ~ /TG/) ID = "TG";
      if (substr($1, 1, 2) ~ /UN/) ID = "UN";
      if (substr($1, 1, 2) ~ /U[R-Z]/) ID = "UR";
      if (substr($1, 1, 2) ~ /V3/) ID = "V3";
      if (substr($1, 1, 2) ~ /VK/) ID = "VK";
      if (substr($1, 1, 4) ~ /VP2M/) ID = "VP2M";
      if (substr($1, 1, 2) ~ /VU/) ID = "VU";
      if (substr($1, 1, 2) ~ /XE/) ID = "XE";
      if (substr($1, 1, 2) ~ /YL/) ID = "YL";
      if (substr($1, 1, 2) ~ /YO/) ID = "YO";
      if (substr($1, 1, 2) ~ /YT/) ID = "YT";
      if (substr($1, 1, 2) ~ /ZB/) ID = "ZB";
      if (substr($1, 1, 2) ~ /Z3/) ID = "Z3";
      if (substr($1, 1, 3) ~ /ZD7/) ID = "ZD7";
      if (substr($1, 1, 3) ~ /ZD8/) ID = "ZD8";
      if (substr($1, 1, 2) ~ /ZF/) ID = "ZF";
      if (substr($1, 1, 2) ~ /ZL/) ID = "ZL";
      if (substr($1, 1, 2) ~ /ZP/) ID = "ZP";
      if (substr($1, 1, 2) ~ /Z[R-S]/) ID = "ZS";
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
  printf("#4 File last updated %s\n", strftime("%Y-%m-%d"));
}' < $1 | sort | sed 's/^\#. /\# /g' > $DBFILE
echo $DBFILE "created"
unix2dos -q $DBFILE
exit
