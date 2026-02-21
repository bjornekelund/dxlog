#!/bin/bash
dos2unix -q $1
awk -f ve13check.awk $1

exit
