dos2unix webclip.txt
gawk '
BEGIN {
  FS=","
  max = 0;
  printf("#TITLE FOC Members\n", max);
}
{
  mem = substr($0,1,4);
  gsub(/ /, "", mem);
  call = substr($0,8,6);
  gsub(/ /, "", call);
  name = substr($0,15,20);
  gsub(/  /, " ", name);
  gsub(/  /, " ", name);
  gsub(/  /, " ", name);
  gsub(/  /, " ", name);
  gsub(/  /, " ", name);
  gsub(/  /, " ", name);
  gsub(/ $/, "", name);
  printf("%s %s #%s\n", call, name, mem);
  if (strtonum(mem) > max) max = strtonum(mem);
}
END {}' webclip.txt > FOC.xdt
unix2dos FOC.xdt
