#/bin/bash
cd $(dirname $0)
FILE=`ls Call* 2> /dev/null`
echo FILE=\"$FILE\"
dos2unix $FILE
gawk '
BEGIN {
  FS=","
  printf("# BCC members (%s)\n", strftime("%Y-%m-%d"));
}
{
  call = toupper($1)
  if (call ~ /^[0-9,A-Z,\/]+$/) {
    printf("%s %s\n", call, $3);
  }
  else {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }  
}
END { 
}' $FILE > BCC.xdt
unix2dos BCC.xdt
