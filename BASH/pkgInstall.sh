#!/bin/bash

ACTION=$1
PNAME=$2
VERS=$3

installMaven ()
{
  wget http://www.mirrorservice.org/sites/ftp.apache.org/maven/maven-3/${VERS}/binaries/apache-maven-${VERS}-bin.tar.gz
  tar xzf apache-maven-${VERS}-bin.tar.gz
  mkdir -p /usr/local/maven
  mv apache-maven-${VERS}/ /usr/local/maven/
  alternatives --install /usr/bin/mvn mvn /usr/local/maven/apache-maven-${VERS}/bin/mvn 1
  alternatives --config mvn
}
removeMaven ()
{
  alternatives --remove ${PNAME} /usr/local/maven/apache-maven-${VERS}/bin/mvn
}
installAnt ()
{
  wget http://www.mirrorservice.org/sites/ftp.apache.org/ant/binaries/apache-ant-${VERS}-bin.tar.gz
  tar xzf apache-ant-${VERS}-bin.tar.gz
  mkdir -p /usr/local/ant
  alternatives --install /usr/bin/ant ant /usr/local/ant/apache-ant-${VERS}/bin/ant 1
  alternatives --config ant

}
removeAnt ()
{
  alternatives --remove ${PNAME} /usr/local/ant/apache-ant-${VERS}/bin/ant
}
show ()
{
  alternatives --display ${PNAME}
}
#MAIN
if [ "$#" -eq 0 ]; then
  echo "pkgInstall.sh"
  echo "SYNTAX"
  echo "********************************************"
  echo "$0 install mvn/ant version"
  echo "$0 remove mvn/ant version"
  echo "$0 show mvn/ant"
  echo "********************************************"
else
  if [[ "$ACTION" == "install" ]];
  then
    case "$PNAME" in
      maven ) installMaven;;
      ant ) installAnt;;
    esac
  elif [[ "$ACTION" == "remove" ]];
  then
    case "$PNAME" in
      mvn ) removeMaven;;
      ant ) removeAnt;;
    esac
  elif [[ "$ACTION" == "show" ]];
  then show
  fi
fi
