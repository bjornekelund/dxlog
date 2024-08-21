BEGIN {
  FS=","
  printf("#0 Database for FISTS Sprint\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
}
{
  if ($1 == "!!Order!!") {
    if ($2 ~ /Call/) callcol = 1; else
    if ($3 ~ /Call/) callcol = 2; else
    if ($4 ~ /Call/) callcol = 3; else
    if ($5 ~ /Call/) callcol = 4; else callcol = 0;

    if ($2 ~ /Misc/) memcol = 1; else
    if ($3 ~ /Misc/) memcol = 2; else
    if ($4 ~ /Misc/) memcol = 3; else
    if ($5 ~ /Misc/) memcol = 4; else memcol = 0;

    if ($2 ~ /Name/) namecol = 1; else
    if ($3 ~ /Name/) namecol = 2; else
    if ($4 ~ /Name/) namecol = 3; else
    if ($5 ~ /Name/) namecol = 4; else namecol = 0;

    if ($2 ~ /Exch1/) loccol = 1; else
    if ($3 ~ /Exch1/) loccol = 2; else
    if ($4 ~ /Exch1/) loccol = 3; else
    if ($5 ~ /Exch1/) loccol = 4; else loccol = 0;

    printf("%s --> call=%d, mem=%d, name=%d, loc=%d\n", $0, callcol, memcol, namecol, loccol) > "/dev/stderr";
  }
  else if ($0 !~ /^#/ && $callcol !~ /SWL/){
      # printf("%s mem=%d $mem=%s\n", $callcol, memcol, $memcol) > "/dev/stderr";

    if (memcol > 0 && $memcol != "") member[$callcol] = $memcol;
    if (loccol > 0 && $loccol != "") location[$callcol] = $loccol;
    if (namecol > 0 && $namecol != "" && $namecol ~ /^[A-Za-z]+$/) name[$callcol] = $namecol;

    if ($callcol ~ /^2E[0-9]/) location[$callcol] = "223";
    if ($callcol ~ /^[GM][BC]?[0-9]/) location[$callcol] = "223";
    if ($callcol ~ /^[GM2]D[0-9]/) location[$callcol] = "114";
    if ($callcol ~ /^[GM]I[0-9]/) location[$callcol] = "265";
    if ($callcol ~ /^[GM]J[0-9]/) location[$callcol] = "122";
    if ($callcol ~ /^[GM][MS][0-9]/) location[$callcol] = "279";
    if ($callcol ~ /^[GM]U[0-9]/) location[$callcol] = "106";
    if ($callcol ~ /^[GM]W[0-9]/) location[$callcol] = "294";
    if ($callcol ~ /^I[I-Z]?[0-9]/) location[$callcol] = "248";
    if ($callcol ~ /^J[A-S][0-9]/) location[$callcol] = "339";
    if ($callcol ~ /^S[A-M][0-9]/) location[$callcol] = "284";
    if ($callcol ~ /^D[A-R][0-9]/) location[$callcol] = "230";
    if ($callcol ~ /^E[AH][0-9]/) location[$callcol] = "281";
    if ($callcol ~ /^E[IJ][0-9]/) location[$callcol] = "245";
    if ($callcol ~ /^F[0-9]/) location[$callcol] = "227";
    if ($callcol ~ /^O[F-I][0-9]/) location[$callcol] = "224";
    if ($callcol ~ /^O[N-T][0-9]/) location[$callcol] = "209";
    if ($callcol ~ /^OZ[0-9]/) location[$callcol] = "221";
    if ($callcol ~ /^P[A-I][0-9]/) location[$callcol] = "263";

    if ($callcol ~ /^(V[AE]1|CY[09])/) location[$callcol] = "NS";
    if ($callcol ~ /^(V[ABCEFG]|X[LM]|C[FG])2/) location[$callcol] = "QC";
    if ($callcol ~ /^(V[ABCEFG]|X[LM]|C[FG])3/) location[$callcol] = "ON";
    if ($callcol ~ /^V[ABCEFG]4/) location[$callcol] = "MB";
    if ($callcol ~ /^V[ABCEFG]5/) location[$callcol] = "SK";
    if ($callcol ~ /^V[ABCEFG]6/) location[$callcol] = "AB";
    if ($callcol ~ /^V[ABCEFGX]7/) location[$callcol] = "BC";
    if ($callcol ~ /^VE8/) location[$callcol] = "NT";
    if ($callcol ~ /^V[CE]9/) location[$callcol] = "NB";
    if ($callcol ~ /^VO[12]/) location[$callcol] = "NL";
    if ($callcol ~ /^VY0/) location[$callcol] = "NU";
    if ($callcol ~ /^(VY|XO)1/) location[$callcol] = "YT";
    if ($callcol ~ /^VY2/) location[$callcol] = "PE";

    if ($callcol ~ /^VK[0-9]/) location[$callcol] = "150";
    if ($callcol ~ /^X[A-I][0-9]/) location[$callcol] = "050";
    if ($callcol ~ /^Z[LM][0-9]/) location[$callcol] = "170";

    # if (callsign[$callcol] != "")
    #   printf("%s updated name=%s mem=%s loc=%s\n", $callcol, name[$callcol], member[$callcol], location[$callcol]) > "/dev/stderr";

    callsign[$callcol] = $callcol;

# if (namecol > 0)
#     printf("callsign[%s]=%s name[%s]=%s\n", $callcol, callsign[$callcol], $callcol, name[$callcol]) > "/dev/stderr";


    # if (call ~ /^[0-9A-Z/]+$/ && mem ~ /^([0-9]{1,5}|)$/ && name ~ /^([A-Z]{2,})$/) {
    #   printf("%s=%s;%s\n", call, name, mem);
    # }
    # else if ($0 !~ /^(!|#|$)/) {
    #   printf("Ignored: %s\n", $0) > "/dev/stderr";
  }
}
END{
    for (call in callsign)
    {
      if (member[call] != "")
        printf("%s=%s;%s;%s\n", call, name[call], member[call], location[call]);
    }
}
