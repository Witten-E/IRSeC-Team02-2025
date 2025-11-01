#!/bin/sh



script_dir=$(dirname "$0") 

file_list="${script_dir}/../integrityChecker/importantFiles.txt"
# uses the importantFiles.txt, same file as the integrityChecker


# storeBackups takes 1 argument which is the 
# path to the directory you want to create the new
# directory in that stores all the backups. It cant
# run without this user input so this next part
# checks if it recieved an argument/parameter and if 
# not, the script stops running
if [ $# -lt 1 ]; then
    echo "You cant run this without specifying a location"
    exit 1
fi

backupLocation="$1"

timestamp=$(date +"%H-%M-%S")
backupDirectory="${backupLocation}/kitty time (${timestamp})"
mkdir "$backupDirectory"
# creates the backup directory at the designated file 
# path/location, and the directory is named "kitty time " 
# plus the timestamp at the end to make sure each 
# directory created is unqiue

# uses IFS again to split up file and loop through it for
# each line, and -r flag to disable backslash as esc char
while IFS= read -r filePath; do

    #checks if the file path exists
    if [ -e "$filePath" ]; then
        cp "$filePath" "$backupDirectory/"
        echo "successfully backed up $filePath :]"

    else
        echo "file not found: $filePath :["

    fi

done < "$file_list"

echo "backup complete!!!"









