#!/bin/bash
NO_KEYS=1
WRONG_IP=2
WRONG_INTR=3
#ERROR CODES
SCRIPT_NAME=$0
INTERFACE=$1
IP=$2
echo "Static IP Setter."
if [[ -z ${INTERFACE} && -z ${IP} ]];
  then
    echo "Script can't be executed without keys. Please, use the following template. "
    echo "Syntax: ${SCRIPT_NAME} INTERFACE IP_ADDRESS MASK"
    exit ${NO_KEYS}
  elif [[ ${IP} =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]];
    then
      ifconfig ${INTERFACE} > /dev/null 2>&1
      EXIT_CODE=$?
      if [ "$EXIT_CODE" -eq 1 ];
        then
          echo "There is no such interface. ${INTERFACE}"
          exit ${WRONG_INTR}
        else
          ifdown ${INTERFACE}
          echo "=================================================="
          ifconfig ${INTERFACE} ${IP}
          ifup ${INTERFACE}
          ifconfig ${INTERFACE}
          echo "=================================================="
      fi
  else
    echo "It seems that IP you have entered ${IP} is wrong."
    exit ${WRONG_IP}
fi
