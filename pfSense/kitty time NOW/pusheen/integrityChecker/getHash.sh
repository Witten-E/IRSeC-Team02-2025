#!/bin/sh
# file path to the interpreter so it can run this script
# my first sh script ever :)


filePath=$1
# parameter for the function
# if you do ./getHash.sh argument1 , then argument1 is 
# $1, argument2 would be $2, and so on
    
# below line gets sha256 sum of the file and stores it
# the $() means bash runs the command inside the parentheses
# and captures its output. the command gets the output of
# sha256 sum and since it is words and not just the hash, 
 # I have to use awk to select/cut out only the 4th
# column of what was printed (which is where the print $4 
# comes from), which is just the hash
theHash=$(sha256 "$filePath" | awk '{print $4}')
#freeBSD and PfSense have sha256 preinstalled instead of
# sha256sum

printf "$theHash"
# cant use echo in sh, so instead I have to use printf,
# which is very similar but has some different options for printing
