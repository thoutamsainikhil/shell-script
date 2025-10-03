#!/bin/bash

#check if the user running the acript is root user or not
# if root uder
# allow him
# elseshow error message and exit

# run th einstallation commands
# check if the installation was successful
# if successful
# show success message
# else
# show failure message

$USER_ID=$(id -u)
if[$USER_ID -ne 0]
then
  echo "ERROR: You must be root user to run this script"
  exit 1
fi

dnf list installed mysql
if [ $? -ne 0 ]
then
  dnf install mysql -y
  if [ $? -ne 0 ]
  then
    echo "ERROR: Installation failed"
    exit 1
  else
  echo "SUCCESS: Installation completed"
fi
else 
  echo "MySQL is already installed"
fi


dnf list installed git
if [ $? -ne 0 ]
then
  dnf install git -y
  if [ $? -ne 0 ]
  then
    echo "ERROR: Installation failed"
    exit 1
  else
    echo "SUCCESS: Installation completed"
  fi
else
  echo "Git is already installed"
fi