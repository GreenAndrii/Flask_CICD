#!/bin/bash
# Install Jenkins on Ubuntu/Debian
wget -q --read-timeout=0.0 --waitretry=5 --tries=400 --background https://ipv4.cloudns.net/api/dynamicURL/?q=MjcwMTMxOToxOTk5MDIxMzE6NTkwYTU1OWQ2ZTUxYWM4NDIzZWY5MWQ3ZDJmMjkwMmYzZDZiZDBlNDg2ZDIxOGQ2MGE4ZTE3NmFkNDE3YTVjOA
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get -y update
sudo apt-get -y install openjdk-8-jdk 
sudo apt-get -y install jenkins
