#!/bin/bash

echo "All variables passed: $@"
echo "Total number of variables passed: $#"
echo "First variable: $1"
echo "Second variable: $2"
echo "Third variable: $3"
echo "Script name: $0"
echo "which user executed the script: $USER"
echo "Home directory of the user: $HOME"
echo "Current working directory: $PWD"
echo "Process ID of current script: $$"
echo "Exit status of last command: $?"  # 0 means success, non-zero means failure
sleep 60 &  # Sleep for 60 seconds in the background
echo "Last background command's PID: $!"  # PID of last background command