#!/bin/bash


<<info
This script will install the package that you pass the arguments.

eg: ./install_package.sh nginx
./install_package.sh docker.io
./install_package.sh unzip
info


echo "Installing $1"

sudo apt-get update > /dev/null
sudo apt-get upgrade > /dev/null
sudo apt-get install $1 -y > /dev/null

sudo systemctl start $1
sudo systemctl enable $1

echo "Installed $1"
