#!/bin/bash

USER_ID=$(id -u)

RED="\e[31m"
GREEN="\e[32m"
Normal="\e[0m"

SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14}

LOGS_FOLDER="/home/ec2-user/shellscript-logs"
mkdir -p $LOGS_FOLDER 
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

USAGE(){
    echo -e "$RED USAGE:: $Normal sh 16-jsr-backup.sh <SOURCE_DIR> <DEST_DIR> <DAYS(optional)>"
exit 1
}

mkdir -p /home/ec2-user/shell-script-logs/

if [ $# -lt 2 ]
then
  USAGE
    
fi

if [ ! -d $SOURCE_DIR ]
then
  echo -e "$RED ERROR: Source directory $SOURCE_DIR does not exist$Normal"
  exit 1
fi

if [ ! -d $DEST_DIR ]
then
  echo -e "$RED ERROR: Destination directory $DEST_DIR does not exist$Normal"
  exit 1
fi

echo "Script started executing at : $TIMESTAMP" &>>$LOG_FILE_NAME