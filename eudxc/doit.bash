#!/bin/bash
dos2unix -q $1
sort < $1 > temp
gawk '
BEGIN {
  FS=",";
  prevcall = "zz";
}
{
  call = $1;
  reg = toupper($2);
  lineok = call ~ /[0-9,A-Z]{3,}/ && reg ~ /^[A-Z]{2}[0-9]{2}$/
  if (substr($0,1,1) == "#")
    printf("%s\n", $0);
  else if (lineok && call != prevcall)
    printf("%s=%s\n", call, reg);
 else
    printf("%s %s\n", call == prevcall ? "Dupe   :" : "Ignored:", $0) > "/dev/stderr";
  prevcall = call;
}
END { 
}' < temp > EUDXC_db.txt
rm temp
echo "EUDXC_db.txt created"
unix2dos -q EUDXC_db.txt
exit
