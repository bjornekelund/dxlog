#!/bin/bash
chmod -x */*.* */*/*.*
chmod +x *.bash */*.bash */*/*.bash
dos2unix -q *.bash */*.bash */*/*.bash
exit

