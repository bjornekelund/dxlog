function vecall(_call) 
{
    if (_call ~ /^((V[A-GOXY]|C[FG]|X[LM])[0-9])(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/[0-9]$|\/V[OYE][0-9]$/)
    {
        if (_call ~ /\//)
        {
            # printf("VE call %s\n", _call) > "/dev/stderr";
        }
        return 1;
    }
    else
    {
        if (_call ~ /^V/)
        {
            # printf("Non VE call %s\n", _call) > "/dev/stderr";
        }
        return 0;
    }
}

function notpredictableve13(_call1, _state1) 
{
    if (! vecall(_call1) || _state1 ~ /[A-Z]{3,5}/)
    {
        # printf("Non VE call %s with exchange %s\n", _call1, _state1) > "/dev/stderr";
        return 1;
    }
    else if ((_call1 ~ /^((V[A-GX]|C[FG])1)(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/1$|\/VE1$/ && _state1 != "NS") ||\
        (_call1 ~ /^(V[A-GX]|X[LM]|C[FG])2(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/2$|\/VE2$/ && _state1 != "QC") ||\
        (_call1 ~ /^(V[A-GX]|X[LM]|C[FG])3(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/3$|\/VE3$/ && _state1 != "ON") ||\
        (_call1 ~ /^(V[A-GX]|C[FG])4(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/4$|\/VE4$/ && _state1 != "MB") ||\
        (_call1 ~ /^(V[A-GX]|C[FG])5(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/5$|\/VE5$/ && _state1 != "SK") ||\
        (_call1 ~ /^(V[A-GX]|C[FG])6(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/6$|\/VE6$/ && _state1 != "AB") ||\
        (_call1 ~ /^(V[A-GX]|C[FG])7(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/7$|\/VE7$/ && _state1 != "BC") ||\
        (_call1 ~ /^(VE|C[FG])8(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/8$|\/VE8$/ && _state1 != "NT") ||\
        (_call1 ~ /^(V[CE]|C[FG])9(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/9$|\/VE9$/ && _state1 != "NB") ||\
        (_call1 ~ /^VO[12](\/|[^/]*$|.+\/[12MP]$)|\/VO[12]$/ && _state1 != "NL") ||\
        (_call1 ~ /^(VY|XO)0(\/|[^/]*$|.+\/[MP]$)|^(VY|XO).+\/0$|\/VY0$/ && _state1 != "NU") ||\
        (_call1 ~ /^(VY|XO)1(\/|[^/]*$|.+\/[MP]$)|^(VY|XO).+\/1$|\/VY1$/ && _state1 != "YT") ||\
        (_call1 ~ /^(VY|XO)2(\/|[^/]*$|.+\/[MP]$)|^(VY|XO).+\/2$|\/VY2$/ && _state1 != "PE"))
    {
        if (_state1 ~ /^[A-Z]{2}/)
        {
            printf("Irregular VE call %s with exchange %s\n", _call1, _state1) > "/dev/stderr";
        }
        return 1;
    }
    else
    {
        return 0;
    }
}

function notpredictableve11(_call1, _state1) 
{
    if (! vecall(_call1) || _state1 ~ /[A-Z]{3,5}/)
    {
        # printf("Non VE call %s with exchange %s\n", _call1, _state1) > "/dev/stderr";
        return 1;
    }
    else if ((_call1 ~ /^((V[A-GX]|C[FG])1)(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/1$|\/VE1$/ && _state1 != "NS") ||\
        (_call1 ~ /^(V[A-GX]|X[LM]|C[FG])2(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/2$|\/VE2$/ && _state1 != "QC") ||\
        (_call1 ~ /^(V[A-GX]|X[LM]|C[FG])3(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/3$|\/VE3$/ && _state1 != "ON") ||\
        (_call1 ~ /^(V[A-GX]|C[FG])4(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/4$|\/VE4$/ && _state1 != "MB") ||\
        (_call1 ~ /^(V[A-GX]|C[FG])5(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/5$|\/VE5$/ && _state1 != "SK") ||\
        (_call1 ~ /^(V[A-GX]|C[FG])6(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/6$|\/VE6$/ && _state1 != "AB") ||\
        (_call1 ~ /^(V[A-GX]|C[FG])7(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/7$|\/VE7$/ && _state1 != "BC") ||\
        (_call1 ~ /^(VE|C[FG])8(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/8$|\/VE8$/ && _state1 != "NT") ||\
        (_call1 ~ /^(V[CE]|C[FG])9(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/9$|\/VE9$/ && _state1 != "NB") ||\
        (_call1 ~ /^VO[12](\/|[^/]*$|.+\/[12MP]$)|\/VO[12]$/ && _state1 != "NL") ||\
        (_call1 ~ /^(VY|XO)0(\/|[^/]*$|.+\/[MP]$)|^(VY|XO).+\/0$|\/VY0$/ && _state1 != "NT") ||\
        (_call1 ~ /^(VY|XO)1(\/|[^/]*$|.+\/[MP]$)|^(VY|XO).+\/1$|\/VY1$/ && _state1 != "NT") ||\
        (_call1 ~ /^(VY|XO)2(\/|[^/]*$|.+\/[MP]$)|^(VY|XO).+\/2$|\/VY2$/ && _state1 != "PE"))
    {
        if (_state1 ~ /^[A-Z]{2}/)
        {
            printf("Irregular VE call %s with exchange %s\n", _call1, _state1) > "/dev/stderr";
        }
        return 1;
    }
    else
    {
        return 0;
    }
}

function notpredictableve14(_call2, _state2)
{
    if (! vecall(_call2) || _state2 ~ /[A-Z]{3,5}/)
    {
        # printf("Non VE call %s with exchange %s\n", _call2, _state2) > "/dev/stderr";
        return 1;
    }
    else if ((_call2 ~ /^((V[A-GX]|C[FG])1)(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/1$|\/VE1$/ && _state2 != "NS") ||\
        (_call2 ~ /^(V[A-GX]|X[LM]|C[FG])2(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/2$|\/VE2$/ && _state2 != "QC") ||\
        (_call2 ~ /^(V[A-GX]|X[LM]|C[FG])3(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/3$|\/VE3$/ && _state2 != "ON") ||\
        (_call2 ~ /^(V[A-GX]|C[FG])4(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/4$|\/VE4$/ && _state2 != "MB") ||\
        (_call2 ~ /^(V[A-GX]|C[FG])5(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/5$|\/VE5$/ && _state2 != "SK") ||\
        (_call2 ~ /^(V[A-GX]|C[FG])6(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/6$|\/VE6$/ && _state2 != "AB") ||\
        (_call2 ~ /^(V[A-GX]|C[FG])7(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/7$|\/VE7$/ && _state2 != "BC") ||\
        (_call2 ~ /^(VE|C[FG])8(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/8$|\/VE8$/ && _state2 != "NT") ||\
        (_call2 ~ /^(V[CE]|C[FG])9(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/9$|\/VE9$/ && _state2 != "NB") ||\
        (_call2 ~ /^VO1(\/|[^/]*$|.+\/[1MP]$)|\/VO1$/ && _state2 != "NF") ||\
        (_call2 ~ /^VO2(\/|[^/]*$|.+\/[2MP]$)|\/VO2$/ && _state2 != "LB") ||\
        (_call2 ~ /^(VY|XO)0(\/|[^/]*$|.+\/[MP]$)|^(VY|XO).+\/0$|\/VY0$/ && _state2 != "NU") ||\
        (_call2 ~ /^(VY|XO)1(\/|[^/]*$|.+\/[MP]$)|^(VY|XO).+\/1$|\/VY1$/ && _state2 != "YT") ||\
        (_call2 ~ /^(VY|XO)2(\/|[^/]*$|.+\/[MP]$)|^(VY|XO).+\/2$|\/VY2$/ && _state2 != "PE"))
    {
        if (_state2 ~ /^[A-Z]{2}/)
        {
            printf("Irregular VE call %s with exchange %s\n", _call2, _state2) > "/dev/stderr";
        }
        return 1;
    }
    else
    {
        return 0;
    }
}

function notpredictableqcqp(_call2, _state2)
{
    if (! vecall(_call2) || (_state2 ~ /[A-Z]{3,5}/ && _state2 != "NWT"))
    {
        # printf("Non VE call %s with exchange %s\n", _call2, _state2) > "/dev/stderr";
        return 1;
    }
    else if ((_call2 ~ /^((V[A-GX]|C[FG])1)(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/1$|\/VE1$/ && _state2 != "NS") ||\
        (_call2 ~ /^(V[A-GX]|X[LM]|C[FG])2(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/2$|\/VE2$/ && _state2 != "QC") ||\
        (_call2 ~ /^(V[A-GX]|X[LM]|C[FG])3(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/3$|\/VE3$/ && _state2 != "ON") ||\
        (_call2 ~ /^(V[A-GX]|C[FG])4(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/4$|\/VE4$/ && _state2 != "MB") ||\
        (_call2 ~ /^(V[A-GX]|C[FG])5(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/5$|\/VE5$/ && _state2 != "SK") ||\
        (_call2 ~ /^(V[A-GX]|C[FG])6(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/6$|\/VE6$/ && _state2 != "AB") ||\
        (_call2 ~ /^(V[A-GX]|C[FG])7(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/7$|\/VE7$/ && _state2 != "BC") ||\
        (_call2 ~ /^(VE|C[FG])8(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/8$|\/VE8$/ && _state2 != "NWT") ||\
        (_call2 ~ /^(V[CE]|C[FG])9(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/9$|\/VE9$/ && _state2 != "NB") ||\
        (_call2 ~ /^VO1(\/|[^/]*$|.+\/[1MP]$)|\/VO1$/ && _state2 != "NF") ||\
        (_call2 ~ /^VO2(\/|[^/]*$|.+\/[2MP]$)|\/VO2$/ && _state2 != "LB") ||\
        (_call2 ~ /^(VY|XO)0(\/|[^/]*$|.+\/[MP]$)|^(VY|XO).+\/0$|\/VY0$/ && _state2 != "NU") ||\
        (_call2 ~ /^(VY|XO)1(\/|[^/]*$|.+\/[MP]$)|^(VY|XO).+\/1$|\/VY1$/ && _state2 != "YT") ||\
        (_call2 ~ /^(VY|XO)2(\/|[^/]*$|.+\/[MP]$)|^(VY|XO).+\/2$|\/VY2$/ && _state2 != "PE"))
    {
        if (_state2 ~ /^[A-Z]{2}/)
        {
            printf("Irregular VE call %s with exchange %s\n", _call2, _state2) > "/dev/stderr";
        }
        return 1;
    }
    else
    {
        return 0;
    }
}

function notpredictablearrl10(_call2, _state2)
{
    if (! vecall(_call2) || _state2 ~ /[A-Z]{3,5}/)
    {
        # printf("Non VE call %s with exchange %s\n", _call2, _state2) > "/dev/stderr";
        return 1;
    }
    else if ((_call2 ~ /^((V[A-GX]|C[FG])1)(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/1$|\/VE1$/ && _state2 != "NS") ||\
        (_call2 ~ /^(V[A-GX]|X[LM]|C[FG])2(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/2$|\/VE2$/ && _state2 != "QC") ||\
        (_call2 ~ /^(V[A-GX]|X[LM]|C[FG])3(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/3$|\/VE3$/ && _state2 != "ON") ||\
        (_call2 ~ /^(V[A-GX]|C[FG])4(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/4$|\/VE4$/ && _state2 != "MB") ||\
        (_call2 ~ /^(V[A-GX]|C[FG])5(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/5$|\/VE5$/ && _state2 != "SK") ||\
        (_call2 ~ /^(V[A-GX]|C[FG])6(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/6$|\/VE6$/ && _state2 != "AB") ||\
        (_call2 ~ /^(V[A-GX]|C[FG])7(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/7$|\/VE7$/ && _state2 != "BC") ||\
        (_call2 ~ /^(VE|C[FG])8(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/8$|\/VE8$/ && _state2 != "NT") ||\
        (_call2 ~ /^(V[CE]|C[FG])9(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/9$|\/VE9$/ && _state2 != "NB") ||\
        (_call2 ~ /^VO1(\/|[^/]*$|.+\/[1MP]$)|\/VO1$/ && _state2 != "NF") ||\
        (_call2 ~ /^VO2(\/|[^/]*$|.+\/[2MP]$)|\/VO2$/ && _state2 != "LB") ||\
        (_call2 ~ /^(VY|XO)0(\/|[^/]*$|.+\/[MP]$)|^(VY|XO).+\/0$|\/VY0$/ && _state2 != "NT") ||\
        (_call2 ~ /^(VY|XO)1(\/|[^/]*$|.+\/[MP]$)|^(VY|XO).+\/1$|\/VY1$/ && _state2 != "NT") ||\
        (_call2 ~ /^(VY|XO)2(\/|[^/]*$|.+\/[MP]$)|^(VY|XO).+\/2$|\/VY2$/ && _state2 != "PE"))
    {
        if (_state2 ~ /^[A-Z]{2}/)
        {
            printf("Irregular VE call %s with exchange %s\n", _call2, _state2) > "/dev/stderr";
        }
        return 1;
    }
    else
    {
        return 0;
    }
}

function notpredictablerac(_call2, _state2)
{
    if (_call2 !~ /^(V[A-GOY]|C[FG]|X[LMO])|^(V[A-GOXY]|X[LMO]|C[FG]).+\/[0-9]$|\/V[OYE][0-9]$/)
    {
        return 1;
    }
    else if ((_call2 ~ /^((V[A-GX]|C[FG])1)(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/1$|\/VE1$/ && _state2 != "NS") ||\
        (_call2 ~ /^(V[A-GX]|X[LM]|C[FG])2(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/2$|\/VE2$/ && _state2 != "QC") ||\
        (_call2 ~ /^(V[A-GX]|X[LM]|C[FG])3(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/3$|\/VE3$/) ||\
        (_call2 ~ /^(V[A-GX]|C[FG])4(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/4$|\/VE4$/ && _state2 != "MB") ||\
        (_call2 ~ /^(V[A-GX]|C[FG])5(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/5$|\/VE5$/ && _state2 != "SK") ||\
        (_call2 ~ /^(V[A-GX]|C[FG])6(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/6$|\/VE6$/ && _state2 != "AB") ||\
        (_call2 ~ /^(V[A-GX]|C[FG])7(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/7$|\/VE7$/ && _state2 != "BC") ||\
        (_call2 ~ /^(VE|C[FG])8(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/8$|\/VE8$/ && _state2 != "TER") ||\
        (_call2 ~ /^(V[CE]|C[FG])9(\/|[^/]*$|.+\/[MP]$)|^(V[A-GX]|X[LM]|C[FG]).+\/9$|\/VE9$/ && _state2 != "NB") ||\
        (_call2 ~ /^VO1(\/|[^/]*$|.+\/[1MP]$)|\/VO1$/ && _state2 != "NL") ||\
        (_call2 ~ /^VO2(\/|[^/]*$|.+\/[2MP]$)|\/VO2$/ && _state2 != "NL") ||\
        (_call2 ~ /^(VY|XO)0(\/|[^/]*$|.+\/[MP]$)|^(VY|XO).+\/0$|\/VY0$/ && _state2 != "TER") ||\
        (_call2 ~ /^(VY|XO)1(\/|[^/]*$|.+\/[MP]$)|^(VY|XO).+\/1$|\/VY1$/ && _state2 != "TER") ||\
        (_call2 ~ /^(VY|XO)2(\/|[^/]*$|.+\/[MP]$)|^(VY|XO).+\/2$|\/VY2$/ && _state2 != "PE"))
    {
        if (_state2 ~ /^[A-Z]{2}/ && _state2 !~ /^(GH|ON[ENS])$/)
        {
            printf("Irregular VE call %s with exchange %s\n", _call2, _state2) > "/dev/stderr";
        }
        return 1;
    }
    else
    {
        return 0;
    }
}

function notpredictablewapc(_call3, _state3)
{
    if (_call3 !~ /^(B[A-Y]?|XX|VR)[0-9]{1,3}[A-Z]{1,4}$/)
    {
        printf("Not relevant call %s with exchange %s\n", _call3, _state3) > "/dev/stderr";
        return 1;
    }
    else if (\
        (_call3 ~ /^B[A-IY]?0[A-F]/ && _state3 != "XJ") ||\
        (_call3 ~ /^B[A-IY]?0[G-Z]/ && _state3 != "XZ") ||\
        (_call3 ~ /^B[A-IY]?1/ && _state3 != "BJ") ||\
        (_call3 ~ /^B[A-IY]?2[A-H]/ && _state3 != "HL") ||\
        (_call3 ~ /^B[A-IY]?2[I-P]/ && _state3 != "JL") ||\
        (_call3 ~ /^B[A-IY]?2[Q-Z]/ && _state3 != "LN") ||\
        (_call3 ~ /^B[A-IY]?3[A-F]/ && _state3 != "TJ") ||\
        (_call3 ~ /^B[A-IY]?3[G-J]/ && _state3 != "NM") ||\
        (_call3 ~ /^B[A-IY]?3[K-R]/ && _state3 != "HE") ||\
        (_call3 ~ /^B[A-IY]?3[S-Z]/ && _state3 != "SX") ||\
        (_call3 ~ /^B[A-IY]?4[A-H]/ && _state3 != "SH") ||\
        (_call3 ~ /^B[A-IY]?4[I-P]/ && _state3 != "SD") ||\
        (_call3 ~ /^B[A-IY]?4[Q-Z]/ && _state3 != "JS") ||\
        (_call3 ~ /^B[A-IY]?5[A-H]/ && _state3 != "ZJ") ||\
        (_call3 ~ /^B[A-IY]?5[I-P]/ && _state3 != "JX") ||\
        (_call3 ~ /^B[A-IY]?5[Q-Z]/ && _state3 != "FJ") ||\
        (_call3 ~ /^B[A-IY]?6[A-H]/ && _state3 != "AH") ||\
        (_call3 ~ /^B[A-IY]?6[A-H]/ && _state3 != "HN") ||\
        (_call3 ~ /^B[A-IY]?6[I-P]/ && _state3 != "HA") ||\
        (_call3 ~ /^B[A-IY]?6[Q-Z]/ && _state3 != "HB") ||\
        (_call3 ~ /^B[A-IY]?7[A-P]/ && _state3 != "GD") ||\
        (_call3 ~ /^B[A-IY]?7[Q-Z]/ && _state3 != "GX") ||\
        (_call3 ~ /^B[A-IY]?7Y|^BS7H/ && _state3 != "HI") ||\
        (_call3 ~ /^B[A-IY]?8[A-F]/ && _state3 != "SC") ||\
        (_call3 ~ /^B[A-IY]?8[G-L]/ && _state3 != "CQ") ||\
        (_call3 ~ /^B[A-IY]?8[M-R]/ && _state3 != "GZ") ||\
        (_call3 ~ /^B[A-IY]?8[S-Z]/ && _state3 != "YN") ||\
        (_call3 ~ /^B[A-IY]?9[A-F]/ && _state3 != "SN") ||\
        (_call3 ~ /^B[A-IY]?9[G-L]/ && _state3 != "GS") ||\
        (_call3 ~ /^B[A-IY]?9[M-R]/ && _state3 != "NX") ||\
        (_call3 ~ /^B[A-IY]?9[S-Z]/ && _state3 != "QH") ||\
        (_call3 ~ /^VR/ && _state3 != "HK") ||\
        (_call3 ~ /^XX9/ && _state3 != "MO") ||\
        (_call3 ~ /^B[M-X]/ && _state3 != "TW"))
    {
        printf("Irregular Chinese call %s with exchange %s\n", _call3, _state3) > "/dev/stderr";
        return 1;
    }
    else
    {
        #printf("Predictable Chinese call %s with exchange %s\n", _call3, _state3) > "/dev/stderr";
        return 0;
    }   
}

