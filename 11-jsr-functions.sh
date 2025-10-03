#!/bin/bash

USER_ID=$(id -u)

VALIDATE(){
      if [ $? -ne 0 ]
  then
    echo "ERROR: Installation failed"
    exit 1
  else
  echo "SUCCESS: Installation completed"
  fi
}



if [ $USER_ID -ne 0 ]
then
  echo "ERROR: You must be root user to run this script"
  exit 1
fi

dnf list installed mysql
if [ $? -ne 0 ]
then
  dnf install mysql -y
  VALIDATE $? 
else 
  echo "MySQL is already installed"
fi


dnf list installed git
if [ $? -ne 0 ]
then
  dnf install git -y
    VALIDATE $?
else
  echo "Git is already installed"
fi

