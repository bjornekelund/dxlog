#!/bin/bash
chmod -x */*.* */*/*.*
chmod +x */*.bash */*/*.bash
dos2unix -q */*.bash */*/*.bash
exit

