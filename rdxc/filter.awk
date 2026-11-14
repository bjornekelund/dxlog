BEGIN {
  printf("#00 Russian DX Contest irregular exchanges prefill database\n");
  printf("#01 Contains only prefill that differs from DXLog's rule based Oblast prefill\n");
  FS = ",";
}
{
if ($1 ~ /!!Order!!/)
  {
    call = FindColumn("Call");
    exch = FindColumn("Exch1");
  # printf\("%s --> call=%d exch=%d\n", $0, call, exch) > "/dev/stderr";
  }
  else
  {
    oblast ="";
    if ($call ~ /^RI1AN/) oblast="AN";
    if ($call ~ /^RI1F|^R1FJ/) oblast="FJ";
    if ($call ~ /^RK1G$/) oblast="SM";
    if ($call ~ /^[RU]1[ABFGHJLM]|^R[A-Z]1[ABFGHJLM]|^U[A-I]1[ABFGHJLM]/) oblast="SP";
    if ($call ~ /^[RU]1[CDE]|^R[A-Z]1[CDE]|^U[A-I]1[CDE]/) oblast="LO";
    if ($call ~ /^[RU]1I|^R[A-Z]1I|^U[A-I]1I/) oblast="KO";
    if ($call ~ /^[RU]1[KN]|^R[A-Z]1[KN]|^U[A-I]1[KN]/) oblast="KL";
    if ($call ~ /^[RU]1O|^R[A-Z]1O|^U[A-I]1O/) oblast="AR";
    if ($call ~ /^[RU]1P|^R[A-Z]1P|^U[A-I]1P/) oblast="NO";
    if ($call ~ /^[RU]1[QRS]|^R[A-Z]1[QRS]|^U[A-I]1[QRS]/) oblast="VO";
    if ($call ~ /^[RU]1T|^R[A-Z]1T|^U[A-I]1T/) oblast="NV";
    if ($call ~ /^[RU]1[WX]|^R[A-Z]1[WX]|^U[A-I]1[WX]/) oblast="PS";
    if ($call ~ /^[RU]1[YZ]|^R[A-Z]1[YZ]|^U[A-I]1[YZ]/) oblast="MU";
    if ($call ~ /^[RU]2[FK]|^R[A-Z]2[FK]|^U[A-I]2[FK]/) oblast="KA";
    if ($call ~ /^[RU][235][ABC]|^R[A-Z][235][ABC]|^U[A-I][235][ABC]/) oblast="MA";
    if ($call ~ /^[RU][235][DH]|^R[A-Z][235][DH]|^U[A-I][235][DH]/) oblast="MO";
    if ($call ~ /^[RU][35]F|^R[A-Z][35]F|^U[A-I][35]F/) oblast="MO";
    if ($call ~ /^[RU][235]E|^R[A-Z][235]E|^U[A-I][235]E/) oblast="OR";
    if ($call ~ /^[RU][235]G|^R[A-Z][235]G|^U[A-I][235]G/) oblast="LP";
    if ($call ~ /^[RU][235][IJ]|^R[A-Z][235][IJ]|^U[A-I][235][IJ]/) oblast="TV";
    if ($call ~ /^[RU][235]L|^R[A-Z][235]L|^U[A-I][235]L/) oblast="SM";
    if ($call ~ /^[RU][235]M|^R[A-Z][235]M|^U[A-I][235]M/) oblast="YR";
    if ($call ~ /^[RU][235]N|^R[A-Z][235]N|^U[A-I][235]N/) oblast="KS";
    if ($call ~ /^[RU][235]P|^R[A-Z][235]P|^U[A-I][235]P/) oblast="TL";
    if ($call ~ /^[RU][35]K|^R[A-Z][35]K|^U[A-I][35]K/) oblast="VR";
    if ($call ~ /^[RU][235][OQ]|^R[A-Z][235][OQ]|^U[A-I][235][OQ]/) oblast="VR";
    if ($call ~ /^[RU][235]R|^R[A-Z][235]R|^U[A-I][235]R/) oblast="TB";
    if ($call ~ /^[RU][235]S|^R[A-Z][235]S|^U[A-I][235]S/) oblast="RA";
    if ($call ~ /^[RU][235]T|^R[A-Z][235]T|^U[A-I][235]T/) oblast="NN";
    if ($call ~ /^[RU][235]U|^R[A-Z][235]U|^U[A-I][235]U/) oblast="IV";
    if ($call ~ /^[RU][235]V|^R[A-Z][235]V|^U[A-I][235]V/) oblast="VL";
    if ($call ~ /^[RU][235]W|^R[A-Z][235]W|^U[A-I][235]W/) oblast="KU";
    if ($call ~ /^[RU][235]X|^R[A-Z][235]X|^U[A-I][235]X/) oblast="KG";
    if ($call ~ /^[RU][235]Y|^R[A-Z][235]Y|^U[A-I][235]Y/) oblast="BR";
    if ($call ~ /^[RU][235]Z|^R[A-Z][235]Z|^U[A-I][235]Z/) oblast="BO";
    if ($call ~ /^[RU]4[AB]|^R[A-Z]4[AB]|^U[A-I]4[AB]/) oblast="VG";
    if ($call ~ /^[RU]4[CD]|^R[A-Z]4[CD]|^U[A-I]4[CD]/) oblast="SA";
    if ($call ~ /^[RU]4[FG]|^R[A-Z]4[FG]|^U[A-I]4[FG]/) oblast="PE";
    if ($call ~ /^[RU]4[HIK]|^R[A-Z]4[HIK]|^U[A-I]4[HIK]/) oblast="SR";
    if ($call ~ /^[RU]4[LM]|^R[A-Z]4[LM]|^U[A-I]4[LM]/) oblast="UL";
    if ($call ~ /^[RU]4[NO]|^R[A-Z]4[NO]|^U[A-I]4[NO]/) oblast="KI";
    if ($call ~ /^[RU]4[PQR]|^R[A-Z]4[PQR]|^U[A-I]4[PQR]/) oblast="TA";
    if ($call ~ /^[RU]4[ST]|^R[A-Z]4[ST]|^U[A-I]4[ST]/) oblast="MR";
    if ($call ~ /^[RU]4U|^R[A-Z]4U|^U[A-I]4U/) oblast="MD";
    if ($call ~ /^[RU]4W|^R[A-Z]4W|^U[A-I]4W/) oblast="UD";
    if ($call ~ /^[RU]4[YZ]|^R[A-Z]4[YZ]|^U[A-I]4[YZ]/) oblast="CU";
    if ($call ~ /^[RU][67][ABCD]|^R[A-Z][67][ABCD]|^U[A-I][67][ABCD]/) oblast="KR";
    if ($call ~ /^[RU][67]E|^R[A-Z][67]E|^U[A-I][67]E/) oblast="KC";
    if ($call ~ /^[RU][67][FGHT]|^R[A-Z][67][FGHT]|^U[A-I][67][FGHT]/) oblast="ST";
    if ($call ~ /^[RU][67]I|^R[A-Z][67]I|^U[A-I][67]I/) oblast="KM";
    if ($call ~ /^[RU][67]J|^R[A-Z][67]J|^U[A-I][67]J/) oblast="SO";
    if ($call ~ /^[RU][67][K]|^R[A-Z][67][K]|^U[A-I][67][K]/) oblast="RK";
    if ($call ~ /^[RU][67][LMN]|^R[A-Z][67][LMN]|^U[A-I][67][LMN]/) oblast="RO";
    if ($call ~ /^[RU][67][P]|^R[A-Z][67][P]|^U[A-I][67][P]/) oblast="CN";
    if ($call ~ /^[RU][67]Q|^R[A-Z][67]Q|^U[A-I][67]Q/) oblast="IN";
    if ($call ~ /^[RU][67][R]|^R[A-Z][67][R]|^U[A-I][67][R]/) oblast="SE";
    if ($call ~ /^[RU][67][UV]|^R[A-Z][67][UV]|^U[A-I][67][UV]/) oblast="AO";
    if ($call ~ /^[RU][67]W|^R[A-Z][67]W|^U[A-I][67]W/) oblast="DA";
    if ($call ~ /^[RU][67]X|^R[A-Z][67]X|^U[A-I][67]X/) oblast="KB";
    if ($call ~ /^[RU][67]Y|^R[A-Z][67]Y|^U[A-I][67]Y/) oblast="AD";
    if ($call ~ /^[RU][89][AB]|^R[A-Z][89][AB]|^U[A-I][89][AB]/) oblast="CB";
    if ($call ~ /^[RU][89][CD]|^R[A-Z][89][CD]|^U[A-I][89][CD]/) oblast="SV";
    if ($call ~ /^[RU][89][FG]|^R[A-Z][89][FG]|^U[A-I][89][FG]/) oblast="PM";
    if ($call ~ /^[RU][89][HI]|^R[A-Z][89][HI]|^U[A-I][89][HI]/) oblast="TO";
    if ($call ~ /^[RU][89]J|^R[A-Z][89]J|^U[A-I][89]J/) oblast="HM";
    if ($call ~ /^[RU][89]K|^R[A-Z][89]K|^U[A-I][89]K/) oblast="YN";
    if ($call ~ /^[RU][89]L|^R[A-Z][89]L|^U[A-I][89]L/) oblast="TN";
    if ($call ~ /^[RU][89][MN]|^R[A-Z][89][MN]|^U[A-I][89][MN]/) oblast="OM";
    if ($call ~ /^[RU][89][OP]|^R[A-Z][89][OP]|^U[A-I][89][OP]/) oblast="NS";
    if ($call ~ /^[RU][89][QR]|^R[A-Z][89][QR]|^U[A-I][89][QR]/) oblast="KN";
    if ($call ~ /^[RU][89][ST]|^R[A-Z][89][ST]|^U[A-I][89][ST]/) oblast="OB";
    if ($call ~ /^[RU][89][UV]|^R[A-Z][89][UV]|^U[A-I][89][UV]/) oblast="KE";
    if ($call ~ /^[RU][89]W|^R[A-Z][89]W|^U[A-I][89]W/) oblast="BA";
    if ($call ~ /^[RU][89]X|^R[A-Z][89]X|^U[A-I][89]X/) oblast="KO";
    if ($call ~ /^[RU][89]Y|^R[A-Z][89]Y|^U[A-I][89]Y/) oblast="AL";
    if ($call ~ /^[RU][89]Z|^R[A-Z][89]Z|^U[A-I][89]Z/) oblast="GA";
    if ($call ~ /^[RU]0[ABH]|^R[A-Z]0[ABH]|^U[A-I]0[ABH]/) oblast="KK";
    if ($call ~ /^[RU]0C|^R[A-Z]0C|^U[A-I]0C/) oblast="HK";
    if ($call ~ /^[RU]0D|^R[A-Z]0D|^U[A-I]0D/) oblast="EA";
    if ($call ~ /^[RU]0[FE]|^R[A-Z]0[FE]|^U[A-I]0[FE]/) oblast="SL";
    if ($call ~ /^[RU]0I|^R[A-Z]0I|^U[A-I]0I/) oblast="MG";
    if ($call ~ /^[RU]0J|^R[A-Z]0J|^U[A-I]0J/) oblast="AM";
    if ($call ~ /^[RU]0K|^R[A-Z]0K|^U[A-I]0K/) oblast="CK";
    if ($call ~ /^[RU]0[LMN]|^R[A-Z]0[LMN]|^U[A-I]0[LMN]/) oblast="PK";
    if ($call ~ /^[RU]0O|^R[A-Z]0O|^U[A-I]0O/) oblast="BU";
    if ($call ~ /^[RU]0Q|^R[A-Z]0Q|^U[A-I]0Q/) oblast="YA";
    if ($call ~ /^[RU]0[STR]|^R[A-Z]0[STR]|^U[A-I]0[STR]/) oblast="IR";
    if ($call ~ /^[RU]0[UV]|^R[A-Z]0[UV]|^U[A-I]0[UV]/) oblast="ZK";
    if ($call ~ /^[RU]0W|^R[A-Z]0W|^U[A-I]0W/) oblast="HA";
    if ($call ~ /^[RU]0Y|^R[A-Z]0Y|^U[A-I]0Y/) oblast="TU";
    if ($call ~ /^[RU]0[XZ]|^R[A-Z]0[XZ]|^U[A-I]0[XZ]/) oblast="KT";

    if (lines[$call] != "")
    {
      # printf("\"%s\" reoccurs as \"%s\"\n", lines[$call], $0) > "/dev/stderr";
    }
    else
    {
      lines[$call] = $0;
    }

    if ($call ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/ && $exch != oblast && $call !~ /\/(QRP|M)/)
    {
      # if (oblast == "")
      #   printf("%s: file: %s\n", $call, $exch) > "/dev/stderr";
      # else
      #   printf("%s: file: %s rule: %s\n", $call, $exch, oblast) > "/dev/stderr";
      printf("%s=%s\n", $call, $exch);
    }
  }
}
