#!/bin/bash

# Check if running with root privileges
if [[ $(id -u) -ne 0 ]]; then
    echo "users.sh run fail"
    exit 1
fi

INPUT_FILE="/etc/passwd"

user_list=("fathertime" "chronos" "aion" "kairos" "merlin" "terminator" "mrpeabody" "jamescole" "docbrown" "professorparadox" "drwho" "martymcFly" "arthurdent" "sambeckett" "loki" "riphunter" "theflash" "tonystark" "drstrange" "bartallen")

# Read the input file line by line
while IFS=':' read -r username pass; do
    echo "~~~~~"
    # Trim any leading/trailing whitespace
    username=$(echo "$username" | tr -d '[:space:]')

    # Check if the user already exists
    if printf "%s\n" "${user_list[@]}" | grep -q -x -F -- "$username"; then
        echo "'$username' is approved."
        #add change password section here
    else
        # Remove the user and their home directory
        # --remove-home option for deluser removes the home directory
        # -r option for userdel also removes the home directory
        sudo deluser --remove-home "$username"
        
        if [ $? -eq 0 ]; then
            echo "User '$username' and their home directory successfully removed."
        else
            echo "Error removing user '$username'."
        fi
    fi
done < /etc/passwd