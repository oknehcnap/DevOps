#!/bin/bash

HOST=$1
SCRIPT_NAME=$0
touch log.txt
if [[ -z ${HOST} ]];
  then
    echo "Syntax error."
    echo "==============================================================="
    echo "${SCRIPT_NAME} HOST_ADRESS "
    echo "==============================================================="
    exit 1
else
  echo "Pinging ${HOST}, please wait..."
  for i in range {100..1000..100}
    do
    ping -f -l ${i} -s 1024 -q ${HOST} > log.txt 2>/dev/null
    echo "For packet size ${i} Loss is $(grep -e "[[:digit:]]*% packet loss" log.txt | cut -d ' ' -f6)"
    done
fi
rm log.txt
exit 0
