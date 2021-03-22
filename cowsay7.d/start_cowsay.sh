#! /bin/bash

count=0
timeout=20

WAITFILE_SENTENCE="I don't know what to say..."
BAILOUT_SENTENCE="Too late. See you next time!"
# Do not forget to copy this sentences.log file into the container!
FNAME="/root/sentences.log"
# Takinga short break before changing the content
SLEEP="6"
# The docker volume should be mounted to the folder below (e.g., -  “myvolume:/root/html”)

NGINX_FILE="/root/html/index.html"

function leave_some_space {
	echo
	echo
	echo
}
# Wait for the file to be copied in the right location
while [[ ! -f $FNAME && "$count" -lt "$timeout" ]];
do
	cowsay $WAITFILE_SENTENCE
	sleep $SLEEP
	count=$((count+$SLEEP))
done
# If the file is not there after the timeout, bail out
if [ "$count" -eq "$timeout" ];
then
	leave_some_space
	cowsay $BAILOUT_SENTENCE
	exit 0
fi
# If I have the file, read it line by line and cowsay
while read -r line
do
	leave_some_space
	cowsay $line > $NGINX_FILE
	sleep $SLEEP
done < $FNAME
