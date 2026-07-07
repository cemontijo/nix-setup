#WARNING: This file is ONLY for interactive shell; Do NOT run cmds that print output!

#Learning the Bash Shell, 3rd ed, p. 79:
#The only things that really need to be in .bash_profile are 
#environment variables and their exports and commands that aren't definitions 
#but actually run or produce output when you log in. 
#Option and alias definitions should go into the environment file.
trap "echo '$USER ($LOGNAME) logged out to $SHELL'" 0

# Source system global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

export SHELL=$(which bash)

#TODO: Create mv function that ALSO moves the vim backup file

##############################
# User specific vars
##############################
export CARLOS=$HOME
export DSKS=$CARLOS/develop/dsks
export JIL=$DSKS/jil
export DSNV=$CARLOS/develop/dsnv
export DSDE=$CARLOS/develop/dsde
export email=$(cat ~/.forward)

##############################
# Begin Conversion Stuff
##############################
#export templatedir=/usr/local/conv/gencode2/templates.DLH
export CONV=/usr/local/conv

alias dsks="cd $DSKS; cl"
alias dsnv="cd $DSNV; cl"
alias dsde="cd $DSDE; cl"

#mapping script shortcut
alias mapinfo=$(which gc_mapinfo.sh)

##############################
# Activate default conversion setup
##############################
if [ -f /usr/local/conv/etc/env_setup.sh ]; then
	. /usr/local/conv/etc/env_setup.sh 

	# MODIFY Default conversion setup:
	export EDITOR=vim
fi

##############################
# Modify Default Setup (CAUTION)
##############################
export TMOUT=0

##############################
# Vim Setup
##############################
#unsets initial vimrc config in env_setup.sh to use my ~/.vimrc file instead
unset VIMINIT

#One of the most useful features of the Korn shell is command-line editing.  
#This feature allows you to access your command history list 
#with vi commands as if it were a text file. For this feature to be available, 
#the EDITOR shell variable must be set to vi.
export VISUAL=$(which vim)

#Activate personal .vimrc when logged in as group user
export MYVIMRC=$CARLOS/.vimrc
export runvim=$(which vim)
vim()
{
	$runvim -u $MYVIMRC "$@"
}
alias vir="vim -R -i NONE"

##############################
# $PATH
##############################
# NOTE: '.' is added to $PATH for compatibility reasons only. This
#       default will be changed in a future release. If "." is not
#       needed for compatibility it is better to omit this line. 
#	Please edit .profile according to your site requirements.

# Set up the search paths:
PATH=$PATH:$HOME/bin
PATH=$PATH:$HOME/.vim/bundle/vim-superman/bin

# Add to your ~/.bashrc to get tab completion
complete -o default -o nospace -F _man vman

# RUN EXECUTABLES IN '.' FIRST:
PATH=.:$PATH
export PATH=$(cleanpath)

##############################
# Shell Option settings
##############################
# shopt -o to display
set -o allexport
set -o notify
set -o ignoreeof
set +o noclobber    
set -o nounset       
set -o vi

shopt -u force_fignore
shopt -u checkwinsize
shopt -s extglob #Bash provides a further set of pattern matching operators if the shopt option extglob is switched on.
shopt -s cdspell
shopt -s dirspell
shopt -s autocd
shopt -s failglob
shopt -s histappend
shopt -s hostcomplete
shopt -s promptvars
shopt -s shift_verbose
shopt -s sourcepath
shopt -s checkjobs
shopt -u huponexit
shopt -s execfail
shopt -s globstar
shopt -s histverify
shopt -s checkhash
shopt -s cdable_vars


# Default user .profile file (/usr/bin/sh initialization).
export TERM=linux
export COLUMNS=500

if [[ $- = *i* ]]; then
	# Set up the terminal:
	if [ "$TERM" = "" ]
	then
		eval ` tset -s -Q -m ':?hp' `
	else
		eval ` tset -s -Q `
	fi
	stty erase "^H" kill "^U" intr "^C" eof "^D"
	stty werase "^W" quit "^\\" susp "^Z" rprnt "^R"
	stty hupcl ixon ixoff
fi

##############################
# Interactive Shell Functions
##############################
ses()
{
	se CHANGE_STATUS -s SUCCESS -j $1
}
gitb()
{
	git branch -va
}
gits()
{
	git status
}
gitd()
{
	git diff
}
gitp()
{
	git push
}
gitrv()
{
	git remote -v
}
gitbu()
{
	git branch --set-upstream-to=origin/master master
}
timef()
{
	/usr/bin/time -f "Command: %C\nElapsed Time = %E\nUser %U\nSys %S\nCPU %P, Inputs %I, Outputs %O" "$@"
}
alias time="$(which time)"

grepdrop()
{
	# grep DROP TABLES to delete changed product tables
	grep 'DROP TABLE' "$@"
}

aim()
{
	cat $AIM_CONFIG
}
setaim() 
{ 
	#Sets AIM_PSWD to input PSWD
	export AIM_PSWD=$(grep -w ${1}_PSWD $AIM_CONFIG|awk -F= 'NR == 1{print $2}');
}
chgaim() 
{ 
	export AIM_CONFIG=~/.aim.cfg
	echo $AIM_CONFIG
}
mypath()
{ 
	#list $PATH vertically
	echo $PATH | tr ':' '\n'
	#alias mypath="echo $PATH | awk 'split(\$0, arr, \":\"){for(i=1; i<=length(arr); i++) print arr[i]}'"
}
sortpath()
{
	mypath | sort
}
myps()
{
	#alias myps="ps -ef | grep $ME"
	#alias myps="ps -efl | head -1; ps -efl | grep $ME"
	ps -eaf | grep -E "$USER|PID" | sort -nk5
}
f()
{
	if [ "$#" = 0 ]; then
		finger
	elif [ -n "$*" ]; then
		finger "$@"
		#GET USER NAME
		typeset -u choice
		USER_NAME=$(finger "$@" | awk '/Name/' | awk '{print $4}')
		USER_NAME=$(echo "$USER_NAME")
		echo " "
		echo "Do you want to navigate to $USER_NAME's directory? (Y/N)"
		read choice
		if [ "$choice" = "Y" ]; then
			USER_DIR=$(finger "$@" | awk /'Directory'/ | awk '{print $2}' | head -1)
			cd "$USER_DIR"
		else
			echo "OK!"		
		fi
	fi
}
cdl()
{
	cd "$@" && ls -l
}
alias cd="cdl"

##############################
# ALIASES
##############################
alias cl="clear; ls -l"
alias cd1="cd .."
alias cd2="cd ../.."
alias cd3="cd ../../.."
alias cd4="cd ../../../.."
alias cd5="cd ../../../../.."
alias binsql='binsql -p -w -l 30 -d $CONVDIR/source_files/data/AIM -o $CONVDIR/source_files/outs/AIM'
alias speedtest='curl -o /dev/null http://speedtest.wdc01.softlayer.com/downloads/test10.zip'
alias ls='ls -CF --color --time-style="+%F %T"'
alias l="ls -lh"
alias ll="ls -la"
alias lt="ls -ltr"
alias l.="ls -ld .*"
alias grep="grep --color"
alias lmgd="l $DSKS/mgd* -d"

#Permissions
alias open="umask 007"
alias shut="umask 037"

#List my repo files w/o group write perm
alias lsharerepo="find $REPOSDIR -user $USER ! -perm -020 -exec ls -ld {} \;"

#Add group write perm to my repo files
alias sharerepo="find $REPOSDIR -user $USER ! -perm -020 -exec chmod g+w {} \;"

alias noshare="find . -user $USER ! -exec chmod go-w {} \;"
alias lmine="find . -user $USER -exec ls -ldh {} \;"

# convenient aliases, system specific
alias rehash='hash -r'
alias hexdump='hexdump -C'
alias pd="bash pushd"
alias pd2="pd +2"

alias more="less -e"
export PAGER='less -e'

#####################################
# Customize shell prompts
#####################################
export PS1='\n$(if [[ $? = "0" ]]; then echo "\[\033[32m\]"; else echo "\[\033[31m\]"; fi)[\#]-(\!)-(\j)-(\D{%a %m/%d/%Y %r %Z})\[\e[0m\]
\[\033[0;33m\][\h][\u{$(contexthelper)}:\w]\[\033[0m\]
$(ls -1 | wc -l) files
\$ '
export PROMPT_COMMAND='echo -ne "\033]0;$(hostname)(${USER}@$(contexthelper)):$(pwd)\007"'
export PS2='> ' 
export PS3='#? '
export PS4='+ ' 

#####################################
# Autosys / otto
#####################################
alias myotto='. $HOME/bin/my_otto'

#####################################
# Interactive shell output
# Autosys compatible for interactive shells
#####################################
export INTERACTIVE=no
if [[ $- = *i* ]]; then
	export INTERACTIVE=yes

	#Safer/verbose removing, moving, copying
	alias rm="rm -iv"
	alias mv="mv -iv"
	alias cp="cp -iv"

	echo "Running $SHELL"

	echo ""
	echo '$PATH AFTER env_setup.sh: '$PATH
	echo ""
	echo '$HISTFILE:'$HISTFILE
	echo ""
	date

	# mailcheck to detect file/dir changes
	export MAILCHECK=0
	export MAILPATH=$MAIL?"You've got mail!":$HOME?"File in $HOME changed!":$DSKS?"File in $DSKS changed!":$REPOSDIR?"File in $REPOSDIR changed!"

	# If multiple directories have same name,
	# cd into local directory first, otherwise 1st directory found in CDPATH
	# NOTE: '..' also finds parallel directories, e.g., src, sysin, bin
	export CDPATH=".:$HOME/develop:$HOME/develop/$CUST:$CONVSHR:$CONVDIR:.."

	svccheck

	echo
	echo "TFAL Jobs:"
	tfaljilchk

fi