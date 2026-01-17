#!/bin/bash
FILE=`ls ../eudxc/EU_DXC* | tail -1 2> /dev/null`
OUTFILE=URC_EU.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk 'BEGIN {
  FS = ",";
  printf("!!Order!!,Call,Name,Exch1,UserText,\n");
}
{
  switch ($2)
  {
    case "SE01":
        ter = "SHM";
        break;
    case "SE02":
    case "SE03":
    case "SE04":
    case "SE18":
        ter = "ESW";
        break;
    case "SE05":
    case "SE06":
    case "SE07":
    case "SE09":
    case "SE10":
        ter = "SSW";
        break;
    case "SE08":
        ter = "GTL";
        break;
    case "SE11":
    case "SE12":
        ter = "SWS";
        break;
    case "SE13":
    case "SE14":
    case "SE16":
        ter = "WSW";
        break;
    case "SE15":
    case "SE17":
    case "SE19":
        ter = "MSW";
        break;
    case "SE20":
    case "SE21":
        ter = "NSN";
        break;
    case "DK01": ter = "CHG"; break;
    case "DK02": ter = "CJU"; break;
    case "DK03": ter = "NJU"; break;
    case "DK04": ter = "ZEL"; break;
    case "DK05": ter = "SDM"; break;

    case "FI01": ter = "LAP"; break;
    case "FI19": ter = "ALD"; break;

    case "IE01":
    case "IE02":
    case "IE03":
    case "IE04": ter = "IRL"; break;

    case "EE01":
    case "EE02":
    case "EE03":
    case "EE04": ter = "EST"; break;

    case "HR01":
    case "HR02":
    case "HR03":
    case "HR04":
    case "HR05": ter = "CRT"; break;

    case "AT01": ter = "VNA"; break;
    case "AT02": ter = "SZG"; break;
    case "AT03": ter = "LAU"; break;
    case "AT04": ter = "BGL"; break;
    case "AT05": ter = "UAU"; break;
    case "AT06": ter = "STR"; break;
    case "AT07": ter = "TRL"; break;
    case "AT08": ter = "CTA"; break;
    case "AT09": ter = "VBG"; break;

    case "BE02": ter = "WLN"; break;
 
    case "BE03": ter = "FDS"; break;
    case "BE10": ter = "FDS"; break;
    case "BE11": ter = "FDS"; break;
 
    case "CY01":
    case "CY02":
    case "CY03":
    case "CY04":
    case "CY05": ter = "CYP"; break;

    case "CZ01": ter = "MOR"; break;
    case "CZ02": ter = "BHE"; break;
    case "CZ03": ter = "MOR"; break;
    case "CZ04": ter = "BHE"; break;
    case "CZ05": ter = "BHE"; break;
    case "CZ06": ter = "BHE"; break;
    case "CZ07": ter = "MOR"; break;
    case "CZ08": ter = "MOR"; break;
    case "CZ09": ter = "BHE"; break;
    case "CZ10": ter = "BHE"; break;
    case "CZ11": ter = "BHE"; break;
    case "CZ12": ter = "BHE"; break;
    case "CZ13": ter = "MOR"; break;
    case "CZ14": ter = "MOR"; break;

    case "ES01": ter = "ADL"; break;
    case "ES02": ter = "CTL"; break;
    case "ES03": ter = "MRD"; break;
    case "ES04": ter = "VCA"; break;
    case "ES05": ter = "GLC"; break;
    case "ES06": ter = "CSL"; break;
    case "ES07": ter = "BSQ"; break;
    case "ES08": ter = "CLM"; break;
    case "ES09": ter = "LPM"; break;
    case "ES10": ter = "MCI"; break;
    case "ES11": ter = "AGN"; break;
    case "ES12": ter = "EXM"; break;
    case "ES13": ter = "BRC"; break;
    case "ES14": ter = "AST"; break;
    case "ES15": ter = "NVR"; break;
    case "ES16": ter = "CRA"; break;
    case "ES17": ter = "LRJ"; break;
    case "ES18": ter = "CEU"; break;
    case "ES19": ter = "MLA"; break;
    default:
#        printf("Bad entry: %s\n", $0) > "/dev/stderr";
        ter = "";
        break;
  }
  if (ter != "") printf("%s,,%s,\n", $1, ter);
}' $FILE | sort | sed 's/^#./#/g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
