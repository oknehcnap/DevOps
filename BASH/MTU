#!/bin/bash

INTERFACE=$1
HOST=$2
SCRIPT_NAME=$0
if [[ -z ${INTERFACE} && -z ${HOST} || $# -ne 2 ]];
  then
    echo "Syntax error."
    echo "==============================================================="
    echo "${SCRIPT_NAME} INTERFACE HOST_ADRESS "
    echo "==============================================================="
    exit 1
else
    echo "Calculating MTU. Please, wait..."
    MTU=$(ifconfig "${INTERFACE}" | grep -i -o "mtu:[0-9]*" | cut -d: -f2)
    while true
      do
      ping -W 0.3 -c 1 -M do -s "${MTU}" "${HOST}"  > /dev/null 2>&1
      OUT=$?
      if [ "$OUT" -eq 1 ]
        then
          let "MTU--"
        continue
      elif [ "$OUT" -eq 0 ]
       then
        echo "MTU = ${MTU}+IP Header (28 bytes)."
        break
      else
        break
      fi
    done
fi
exit 0
