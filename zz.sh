#!/bin/bash
chmod -x *.md */*.* */*/*.*
chmod +x *.sh */*.sh */*/*.sh
dos2unix -q *.sh */*.sh */*/*.sh
dos2unix -q *.awk */*.awk */*/*.awk
exit
