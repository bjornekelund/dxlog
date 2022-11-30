#!/bin/bash
FILE=`ls StewPerry[!_]* | tail -1 2> /dev/null`
OUTFILE=HAMSPIRIT_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk '
BEGIN {
  FS=","
  max = 0;
}
{
  ZONE = "";
  FGRID = $3;
  GRID = substr($3, 1, 2);

  if ($1 ~ /^[0-9,A-Z]/ && GRID ~ /[A-R]{2}/) {
    if ($1 ~ /^3B9/) ZONE = "53";
    if ($1 ~ /^3DA/) ZONE = "57";
    if ($1 ~ /^4O/) ZONE = "28";
    if ($1 ~ /^4[X-Z]/) ZONE = "39";
    if ($1 ~ /^5T/) ZONE = "46";
    if ($1 ~ /^6Y/) ZONE = "11";
    if ($1 ~ /^8P/) ZONE = "11";
    if ($1 ~ /^9A/) ZONE = "28";
    if ($1 ~ /^9M6/) ZONE = "54";
    if ($1 ~ /^(7[X-Z]|HZ)/) ZONE = "37";
    if ($1 ~ /^9H/) ZONE = "28";
    if ($1 ~ /^B[A-Z]/) ZONE = "44";
    if ($1 ~ /^(CE|X[QR])/) ZONE = "14";
    if ($1 ~ /^C6/) ZONE = "11";
    if ($1 ~ /^CO/) ZONE = "11";
    if ($1 ~ /^C[R-T]/) ZONE = "37";
    if ($1 ~ /^CU/) ZONE = "36";
    if ($1 ~ /^D[A-R]/) ZONE = "28";
    if ($1 ~ /^E7/) ZONE = "37";
    if ($1 ~ /^E[A-F]/) ZONE = "37";
    if ($1 ~ /^E[I-J]/) ZONE = "27";
    if ($1 ~ /^ER/) ZONE = "29";
    if ($1 ~ /^ES/) ZONE = "29";
    if ($1 ~ /^E[U-W]/) ZONE = "29";
    if ($1 ~ /^EX/) ZONE = "30";
    if ($1 ~ /^EY/) ZONE = "30";
    if ($1 ~ /^F[0-9]/) ZONE = "27";
    if ($1 ~ /^([GM][0-9DMWUIJ]|2E)/) ZONE = "27";
    if ($1 ~ /^H[AG]/) ZONE = "28";
    if ($1 ~ /^HB[1-9]/) ZONE = "28";
    if ($1 ~ /^H[CK]/) ZONE = "12";
    if ($1 ~ /^HF/) ZONE = "28";
    if ($1 ~ /^I[0-9,K-N,T-Z]/) ZONE = "28";
    if ($1 ~ /^IS0/) ZONE = "28";
    if ($1 ~ /^J[A-S]/) ZONE = "45";
    if ($1 ~ /^JT/) ZONE = "32";
    if ($1 ~ /^KP2/) ZONE = "11";
    if ($1 ~ /^L[A-N]/) ZONE = "18";
    if ($1 ~ /^L[O-W]/) ZONE = "14";
    if ($1 ~ /^LX/) ZONE = "27";
    if ($1 ~ /^LY/) ZONE = "29";
    if ($1 ~ /^LZ/) ZONE = "28";
    if ($1 ~ /^OD/) ZONE = "39";
    if ($1 ~ /^OE/) ZONE = "28";
    if ($1 ~ /^O[G-J]/) ZONE = "18";
    if ($1 ~ /^O[KL]/) ZONE = "28";
    if ($1 ~ /^OM/) ZONE = "28";
    if ($1 ~ /^O[N-T]/) ZONE = "27";
    if ($1 ~ /^O[U-Z]/) ZONE = "18";
    if ($1 ~ /^P4/) ZONE = "11";
    if ($1 ~ /^P[A-I]/) ZONE = "27";
    if ($1 ~ /^P[P-Y]/) ZONE = "15";
    if ($1 ~ /^PZ/) ZONE = "12";
    if ($1 ~ /^(R[1-7][A-Z]|R[A-Z][1-7]|UA[1-7])/) ZONE = "29";
    if ($1 ~ /^S5/) ZONE = "28";
    if ($1 ~ /^(S[A-M]|[78]S)/) ZONE = "18";
    if ($1 ~ /^(S[N-R]|3Z)/) ZONE = "28";
    if ($1 ~ /^ST/) ZONE = "48";
    if ($1 ~ /^S[V-Z][01234678]/) ZONE = "28";
    if ($1 ~ /^S[V-Z]5/) ZONE = "28";
    if ($1 ~ /^S[V-Z]9/) ZONE = "28";
    if ($1 ~ /^(T6|YA)/) ZONE = "40";
    if ($1 ~ /^TA/) ZONE = "39";
    if ($1 ~ /^TF/) ZONE = "17";
    if ($1 ~ /^TG/) ZONE = "11";
    if ($1 ~ /^UN/) ZONE = "30";
    if ($1 ~ /^U[R-Z]/) ZONE = "29";
    if ($1 ~ /^V3/) ZONE = "11";
    if ($1 ~ /^VK/) ZONE = "59";
    if ($1 ~ /^VK[48]/) ZONE = "55";
    if ($1 ~ /^VK6/) ZONE = "58";
    if ($1 ~ /^VK9/) ZONE = "60";
    if ($1 ~ /^VK9[CXY]/) ZONE = "54";
    if ($1 ~ /^VK9M/) ZONE = "56";
    if ($1 ~ /^VK9[WZ]/) ZONE = "55";
    if ($1 ~ /^VP2M/) ZONE = "11";
    if ($1 ~ /^VU/) ZONE = "41";
    if ($1 ~ /^VU4/) ZONE = "49";
    if ($1 ~ /^XE/) ZONE = "10";
    if ($1 ~ /^Y[B-H]/) ZONE = "51";
    if ($1 ~ /^YJ/) ZONE = "56";
    if ($1 ~ /^YL/) ZONE = "29";
    if ($1 ~ /^YM/) ZONE = "39";
    if ($1 ~ /^Y[OPQRSTUZ]/) ZONE = "28";
    if ($1 ~ /^YS/) ZONE = "11";
    if ($1 ~ /^YV/) ZONE = "12";
    if ($1 ~ /^ZB/) ZONE = "37";
    if ($1 ~ /^Z3/) ZONE = "28";
    if ($1 ~ /^ZA/) ZONE = "28";
    if ($1 ~ /^ZC4/) ZONE = "39";
    if ($1 ~ /^ZD/) ZONE = "66";
    if ($1 ~ /^ZF/) ZONE = "11";
    if ($1 ~ /^Z[LM]/) ZONE = "60";
    if ($1 ~ /^ZP/) ZONE = "14";
    if ($1 ~ /^Z[R-S]/) ZONE = "57";

    if (GRID == "" || ZONE == "")
    {
      if (FGRID ~ /^EN(4[8-9])/) ZONE ="03";
      if (FGRID ~ /^EN(4[0-7])/) ZONE ="07";
      if (FGRID ~ /^EN(5[0-7]|6[0-1])/) ZONE ="08";
      if (FGRID ~ /^EN(5[8-9])/) ZONE ="04";
      if (FGRID ~ /^EN5[3-7]/) ZONE ="01";
    }

    if (GRID == "" || ZONE == "")
    {
      printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
    }
    else 
    {
      printf("%s=%s\n", $1, ZONE GRID);
    }
  }
}
END {
  printf("#0 Ham Spirit Contest database\n");
  printf("#1 Derived from Stew Perry database maintained by Claude VE2FK\n");
  printf("#4 Last updated %s\n", strftime("%Y-%m-%d"));
}' $FILE | sort | sed 's/^\#. /\# /g' > $OUTFILE

echo $OUTFILE "created"
unix2dos -q $OUTFILE
exit

