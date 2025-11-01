#!/bin/sh

set +e

script_dir=$(dirname "$0")
# I have to save dirname (explnanation of what it is 
# below) as a variable apparently because I am not 
# allowed to put that inside of the curly braces, 
# I have to assign its output into another variable
# and then use it from there instead


fileList="${script_dir}/importantFiles.txt"
# dirname "$0" is the current filepath to this sh file.
# I need to use this instead of just putting the file name
# because it will resolve the issues I got before where
# the files couldn't be found even though I typed in the
# absolute file path correctly.

currentTime=$(date +"%H-%M-%S")
# do not remove space between first quote and +. it looks
# awful but it HAS to be there apparently.

saveLocation="${script_dir}/hashes_${currentTime}.txt"
# since this script is meant to make a separate file with all
# the hashes every time it runs, the file names have to be 
# different, which is why the time is used as a title.
# this was only intended to be used over the course of one day 
# but if I use this again over the course of multiple days 
# I will use the day, month, or year as well

echo "creating new hash file: ${saveLocation}"

# loop through each line in the importantFiles.txt list of 
# file paths to get the hashes of and adds them to the 
# new file of hashes so the lists can eventually be compared.
# IFS is the internal field separator and splits the file 
# into individual words/chunks at every blank space,
# the -r means it does not interpret every backslash as an 
# escape character, since there are sometimes backslashes in
# file paths and if that happened then they wouldnt be read 
# correctly without the -r.
while IFS= read -r filePath
do
    # this checks if the file path actually exists, since I 
    # kept getting errors that the paths were wrong
    if [ -e "$filePath" ]; then

        # gets the hash of the file using sha256, -q means only 
        # output the hash and none of the regular extra text
        fileHash=$(sha256 -q "$filePath")

        # writes a single line to the new hash file
        echo "${filePath} | ${fileHash}" >> "${saveLocation}"

        # prints confirmation that the file was hashed successfully
        echo "Successfully hashed ${filePath} :)"

    else
    
        # if the file does not exist, still record it in the 
        # hash file as missing just so its easy to see which 
        # files were and were not hashed for troubleshooting
        echo "${filePath} | file not found :(" >> "${saveLocation}"

        # warns the user so they know which files were skipped
        echo "file not found: ${filePath}"
    
    fi # ends the if statement, stop forgetting to put these lol

done < "$fileList"
# this part ends the current ireration of the loop and
# gives the instruction to return to the while condition
# and cycle to the next line from $fileList to begin the next
# iteration

echo "initialHashFile.sh is done running :)"
echo "all hashes have been saved to ${saveLocation}"

# upon completion: there should be a new .txt file in this 
# script's same directory with a title matching the time
# it was made, and it should contain a list of hashes and 
# the filepaths of each file that was hashed or the names
# of the ones that returned an error