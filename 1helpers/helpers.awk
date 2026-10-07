function IsVEcall(call) 
{
  if (call ~ /^((V[A-GOXY]|C[FG]|X[LM])[0-9])(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/[0-9]$|\/V[OYE][0-9]$/)
  {
    if (call ~ /\//)
    {
    #   printf("VE call %s\n", call) > "/dev/stderr";
    }
    return 1;
  }
  else
  {
    if (call ~ /^V/)
    {
    #   printf("Non VE call %s\n", call) > "/dev/stderr";
    }
    return 0;
  }
}

function IsCONUSPcall(call)
{
  if (call ~ /^(A[A-L]|[KNW][A-Z]?)[0-9](([A-Z]{1,3})(\/([0-9MP]|QRP))?$|\/)|^4U1WB$|\/(W[0-9]|KL7|KH6)$/ && \
      call !~ /\/V[EOY][0-9]$/ && \
      call !~ /^KG4[A-Z]{2}$|^[KNW]P[234][A-Z]{1,3}$/)
  {
    return 1;
  }
  else
  {
    return 0;
  }
}

function IsUScall(call)
{
  if (call ~ /^(A[A-L]|[KNW][A-Z]?)[0-9](([A-Z]{1,3})(\/([0-9MP]|QRP))?$|\/)|^4U1WB$|\/(W[0-9]|KL7|KH6)$/ && \
      call !~ /\/V[EOY][0-9]$/)
  {
    return 1;
  }
  else
  {
    return 0;
  }
}

function IsNAcall(call)
{
  if (IsUScall(call) || IsVEcall(call))
  {
    return 1;
  }
  else
  {
    return 0;
  }
}

function NotPredictableVE13(call, state) 
{
  if (! IsVEcall(call) || state ~ /[A-Z]{3,5}/)
  {
      # printf("Non VE call %s with exchange %s\n", call, state) > "/dev/stderr";
    return 1;
  }
  else if ((call ~ /^((V[A-GX]|C[FG])1)(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/1$|\/VE1$/ && state != "NS") ||\
      (call ~ /^(V[A-GX]|X[LM]|C[FG])2(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/2$|\/VE2$/ && state != "QC") ||\
      (call ~ /^(V[A-GX]|X[LM]|C[FG])3(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/3$|\/VE3$/ && state != "ON") ||\
      (call ~ /^(V[A-GX]|C[FG])4(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/4$|\/VE4$/ && state != "MB") ||\
      (call ~ /^(V[A-GX]|C[FG])5(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/5$|\/VE5$/ && state != "SK") ||\
      (call ~ /^(V[A-GX]|C[FG])6(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/6$|\/VE6$/ && state != "AB") ||\
      (call ~ /^(V[A-GX]|C[FG])7(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/7$|\/VE7$/ && state != "BC") ||\
      (call ~ /^(VE|C[FG])8(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/8$|\/VE8$/ && state != "NT") ||\
      (call ~ /^(V[CE]|C[FG])9(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/9$|\/VE9$/ && state != "NB") ||\
      (call ~ /^VO[12](\/|[^/]*$|.+\/[12MP]$)|\/VO[12]$/ && state != "NL") ||\
      (call ~ /^(VY|XO)0(\/|[^/]*$|.+\/[MP]$)|^(VY|XO).+\/0$|\/VY0$/ && state != "NU") ||\
      (call ~ /^(VY|XO)1(\/|[^/]*$|.+\/[MP]$)|^(VY|XO).+\/1$|\/VY1$/ && state != "YT") ||\
      (call ~ /^(VY|XO)2(\/|[^/]*$|.+\/[MP]$)|^(VY|XO).+\/2$|\/VY2$/ && state != "PE"))
  {
    if (state ~ /^[A-Z]{2}/)
    {
      printf("Irregular VE call %s with exchange %s\n", call, state) > "/dev/stderr";
    }
    return 1;
  }
  else
  {
    return 0;
  }
}

function NotPredictableVE11(call, state) 
{
  if (! IsVEcall(call) || state ~ /[A-Z]{3,5}/)
  {
    # printf("Non VE call %s with exchange %s\n", call, state) > "/dev/stderr";
    return 1;
  }
  else if ((call ~ /^((V[A-GX]|C[FG])1)(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/1$|\/VE1$/ && state != "NS") ||\
      (call ~ /^(V[A-GX]|X[LM]|C[FG])2(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/2$|\/VE2$/ && state != "QC") ||\
      (call ~ /^(V[A-GX]|X[LM]|C[FG])3(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/3$|\/VE3$/ && state != "ON") ||\
      (call ~ /^(V[A-GX]|C[FG])4(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/4$|\/VE4$/ && state != "MB") ||\
      (call ~ /^(V[A-GX]|C[FG])5(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/5$|\/VE5$/ && state != "SK") ||\
      (call ~ /^(V[A-GX]|C[FG])6(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/6$|\/VE6$/ && state != "AB") ||\
      (call ~ /^(V[A-GX]|C[FG])7(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/7$|\/VE7$/ && state != "BC") ||\
      (call ~ /^(VE|C[FG])8(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/8$|\/VE8$/ && state != "NT") ||\
      (call ~ /^(V[CE]|C[FG])9(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/9$|\/VE9$/ && state != "NB") ||\
      (call ~ /^VO[12](\/|[^/]*$|.+\/[12MP]$)|\/VO[12]$/ && state != "NL") ||\
      (call ~ /^(VY|XO)0(\/|[^/]*$|.+\/[MP]$)|^(VY|XO).+\/0$|\/VY0$/ && state != "NT") ||\
      (call ~ /^(VY|XO)1(\/|[^/]*$|.+\/[MP]$)|^(VY|XO).+\/1$|\/VY1$/ && state != "NT") ||\
      (call ~ /^(VY|XO)2(\/|[^/]*$|.+\/[MP]$)|^(VY|XO).+\/2$|\/VY2$/ && state != "PE"))
  {
    if (state ~ /^[A-Z]{2}/)
    {
      printf("Irregular VE call %s with exchange %s\n", call, state) > "/dev/stderr";
    }
    return 1;
  }
  else
  {
    return 0;
  }
}

function NotPredictableVE14(call, state)
{
  if (! IsVEcall(call) || state ~ /[A-Z]{3,5}/)
  {
    # printf("Non VE call %s with exchange %s\n", call, state) > "/dev/stderr";
    return 1;
  }
  else if ((call ~ /^((V[A-GX]|C[FG])1)(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/1$|\/VE1$/ && state != "NS") ||\
      (call ~ /^(V[A-GX]|X[LM]|C[FG])2(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/2$|\/VE2$/ && state != "QC") ||\
      (call ~ /^(V[A-GX]|X[LM]|C[FG])3(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/3$|\/VE3$/ && state != "ON") ||\
      (call ~ /^(V[A-GX]|C[FG])4(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/4$|\/VE4$/ && state != "MB") ||\
      (call ~ /^(V[A-GX]|C[FG])5(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/5$|\/VE5$/ && state != "SK") ||\
      (call ~ /^(V[A-GX]|C[FG])6(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/6$|\/VE6$/ && state != "AB") ||\
      (call ~ /^(V[A-GX]|C[FG])7(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/7$|\/VE7$/ && state != "BC") ||\
      (call ~ /^(VE|C[FG])8(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/8$|\/VE8$/ && state != "NT") ||\
      (call ~ /^(V[CE]|C[FG])9(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/9$|\/VE9$/ && state != "NB") ||\
      (call ~ /^VO1(\/|[^/]*$|.+\/[1MP]$)|\/VO1$/ && state != "NF") ||\
      (call ~ /^VO2(\/|[^/]*$|.+\/[2MP]$)|\/VO2$/ && state != "LB") ||\
      (call ~ /^(VY|XO)0(\/|[^/]*$|.+\/[MP]$)|^(VY|XO).+\/0$|\/VY0$/ && state != "NU") ||\
      (call ~ /^(VY|XO)1(\/|[^/]*$|.+\/[MP]$)|^(VY|XO).+\/1$|\/VY1$/ && state != "YT") ||\
      (call ~ /^(VY|XO)2(\/|[^/]*$|.+\/[MP]$)|^(VY|XO).+\/2$|\/VY2$/ && state != "PE"))
  {
    if (state ~ /^[A-Z]{2}/)
    {
      printf("Irregular VE call %s with exchange %s\n", call, state) > "/dev/stderr";
    }
    return 1;
  }
  else
  {
    return 0;
  }
}

function NotPredictableQCQP(call, state)
{
  if (! IsVEcall(call) || (state ~ /[A-Z]{3,5}/ && state != "NWT"))
  {
    # printf("Non VE call %s with exchange %s\n", call, state) > "/dev/stderr";
    return 1;
  }
  else if ((call ~ /^((V[A-GX]|C[FG])1)(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/1$|\/VE1$/ && state != "NS") ||\
    (call ~ /^(V[A-GX]|X[LM]|C[FG])2(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/2$|\/VE2$/ && state != "QC") ||\
    (call ~ /^(V[A-GX]|X[LM]|C[FG])3(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/3$|\/VE3$/ && state != "ON") ||\
    (call ~ /^(V[A-GX]|C[FG])4(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/4$|\/VE4$/ && state != "MB") ||\
    (call ~ /^(V[A-GX]|C[FG])5(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/5$|\/VE5$/ && state != "SK") ||\
    (call ~ /^(V[A-GX]|C[FG])6(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/6$|\/VE6$/ && state != "AB") ||\
    (call ~ /^(V[A-GX]|C[FG])7(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/7$|\/VE7$/ && state != "BC") ||\
    (call ~ /^(VE|C[FG])8(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/8$|\/VE8$/ && state != "NWT") ||\
    (call ~ /^(V[CE]|C[FG])9(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/9$|\/VE9$/ && state != "NB") ||\
    (call ~ /^VO1(\/|[^/]*$|.+\/[1MP]$)|\/VO1$/ && state != "NF") ||\
    (call ~ /^VO2(\/|[^/]*$|.+\/[2MP]$)|\/VO2$/ && state != "LB") ||\
    (call ~ /^(VY|XO)0(\/|[^/]*$|.+\/[MP]$)|^(VY|XO).+\/0$|\/VY0$/ && state != "NU") ||\
    (call ~ /^(VY|XO)1(\/|[^/]*$|.+\/[MP]$)|^(VY|XO).+\/1$|\/VY1$/ && state != "YT") ||\
    (call ~ /^(VY|XO)2(\/|[^/]*$|.+\/[MP]$)|^(VY|XO).+\/2$|\/VY2$/ && state != "PE"))
  {
    if (state ~ /^[A-Z]{2}/)
    {
      printf("Irregular VE call %s with exchange %s\n", call, state) > "/dev/stderr";
    }
    return 1;
  }
  else
  {
    return 0;
  }
}

function NotPredictableARRL10(call, state)
{
  if (! IsVEcall(call) || state ~ /[A-Z]{3,5}/)
  {
    # printf("Non VE call %s with exchange %s\n", call, state) > "/dev/stderr";
    return 1;
  }
  else if ((call ~ /^((V[A-GX]|C[FG])1)(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/1$|\/VE1$/ && state != "NS") ||\
      (call ~ /^(V[A-GX]|X[LM]|C[FG])2(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/2$|\/VE2$/ && state != "QC") ||\
      (call ~ /^(V[A-GX]|X[LM]|C[FG])3(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/3$|\/VE3$/ && state != "ON") ||\
      (call ~ /^(V[A-GX]|C[FG])4(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/4$|\/VE4$/ && state != "MB") ||\
      (call ~ /^(V[A-GX]|C[FG])5(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/5$|\/VE5$/ && state != "SK") ||\
      (call ~ /^(V[A-GX]|C[FG])6(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/6$|\/VE6$/ && state != "AB") ||\
      (call ~ /^(V[A-GX]|C[FG])7(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/7$|\/VE7$/ && state != "BC") ||\
      (call ~ /^(VE|C[FG])8(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/8$|\/VE8$/ && state != "NT") ||\
      (call ~ /^(V[CE]|C[FG])9(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/9$|\/VE9$/ && state != "NB") ||\
      (call ~ /^VO1(\/|[^/]*$|.+\/[1MP]$)|\/VO1$/ && state != "NF") ||\
      (call ~ /^VO2(\/|[^/]*$|.+\/[2MP]$)|\/VO2$/ && state != "LB") ||\
      (call ~ /^(VY|XO)0(\/|[^/]*$|.+\/[MP]$)|^(VY|XO).+\/0$|\/VY0$/ && state != "NT") ||\
      (call ~ /^(VY|XO)1(\/|[^/]*$|.+\/[MP]$)|^(VY|XO).+\/1$|\/VY1$/ && state != "NT") ||\
      (call ~ /^(VY|XO)2(\/|[^/]*$|.+\/[MP]$)|^(VY|XO).+\/2$|\/VY2$/ && state != "PE"))
  {
    if (state ~ /^[A-Z]{2}/)
    {
      printf("Irregular VE call %s with exchange %s\n", call, state) > "/dev/stderr";
    }
    return 1;
  }
  else
  {
    return 0;
  }
}

function NotPredictableRAC(call, state)
{
  if (call !~ /^(V[A-GOY]|C[FG]|X[LMO])|^(V[A-GOXY]|X[LMO]|C[FG]).+\/[0-9]$|\/V[OYE][0-9]$/)
  {
    return 1;
  }
  else if ((call ~ /^((V[A-GX]|C[FG])1)(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/1$|\/VE1$/ && state != "NS") ||\
    (call ~ /^(V[A-GX]|X[LM]|C[FG])2(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/2$|\/VE2$/ && state != "QC") ||\
    (call ~ /^(V[A-GX]|X[LM]|C[FG])3(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/3$|\/VE3$/) ||\
    (call ~ /^(V[A-GX]|C[FG])4(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/4$|\/VE4$/ && state != "MB") ||\
    (call ~ /^(V[A-GX]|C[FG])5(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/5$|\/VE5$/ && state != "SK") ||\
    (call ~ /^(V[A-GX]|C[FG])6(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/6$|\/VE6$/ && state != "AB") ||\
    (call ~ /^(V[A-GX]|C[FG])7(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/7$|\/VE7$/ && state != "BC") ||\
    (call ~ /^(VE|C[FG])8(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/8$|\/VE8$/ && state != "TER") ||\
    (call ~ /^(V[CE]|C[FG])9(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/9$|\/VE9$/ && state != "NB") ||\
    (call ~ /^VO1(\/|[^/]*$|.+\/[1MP]$)|\/VO1$/ && state != "NL") ||\
    (call ~ /^VO2(\/|[^/]*$|.+\/[2MP]$)|\/VO2$/ && state != "NL") ||\
    (call ~ /^(VY|XO)0(\/|[^/]*$|.+\/[MP]$)|^(VY|XO).+\/0$|\/VY0$/ && state != "TER") ||\
    (call ~ /^(VY|XO)1(\/|[^/]*$|.+\/[MP]$)|^(VY|XO).+\/1$|\/VY1$/ && state != "TER") ||\
    (call ~ /^(VY|XO)2(\/|[^/]*$|.+\/[MP]$)|^(VY|XO).+\/2$|\/VY2$/ && state != "PE"))
  {
    if (state ~ /^[A-Z]{2}/ && state !~ /^(GH|ON[ENS])$/)
    {
      printf("Irregular VE call %s with exchange %s\n", call, state) > "/dev/stderr";
    }
    return 1;
  }
  else
  {
    return 0;
  }
}

function NotPredictableWAPC(call, state)
{
  if (call !~ /^(B[A-Y]?|XX|VR)[0-9]{1,3}[A-Z]{1,4}$/)
  {
    printf("Not relevant call %s with exchange %s\n", call, state) > "/dev/stderr";
    return 1;
  }
  else if (\
    (call ~ /^B[A-IY]?0[A-F]/ && state != "XJ") ||\
    (call ~ /^B[A-IY]?0[G-Z]/ && state != "XZ") ||\
    (call ~ /^B[A-IY]?1/ && state != "BJ") ||\
    (call ~ /^B[A-IY]?2[A-H]/ && state != "HL") ||\
    (call ~ /^B[A-IY]?2[I-P]/ && state != "JL") ||\
    (call ~ /^B[A-IY]?2[Q-Z]/ && state != "LN") ||\
    (call ~ /^B[A-IY]?3[A-F]/ && state != "TJ") ||\
    (call ~ /^B[A-IY]?3[G-L]/ && state != "NM") ||\
    (call ~ /^B[A-IY]?3[M-R]/ && state != "HE") ||\
    (call ~ /^B[A-IY]?3[S-Z]/ && state != "SX") ||\
    (call ~ /^B[A-IY]?4[A-H]/ && state != "SH") ||\
    (call ~ /^B[A-IY]?4[I-P]/ && state != "SD") ||\
    (call ~ /^B[A-IY]?4[Q-Z]/ && state != "JS") ||\
    (call ~ /^B[A-IY]?5[A-H]/ && state != "ZJ") ||\
    (call ~ /^B[A-IY]?5[I-P]/ && state != "JX") ||\
    (call ~ /^B[A-IY]?5[Q-Z]/ && state != "FJ") ||\
    (call ~ /^B[A-IY]?6[A-H]/ && state != "AH") ||\
    (call ~ /^B[A-IY]?6[I-P]/ && state != "HA") ||\
    (call ~ /^B[A-IY]?6[Q-Z]/ && state != "HB") ||\
    (call ~ /^B[A-IY]?7[A-H]/ && state != "HN") ||\
    (call ~ /^B[A-IY]?7[I-P]/ && state != "GD") ||\
    (call ~ /^B[A-IY]?7[Q-XZ]/ && state != "GX") ||\
    (call ~ /^B[A-IY]?7Y|^BS7H$/ && state != "HI") ||\
    (call ~ /^B[A-IY]?8[A-F]/ && state != "SC") ||\
    (call ~ /^B[A-IY]?8[G-L]/ && state != "CQ") ||\
    (call ~ /^B[A-IY]?8[M-R]/ && state != "GZ") ||\
    (call ~ /^B[A-IY]?8[S-Z]/ && state != "YN") ||\
    (call ~ /^B[A-IY]?9[A-F]/ && state != "SN") ||\
    (call ~ /^B[A-IY]?9[G-L]/ && state != "GS") ||\
    (call ~ /^B[A-IY]?9[M-R]/ && state != "NX") ||\
    (call ~ /^B[A-IY]?9[S-Z]/ && state != "QH") ||\
    (call ~ /^VR/ && state != "HK") ||\
    (call ~ /^XX9/ && state != "MO") ||\
    (call ~ /^B[M-X]/ && state != "TW"))
  {
    printf("Irregular Chinese call %s with exchange %s\n", call, state) > "/dev/stderr";
    return 1;
  }
  else
  {
    #printf("Predictable Chinese call %s with exchange %s\n", call, state) > "/dev/stderr";
    return 0;
  }   
}

