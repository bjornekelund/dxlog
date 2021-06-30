#/bin/bash
cd $(dirname $0)
FILE=`ls AC* 2> /dev/null`
echo FILE=\"$FILE\"
dos2unix $FILE
gawk '
BEGIN {
  FS=","
  printf("# Members of International Radio Club ARKTIKA\n");
  printf("# Data provided by Oleg RA9JM\n");
  printf("# File created %s\n", strftime("%Y-%m-%d"));
}
{
  call = toupper($1)
  number = toupper($2)
  if (call ~ /^[0-9,A-Z,\/]+$/ && number ~ /^AC[0-9]+$/) {
    printf("%s=%s\n", call, number);
  }
  else {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }  
}
END { 
}' $FILE > POLAR-radioman.txt
unix2dos POLAR-radioman.txt
