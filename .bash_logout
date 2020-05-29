# ~/.bash_logout

#cleantmp.sh
# Description: Removes personal files/dirs from temp dirs
#!/bin/bash

USER=$(whoami)
unalias cd

cd /tmp

echo
printf "You own the following files/directories in /tmp:\n"
#find . -user $USER -exec du -hc {} \; 2>/dev/null
find . -user $USER -exec ls -ldh {} \; 2>/dev/null

#printf "\nRemoving your files from /tmp..."
#find . -type f -user $USER -exec /bin/rm {} \; 2>/dev/null
#find . -type d -user $USER -exec /bin/rmdir {} \; 2>/dev/null

#cd /tmpsort
#printf "\nYou own the following files/directories in /tmpsort:"
#find . -user $USER -exec ls -ldh {} \; 2>/dev/null
##find . -user $USER -exec du -hc {} \; 2>/dev/null
#
#printf "\nRemoving your files from /tmpsort..."
#find . -type f -user $USER -exec /bin/rm {} \; 2>/dev/null
#find . -type d -user $USER -exec /bin/rmdir {} \; 2>/dev/null
#printf""

#cd /tmp
#printf "\n\nNow you own the following files/directories in /tmp:\n"
#find . -user $USER -exec ls -ldh {} \; 2>/dev/null

#cd /tmpsort
#printf "\nNow you own the following files/directories in /tmpsort:"
#find . -user $USER -exec ls -ldh {} \; 2>/dev/null

echo
du -sh /tmp

echo
df /tmp

sleep 4
