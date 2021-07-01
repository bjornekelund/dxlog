#bin/bash
gawk '
BEGIN {
  FS=","
  max = 0;
}
{
  if (substr($1, 1, 1) ~ /#/) {
	printf("%s\n", $0);
  }
  else if (substr($1, 1, 1) ~ /[0-9,A-Z]/ && $2 != "") {
  	printf("%s=%s\n", $1, $2);
  }
}
END { 
}' $1 > EA_db.txt
echo "EA_db.txt created"
unix2dos EA_db.txt
exit
