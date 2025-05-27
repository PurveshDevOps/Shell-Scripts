#!/bin/bash

<<info
this script defines how to enter
user manually
info

username = $1
password = $2

echo "***************Creating User*******************"
read -p "Enter the Username: $username" username
read -p"Enter the Password: $password" password
sudo useradd -m "$username"
sudo passwd "$username"
echo "$username"
echo "$password"
echo "***************User Created*******************"
