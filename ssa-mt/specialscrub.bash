#/bin/sh
awk '
BEGIN {
  FS = "=";
}
{
  if ($2!="Fail") print $0;
}' utfil.txt | sort | uniq > _specialqrzscrub.txt
