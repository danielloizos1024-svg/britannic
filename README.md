# britannic
Scripting Challenges

Thanks for accepting my application, Included in this repo are files for 

1. Scripting Challenge1.

The script takes an md5 hash of /etc/password and stores it in /tmp/file-+%Y%m%d-%H%M%S. The file is compared with the one previously generated. Wen the files are the same, we are told, and when the files differ, we are told then too!

## Usage
```
copy check_password.sh to a location of your choosing
chmod +x check_password.sh 
chown root:root check_password.sh 
```

sudo crontab -e
Copy the crontab file (included) into it (keeping any other jobs, and not overwriting them). Modify the path in the crontab to reflect where you stored the check_password.sh file. Cron is set to run every 15 minutes. When /etc/passwd changes, /var/log/cron will show the mmessage "/etc/passwd changed".


2. Scripting Challenge2.
I ran out of time, and did not manage to get this far.
With more time, I would hav investigated "docker events" and written something like

```
docker events | grep <container>
```

