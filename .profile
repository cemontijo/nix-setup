# If ksh is your default shell, this file will run first.

# Environment file with customizations
export ENV=~/.kshrc

#Run Cleanup script before exiting server
alias exit='. ~/.bash_logout; exit'
alias quit='exit'

#Store ksh setup
alias > ~/.ksh_aliases
set > ~/.ksh_envvars
#chmod +x > ~/.ksh_aliases

# Activate conversion default setup
if [ -f /usr/local/conv/etc/env_setup.sh ]; then
	. /usr/local/conv/etc/env_setup.sh > /dev/null
fi

if [[ $- = *i* ]]; then
	echo "Running $SHELL"
	#SWITCH to bash instead
	bash
fi
