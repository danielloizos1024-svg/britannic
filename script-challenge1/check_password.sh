#!/bin/bash
# FILENAME: check_password.sh
#
# DESCRIPTION:
# 1. The script takes an md5 hash of /etc/password and stores it in /tmp/file-+%Y%m%d-%H%M%S
# 2. the file is compared with the one previously generated
# 3. when the files are the same, we are told, and when the files differ, were are told then too!
#
# USEAGE
# copy check_password.sh to a location of your choosing
# chmod +x check_password.sh 
# chown root:root check_password.sh 
#
# sudo crontab -e
# copy the crontab file (included) into it (keeping any other jobs, and not overwriting them). Modify the path in the crontab to reflect where you stored the check_password.sh file.
# Cron is set to run every 15 minutes. When /etc/passwd changes, /var/log/cron will show the mmessage "/etc/passwd changed".

clear

# log an md5 hash of /etc/password to a log file
md5sum /etc/passwd > /tmp/file-$(date +%Y%m%d-%H%M%S)

# choose the newest file's md5 hash
NEWEST=$(ls -ltr /tmp/file-* | tail -1 | awk '{ print $9 }' | cut -d"/" -f3)

# choose the penultimate file's md5 hash
PREVIOUS=$(ls -ltr /tmp/file-* | tail -2 | head -1 | awk '{ print $9 }' | cut -d"/" -f3)
printf "\n"


# compare files, and report a change
if [ "$(cat /tmp/$PREVIOUS)" ==  "$(cat /tmp/$NEWEST)" ];
then
	printf "/etc/passwd did not change since the last check.\n\n"
else
	printf "/etc/passwd changed.\n\n"
fi

