#!/bin/bash
awk '{} END {
for (i = 10; i < 100; i++)
  printf("%s=%s\n", i, i);
}' < /dev/null > numbers.txt
unix2dos numbers.txt

