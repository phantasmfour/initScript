#!/bin/bash
# Bash init for Ubuntu Linux Systems. Can tweak to work for other OS that you use.
# Must be run as sudo since we are editting the root crontab

if [ "$EUID" -ne 0 ]  # Check if you are running as sudo/root
  then echo "Please run as sudo/root"
  exit
fi

# Setting Crontab for root user for updates
echo "Setting crontab for root user..."
crontab -l > crontab_new > /dev/null  # Put old crontab in file. Don't warn if the user had no crontab
echo "0 0 * * FRI apt-get update && apt-get upgrade -y" >> crontab_new  # Simple upgrade on fridays
crontab crontab_new
rm crontab_new

# Bash RC Formatting
echo "Setting bashrc for $SUDO_User..."
echo 'export PS1="[\[\e[32m\]\h\[\e[m\]@\[\e[32m\]\u\[\e[m\] \[\e[34m\]\t\[\e[m\]]\[\e[36m\]:\[\e[m\]\\$\[\e[37m\]\W\[\e[m\]' >> /home/$SUDO_USER/.bashrc
source /home/$SUDO_USER/.bashrc

