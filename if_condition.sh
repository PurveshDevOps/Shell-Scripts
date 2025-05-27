#!/bin/bash


<<info
this scripts shows the IF CONDITION statement
info


read -p "Enter the gabbar's dialogue: " gb

read -p "Enter the thakur's dialogue: " th

read -p "Kitne aadmi the rey saambha: " aadmi

echo "$gb"
echo "$th"
echo "total aadmi: $aadmi"


if [[ $th == "nahi"   ]];
then
        echo "Jay Veeru ki entry aur bhasad machaa"
elif [[ $aadmi -ge 3  ]];
then
        echo "Jay Mahaaaaarashtraaaaa.....!"
else
        echo "Khaach khaach khaach......!!"
fi

echo "Bhojpuri Sholay khatam"
