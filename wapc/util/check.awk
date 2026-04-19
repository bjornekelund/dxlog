BEGIN {
  FS = "=";
  call = 1;
  state = 2;
  calls = 0;
  diffs = 0;
}
{
  guess = "";
  
  if ($call ~ /^(B[A-HY]0[A-F])/) guess = "XJ";
  else if ($call ~ /^B[A-HY]0[G-Z]/) guess = "XZ";
  else if ($call ~ /^B[A-UY]?1/) guess = "BJ";
  else if ($call ~ /^(BA2B|BD2[BCDEF]|BG2[ABCDEFGH]|BY2[AH])/) guess = "HL";
  else if ($call ~ /^(BA2I|BD2[IJK]|BG2[IKLM])/) guess = "JL";
  else if ($call ~ /^(BD2[QRSTUVWXY]|BG2[QRSTUVWX]|BH2[QRSTUVWX]|BY2W)/) guess = "LN";
  else if ($call ~ /^(B3AF|B3C|BA3[ABT]|BD3[BCST]|BG3[ADF]|BH3[ABCDEF]|BI3[ABE]|BY3C)/) guess = "TJ";
  else if ($call ~ /^(BA3G|BD3G|BG3[BGHIJKLZ]|BH3[GHJ]|BR3H|BY3[AG]|BY4G)/) guess = "NM";
  else if ($call ~ /^(BA3[KMNOQR]|BA4A|BD3[MNOPQR]|BG3[MNOPR]|BH3[LMNOPQR]|BI3[MNOPQ]|BY3[MR])/) guess = "HE";
  else if ($call ~ /^(BA3W|BD3[KUV]|BG3[STU]|BH3[STUVWX]|BH9A|BI3[SVX]|BY3[TY]|BY9C)/) guess = "SX";
  else if ($call ~ /^(B4B|BA4[DE]|BD4[ACEFGH]|BG3Q|BG4[ACDFGH]|BH4[ABCDEFGHN]|BH5B|BY4[ABCDH])/) guess = "SH";
  else if ($call ~ /^(BA4[IKMO]|BD4[IJKLMO]|BG0O|BG2O|BG4[IJKLMNOP]|BH4[IKLMOP]|BI4[BIJKLMNOP]|BJ4O|BY4[IJL])/) guess = "SD";
  else if ($call ~ /^(B4HQ|B4R|B4S|B4TB|B4VE|BA4[QRSTVW]|BD4[DQRSTUVWX]|BD5R|BG4[QSTUVWX]|BH4[JQRSTUVWX]|BI2M|BI4[QRSTUVWXZ]|BY4[QRSTX])/) guess = "JS";
  else if ($call ~ /^(B5A|B5B|B5C|B5HQ|BA4C|BA5[ABCFH]|BB5H|BD5[BCDEFH]|BG4B|BG5[ABCDEFGH]|BG8M|BH5[EH]|BH6Q|BK4B|BY4E|BY5[ACEH])/) guess = "ZJ";
  else if ($call ~ /^(BD5[INP]|BG5[A-P]|BI7A)/) guess = "JX";
  else if ($call ~ /^(B5TT|BB5T|BD5[Q-Z]|BG5[QRTUVX]|BH5S|BY5Y)/) guess = "FJ";
  else if ($call ~ /^(BD6[ACH]|BG4E|BG6[A-H]|BH6[AB]|BJ3A|BY2P|BY6[ABDP])/) guess = "AH";
  else if ($call ~ /^(B6HQ|BA6[IK]|BD6[IJKNOP]|BG6[IJKLO]|BH6[IKMOP]|BI6[ILMN]|BY3L|BY6I)/) guess = "HA";
  else if ($call ~ /^(BA6Q|BD3A|BD6[Q-Z]|BG6[QRSTUVWX]|BH6[RS]|BY6[QS])/) guess = "HB";
  else if ($call ~ /^(BA6J|BA7[CG]|BD6M|BD7[BDEF]|BG7[ABCDEF]|BH6J|BH7[ABEFGH]|BY6L)/) guess = "HN";
  else if ($call ~ /^(B7HQ|B7M|B7P|BA3I|BA7[IJKLMNOP]|BD7[ACIJKLMNOPQ]|BG7[IKLMNOP]|BH7[CDIJKLMNOP]|BI7[IJKLMNOP]|BL7J|BY2K|BY7[IKMP])/) guess = "GD";
  else if ($call ~ /^(BA7[QS]|BB7S|BD7[RSX]|BG7[JQRSTWXZ]|BH7[QX]|BJ7X|BY7[EQSWX])/) guess = "GX";
  else if ($call ~ /^(BD7[UY]|BG7Y|BS7H|BY2M)/) guess = "HI";
  else if ($call ~ /^(BA8[ABCD]|BD8[ABCDE]|BG8[ABDEF]|BH8[ABCDEF]|BI8[ACDEF]|BY8[ACD])/) guess = "SC";
  else if ($call ~ /^(BA8I|BD8G|BG8[GHIJKL]|BH8G|BY8G)/) guess = "CQ";
  else if ($call ~ /^(BA8M|BD8[MN]|BG8[NP]|BH8[MNOPQ]|BI8M|BY8M)/) guess = "GZ";
  else if ($call ~ /^(BD8[ST]|BG8[STV]|BH8[SV]|BI8S|BY8S)/) guess = "YN";
  else if ($call ~ /^(BA9B|BD9[ABCD]|BG9[ABCDEFRU]|BH9|BI9[AB]|BY9G)/) guess = "SN";
  else if ($call ~ /^(BD9G|BG9[GHIJL]|BI6J|BY0K)/) guess = "GS";
  else if ($call ~ /^(BD9M|BG9[MNOQ]|BY5N|BY9N)/) guess = "NX";
  else if ($call ~ /^(BA9T|BD9X|BG9[SX])/) guess = "QH";    
  else if ($call ~ /^VR/) guess = "HK";
  else if ($call ~ /^XX9/) guess = "MO";
  else if ($call ~ /^B[VWX]/) guess = "TW";

  # }

  calls++;

  if (guess != "" && $state != guess)
  {
    printf("Prediction error: \"%s\" should be \"%s\" in \"%s\"\n", guess, $state, $0);
    diffs++;
  }
}
END {
  printf("Total calls: %d, differences: %d\n", calls, diffs);
}
