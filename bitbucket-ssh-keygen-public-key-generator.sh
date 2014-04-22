#!/bin/bash

#############################################################################################################################################################################
#
#       Author: Benny Wong
#       Setup ssh-keygen for Bitbucket
#
#############################################################################################################################################################################

echo "ssh-keygen for Bitbucket"


if [ ! -d ~/"$.ssh" ]; then
mkdir ~/.ssh 
fi

ssh-keygen

#Check if Host bitbucket.org exist already in .ssh/config
if ! grep "Host bitbucket.org" ~/.ssh/config; then

echo "Host bitbucket.org  
	IdentityFile ~/.ssh/id_rsa" >> ~/.ssh/config

chmod 600 ~/.ssh/config

fi

#Check if it exist already in .bashrc
if ! grep "start the ssh-agent" ~/.bashrc; then

echo -e "
SSH_ENV=\$HOME/.ssh/environment
   
# start the ssh-agent
function start_agent {
    echo \"Initializing new SSH agent...\"
    # spawn ssh-agent
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > \"\${SSH_ENV}\"
    echo succeeded
    chmod 600 \"\${SSH_ENV}\"
    . \"\${SSH_ENV}\" > /dev/null
    /usr/bin/ssh-add
}
   
if [ -f \"\${SSH_ENV}\" ]; then
     . \"\${SSH_ENV}\" > /dev/null
     ps -ef | grep \${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi" >> ~/.bashrc

fi

str='\nCopy and Paste the SSH Key "ssh-rsa" below to your bitbucket account\n'
echo -e "$str"

cat ~/.ssh/id_rsa.pub

printf '\nBitbucket URL to go to \nhttps://bitbucket.org/account/user/USERNAME/ssh-keys/\n'

printf '\nAfter adding the SSH key, exit the terminal, ssh back: ssh -T git@bitbucket.org to check connection\n\n'
