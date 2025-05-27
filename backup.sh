#!/bin/bash


<<info
this scripts takes backup of any destination path given in argument
info

function show_date {
        echo "Today is: $(date '+%d-%m-%Y_%H-%M-%S')"
}

function create_function {

timestamp=$(date '+%d-%m-%Y_%H-%M-%S')

backup_dir="/home/ubuntu/backup1/${timestamp}_backup1.zip"

zip -r $backup_dir $1

echo "Backup Complete"

}

show_date
