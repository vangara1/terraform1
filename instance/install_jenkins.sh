#!/bin/bash

source components/common.sh
MSPACE=$(cat $0 | grep Print | awk -F '"' '{print $2}' | awk '{ print length }' | sort | tail -1)

Print "Update"
sudo yum update -y &>>$LOG
Stat $?

Print "Download "
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo &>>$LOG
Stat $?

Print "import"
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key &>>$LOG
Stat $?

Print "Update"
sudo yum update -y &>>$LOG
Stat $?

Print "install"
sudo yum install jenkins java-1.8.0-openjdk-devel -y&>>$LOG
Stat $?

Print "reload"
sudo systemctl daemon-reload &>>$LOG
Stat $?

Print "start"
sudo systemctl start jenkins && sudo systemctl status jenkins &>>$LOG
Stat $?
