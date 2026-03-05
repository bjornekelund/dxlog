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
