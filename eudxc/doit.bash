#!/bin/bash
dos2unix $1
sort < $1 > temp
gawk '
BEGIN {
  FS=",";
  prevcall = "zz";
}
{
  call = $1;
  reg = $2;
  notignore = (call ~ /[0-9,A-Z]{3}/) && (reg ~ /^[A-Z]{2}[0-9]{2}$/) && !(call ~ /[A-Z][0-9]{2}/)
  if (substr($0,1,1) == "#")
    printf("%s\n", $0);
  else if (notignore && call != prevcall)
    printf("%s=%s\n", call, reg);
 else
    printf("%s %s\n", call == prevcall ? "Dupe   :" : "Ignored:", $0) > "/dev/stderr";
  prevcall = call;
}
END { 
}' < temp > EUDXC_db.txt
rm temp
echo "EUDXC_db.txt created"
unix2dos EUDXC_db.txt
exit
