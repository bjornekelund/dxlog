#!/bin/bash
chmod -x *.md */*.* */*/*.*
chmod +x *.bash */*.bash */*/*.bash
dos2unix -q *.bash */*.bash */*/*.bash
dos2unix -q *.awk */*.awk */*/*.awk
exit
