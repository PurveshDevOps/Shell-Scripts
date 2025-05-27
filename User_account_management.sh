#!/bin/bash

# This script manages user accounts on the system

# Function to display usage information
# This also tells the user how to use the script

show_help() {
    echo "How to use: $0 [OPTION]"
    echo "Options: "
    echo "  -c, or --create    Create a new user account"
    echo "  -d, or --delete    Delete an existing user account"
    echo "  -r, or --reset     Reset the password of an existing user account"
    echo "  -l, or --list      List all user accounts with their User IDs (UID)"
    echo "  -h, or --help      Display this help message"
    exit 1
}

# Function to check if a user already exists
# Returns 0 if the user exists, 1 if the user does not exist

check_user() {
    username=$1
    if id "$username" >/dev/null 2>&1;
    then
        return 0 # User exists
    else
        return 1 # User does not exist
    fi
}

# Function to create a new user account
# Prompts for a username and password, then creates the user

create_user() {
    echo "Enter a new username: "
    read -p username:
    # Check if the username already exists
    if check_user "$username"; then
        echo "Error: $username already exists! Please choose a different username."
        exit 1
    fi
    echo "Enter a password:"
    read -s password
    echo
    # Create the user and set the password using openssl for encryption
    sudo useradd -m -p "$(echo $password | openssl passwd -1 -stdin)" "$username"
    if [ $? -eq 0 ]; then
        echo "Success: '$username' has been created!"
    else
        echo "Error: Failed to create '$username'"
        exit 1
    fi
}

# Function to delete an existing user account
# Prompts for the username and deletes the user

delete_user() {
    echo "Enter the username to delete:"
    read username
    # Check if the username exists
    if ! check_user "$username"; then
        echo "Error: '$username' does not exist!"
        exit 1
    fi
    # Delete the user and their home directory
    sudo userdel -r "$username"
    if [ $? -eq 0 ]; then
        echo "Success: '$username' has been deleted!"
    else
        echo "Error: Failed to delete '$username'."
        exit 1
    fi
}

# Function to reset the password of an existing user account
# Prompts for the username and new password

reset_password() {
    echo "Enter the username to reset the password for:"
    read username
    # Check if the username exists
    if ! check_user "$username"; then
        echo "Error: '$username' does not exist!"
        exit 1
    fi
    echo "Enter the new password:"
    read -s password
    echo
    # Reset the password using chpasswd
    echo "$username:$password" | sudo chpasswd
    if [ $? -eq 0 ]; then
        echo "Success: Password for '$username' has been reset!"
    else
        echo "Error: Failed to reset the password for '$username'."
        exit 1
    fi
}

# Function to list all user accounts with their User IDs (UID)
# Reads from /etc/passwd and displays usernames and UIDs

list_users() {
    echo "List of user accounts on the system:"
    echo "-----------------------------------"
    while read -r line; do
        username=$(echo "$line" | cut -d: -f1)
        uid=$(echo "$line" | cut -d: -f3)
        # Show only regular users (UID >= 1000) or root (UID 0)
        if [ "$uid" -ge 1000 ] || [ "$uid" -eq 0 ]; then
            echo "Username: $username, UID: $uid"
        fi
    done < /etc/passwd
}

# If no option is provided, show the help message

if [ $# -eq 0 ]; then
    show_help
fi

# Check the command-line option and call the function

case "$1" in
    -c|--create)
        create_user
        ;;
    -d|--delete)
        delete_user
        ;;
    -r|--reset)
        reset_password
        ;;
    -l|--list)
        list_users
        ;;
    -h|--help)
        show_help
        ;;
    *)
        echo "Error: '$1' is an invalid option!"
        show_help
        ;;
esac

exit 0

~
