#
BEGIN {
  FS = " ";
  count = 0;
}
{
  printf("| '''%s'''\n", $1);
  printf("|\n");
  printf("|\n");
  printf("|-\n");
}

