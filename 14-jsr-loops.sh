#!/bin/bash

USER_ID=$(id -u)

RED="\e[31m"
GREEN="\e[33m"
Normal="\e[0m"

LOGS_FOLDER="/var/log/shellscript-logs"
LOG_FILE=$(echo $0 | cut -d "." -f1)
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE_NAME="$LOGS_FOLDER/$LOG_FILE-$TIMESTAMP.log"

VALIDATE(){
      if [ $? -ne 0 ]
  then
    echo -e "$RED ERROR: Installation failed$Normal"
    exit 1
  else
  echo -e "$GREEN SUCCESS: Installation completed$Normal"
  fi
}

echo "Script started executing at : $TIMESTAMP" &>>$LOG_FILE_NAME


if [ $USER_ID -ne 0 ]
then
  echo -e "$RED ERROR: You must be root user to run this script"
  exit 1
fi

for package in $@
do
  dnf list installed $package &>>$LOG_FILE_NAME
  if [ $? -ne 0 ]
  then
    dnf install $package -y &>>$LOG_FILE_NAME    
    VALIDATE $? 
  else 
    echo -e "$GREEN $package is already installed"
  fi
done




# for i in {1..1000}
# do
#   echo $i
# done
