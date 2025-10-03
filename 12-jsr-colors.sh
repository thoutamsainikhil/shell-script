#!/bin/bash

USER_ID=$(id -u)

RED="\e[31m"
GREEN="\e[32m"

VALIDATE(){
      if [ $? -ne 0 ]
  then
    echo -e "$RED ERROR: Installation failed"
    exit 1
  else
  echo -e "$GREEN SUCCESS: Installation completed"
  fi
}



if [ $USER_ID -ne 0 ]
then
  echo -e "$RED ERROR: You must be root user to run this script"
  exit 1
fi

dnf list installed mysql
if [ $? -ne 0 ]
then
  dnf install mysql -y
  VALIDATE $? 
else 
  echo -e "$GREEN MySQL is already installed"
fi


dnf list installed git
if [ $? -ne 0 ]
then
  dnf install git -y
    VALIDATE $?
else
  echo -e "$GREEN Git is already installed"
fi

