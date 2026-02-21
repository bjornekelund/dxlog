BEGIN {
  FS = ",";
}
{
  if ($0~ /!!Order!!/)
  {
    if ($2 ~ /Call/) call = 1;
    if ($3 ~ /Call/) call = 2;
    if ($4 ~ /Call/) call = 3;
    if ($5 ~ /Call/) call = 4;
    if ($3 ~ /Exch1|State/) state = 2;
    if ($4 ~ /Exch1|State/) state = 3;
    if ($5 ~ /Exch1|State/) state = 4;
    printf("%s --> call=%d state=%d\n", $0, call, state) > "/dev/stderr";
  }
  else if ($call ~ /^(V[A-GX]|C[FG])/)
  {
    guess = "";

    if ($call ~/^((V[A-GX]|C[FG])1)(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/1$|\/VE1$/) guess = "NS";
    if ($call ~/^(V[A-GX]|X[LM]|C[FG])2(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/2$|\/VE2$/) guess = "QC";
    if ($call ~/^(V[A-GX]|X[LM]|C[FG])3(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/3$|\/VE3$/) guess = "ON";
    if ($call ~/^(V[A-GX]|C[FG])4(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/4$|\/VE4$/) guess = "MB";
    if ($call ~/^(V[A-GX]|C[FG])5(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/5$|\/VE5$/) guess = "SK";
    if ($call ~/^(V[A-GX]|C[FG])6(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/6$|\/VE6$/) guess = "AB";
    if ($call ~/^(V[A-GX]|C[FG])7(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/7$|\/VE7$/) guess = "BC";
    if ($call ~/^(VE|C[FG])8(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/8$|\/VE8$/) guess = "NT";
    if ($call ~/^(V[CE]|C[FG])9(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/9$|\/VE9$/) guess = "NB";
    if ($call ~/^VO[12](\/|[^/]*$|.+\/[12MP]$)|\/VO[12]$/) guess = "NL";
    if ($call ~/^(VY|XO)0(\/|[^/]*$|.+\/[MP]$)|^(VY|XO).+\/0$|\/VY0$/) guess = "NU";
    if ($call ~/^(VY|XO)1(\/|[^/]*$|.+\/[MP]$)|^(VY|XO).+\/1$|\/VY1$/) guess = "YT";
    if ($call ~/^(VY|XO)2(\/|[^/]*$|.+\/[MP]$)|^(VY|XO).+\/2$|\/VY2$/) guess = "PE";

    # if (state != guess && state ~ /^[A-Z]{2}$/)
    if ($state != guess && $state != "" && $state ~ /^[A-Z]{2}$/)
    {
      printf("Irregular exchange \"%s\" guess is \"%s\"\n", $0, guess) > "/dev/stderr";
    }
  }
}
