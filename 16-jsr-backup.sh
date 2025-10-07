#!/bin/bash


RED="\e[31m"
GREEN="\e[32m"
Normal="\e[0m"

SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14}

LOGS_FOLDER="-logs"
LOG_FILE=$(echo $0 | awk -F "/" '{print $NF}' | cut -d "." -f1)
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE_NAME="$LOGS_FOLDER/$LOG_FILE-$TIMESTAMP.log"


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

FILES=$(find $SOURCE_DIR -name "*.log" -mtime +$DAYS)

if [ -n "$FILES" ] #true if there are files to zip
then
echo "Files to be backed up : $FILES"
ZIP_FILE="$DEST_DIR/app-logs-$TIMESTAMP.zip"
find $SOURCE_DIR -name "*.log" -mtime +$DAYS | zip -@ "$ZIP_FILE"

if [ -f "$ZIP_FILE" ]
then
echo -e "$GREEN Success:: $Normal ZIP file created older then $DAYS days"

while read -r filepath

do 

echo "Deleting file : $filepath"
rm -rf $filepath
done <<< $FILES


else
echo -e "$RED Error:: $Normal Failed to create ZIP file"
exit 1
fi

else
echo "No files older then $DAYS"
fi