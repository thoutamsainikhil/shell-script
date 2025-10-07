#!/bin/bash

USER_ID=$(id -u)

RED="\e[31m"
GREEN="\e[32m"
Normal="\e[0m"

SOURCE_DIR="/home/ec2-user/app-log"
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


FILES_TO_DELETE=$(find $SOURCE_DIR -name "*.log" -mtime +14)

echo "Files to be deleted : $FILES_TO_DELETE"

while read -r file

do 

echo "Deleting file : $file" &>>$LOG_FILE_NAME
rm -rf $file &>>$LOG_FILE_NAME
done <<< $FILES_TO_DELETE



