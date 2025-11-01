#!/bin/sh

script_dir=$(dirname "$0")

file_list="${script_dir}/../integrityChecker/importantFiles.txt"
# see storeBackups.sh for a full explanation of a lot of
# this code, since most of it is the same.


if [ $# -lt 1 ]; then
    echo "You can't run this without specifying the backup directory"
    exit 1
fi

backupDirectory="$1"


while IFS= read -r filePath; do

    filename=$(basename "$filePath")

    backupFile="${backupDirectory}/${filename}"
    if [ -e "$backupFile" ]; then
        cp "$backupFile" "$filePath"
        # I did not know this but apparently if you
        # cp a file to a filepath that already exists
        # and there is a file with that same name, it 
        # just gets overwritten with the new file.
        echo "successfully restored $filePath :]"

    else
        echo "backup file not found for $filePath :["

    fi

done < "$file_list"

echo "restoration complete!!!"
