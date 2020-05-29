#WARNING: This file is ONLY for interactive shell; Do NOT run cmds that print output!

#Learning the Bash Shell, 3rd ed, p. 79:
#The only things that really need to be in .bash_profile are 
#environment variables and their exports and commands that aren't definitions 
#but actually run or produce output when you log in. 
#Option and alias definitions should go into the environment file.
trap "echo '$USER ($LOGNAME) logged out to $SHELL'" 0

# Source system global definitions
if [ -f /etc/bashrc ]; then
	df /etc
	. /etc/bashrc
fi

export SHELL=$(which bash)

##############################
# User specific vars
##############################
#export CARLOS=/home/montijo
export CARLOS=~
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
alias mapinfo=$(which gc_mapinfo.sh 2>/dev/null)

##############################
# Activate default conversion setup
##############################
if [ -f /usr/local/conv/etc/env_setup.sh ]; then
	. /usr/local/conv/etc/env_setup.sh 

	# MODIFY Default conversion setup:

	#export TMPDIR=/tmp
	#export CONVSHR=/conv/share

	## Set up the built-in shell variables:
	#export HISTTIMEFORMAT="%m/%d/%Y %r %Z: "
	#export HISTEDIT=$(which vim)
	#export HISTFILE=~/.${LOGNAME}_history
	#export HISTFILESIZE=9999
	#export HISTSIZE=9999
	#export HISTCONTROL=""

	## ksh command line editor
	#export EDITOR=vi

	#export USER=$(whoami)
	#export LOGNAME=$(logname)

	# Set up the search paths:
	#export PATH=/usr/local/conv/bin:$PATH:../bin:.
	#export LD_LIBRARY_PATH=$CONVSHR/lib:/usr/local/conv/lib:$LD_LIBRARY_PATH
	#export VIMINIT='source /usr/local/conv/etc/vimrc'

	# Set up a umask that will allow others in the group to freely access directories
	#umask 0002

	#interactive shell
	#if [[ $- = *i* ]]; then

	#	alias ls='ls -CF --color'

	#	#Safer removing, moving, copying
	#	alias rm="rm -i"
	#	alias mv="mv -i"
	#	alias cp="cp -i"
	#fi
fi

##############################
# Modify Default Setup (CAUTION)
##############################
#export CONTEXT="$(echo ${CONVDIR: -1} | tr 'a-z' 'A-z')"
#export SYNPATH=../sysin:$SYNPATH
export TMOUT=0
#unalias ls

# Set up where to look for terminfo files
#export TERMINFO=$HOME/bin/terminfo

#alias su='/opt/utils/5bin/su -'
#alias su='sudo su -'

#alias ls='ls -CF --color=auto'

MAIL=${MAIL:-xxx}
REPOSDIR=${MAIL:-xxx}
CUST=${CUST:-xxx}

##############################
# Vim Setup
##############################
#make vi refer to vanilla vi
#unalias vi

#unsets initial vimrc config in env_setup.sh to use my ~/.vimrc file instead
unset VIMINIT

#One of the most useful features of the Korn shell is command-line editing.  
#This feature allows you to access your command history list 
#with vi commands as if it were a text file. For this feature to be available, 
#the EDITOR shell variable must be set to vi.
export VISUAL=$(which vim)
#export EDITOR="$VISUAL"

#Activate personal .vimrc when logged in as group user
#export VIMRUNTIME=/usr/local/share/vim/vim74/
export MYVIMRC=$CARLOS/.vimrc
export runvim=$(which vim)
vim()
{
	$runvim -u $MYVIMRC $@
}
#alias vim="vim -i NONE"
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
#set -o interactive      on
#set -o emacs            off
#set -o gmacs            off
#set -o markdirs         off
#set -o noglob           off

shopt -u force_fignore
shopt -u checkwinsize #Checks the window size after each command and, if it has changed, updates the variables LINES and COLUMNS accordingly.

#shopt -s extdebug
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

# Set up the built-in shell variables:
#export LANG=en_US

# Default user .profile file (/usr/bin/sh initialization).
#export TERM=linux
#export TERM=xterm # Windows

#if [[ $- = *i* ]]; then
#	# @(#)B.11.31_LR       
#	# Set up the terminal:
#	if [ "$TERM" = "" ]
#	then
#		eval ` tset -s -Q -m ':?hp' `
#	else
#		eval ` tset -s -Q `
#	fi
#	#tabs
#	#stty >/dev/null
#	#if [[ $? -eq 0 ]];then
#	stty erase "^H" kill "^U" intr "^C" eof "^D"
#	stty werase "^W" quit "^\\" susp "^Z" rprnt "^R"
#	stty hupcl ixon ixoff
#fi

##############################
# Interactive Shell Functions
##############################
ses()
{
	se CHANGE_STATUS -s SUCCESS -j $1
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
build()
{
	if [ $# = 1 ]; then
		progname=$1
	else
		progname=$(basename $PWD)
	fi
	#wget --user=$LOGNAME http://$GITEA_HOST:$GITEA_PORT/jenkins/job/$progname/build?token=TOKEN
	curl -u $LOGNAME "http://$GITEA_HOST:$GITEA_PORT/jenkins/job/$progname/build?token=TOKEN"

	#GOGS_SERVER=`hostname -I | tr -d " "`
}
timef()
{
	/usr/bin/time -f "Command: %C\nElapsed Time = %E\nUser %U\nSys %S\nCPU %P, Inputs %I, Outputs %O" $@
}
alias time="$(which time 2>/dev/null)"

grepdrop()
{
	# grep DROP TABLES to delete changed product tables
	grep 'DROP TABLE' $@
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
	ps -eaf | grep -E '$USER|PID' | sort -nk5
}
f()
{
	if [ "$#" = 0 ]; then
		finger
	elif [ ! -z "$@" ]; then
		finger "$@"
		#GET USER NAME
		typeset -u choice
		#USER_NAME=$(finger "$@" | awk '/life/' | awk -F : '{print $3}' | head -1)
		USER_NAME=$(finger "$@" | awk '/Name/' | awk '{print $4}')
		USER_NAME=$(echo $USER_NAME)
		echo " "
		echo "Do you want to navigate to $USER_NAME's directory? (Y/N)"
		read choice
		if [ $choice = "Y" ]; then
			USER_DIR=$(finger "$@" | awk /'Directory'/ | awk '{print $2}' | head -1)
			cd $USER_DIR
		else
			echo "OK!"		
		fi
	fi
}
cdl()
{
	cd "$@" && ls -l
	#List files after cd 
	#if [ "$#" = 0 ]; then
	#	cd ~ && ls -ltr 
	#elif [ -d "$@" ]; then
	#	cd "$@" && ls -ltr  
	##else		 
	##	echo "$@" directory not found!!!
	#fi
}
alias cd="cdl"

##############################
# ALIASES
##############################
alias cl="clear; l -rt"
alias cd1="cd .."
alias cd2="cd ../.."
alias cd3="cd ../../.."
alias cd4="cd ../../../.."
alias cd5="cd ../../../../.."
alias binsql='. set_binsql_outsdir; binsql -p -w -l 30 $BINSQL_OUTSDIR'
alias speedtest='curl -o /dev/null http://speedtest.wdc01.softlayer.com/downloads/test10.zip'
alias l="ls -l"
alias ll="ls -la"
alias lt="ls -ltr"
alias l.="ls -ld .*"
alias grep="grep --color"

#Permisssions
alias open="umask 007"
alias shut="umask 037"

#List my repo files w/o group write perm
alias lsharerepo="find $REPOSDIR -user $USER ! -perm -020 -exec ls -ld {} \;"

#Add group write perm to my repo files
alias sharerepo="find $REPOSDIR -user $USER ! -perm -020 -exec chmod g+w {} \;"

alias noshare="find . -user $USER ! -exec chmod go-w {} \;"
alias lmine="find . -user $USER -exec ls -ldh {} \;"

# convenient aliases, system specific
#alias hdiff='hdiff.pl -n -w132 -t3 -d d30a00 -a 1ca100'
#alias hdiff="hdiff.pl" 
#alias gunzip='gzip -d'
alias rehash='hash -r'
alias hexdump='hexdump -C'
alias pd="bash pushd"
alias pd2="pd +2"

alias more="less -e"
export PAGER='less -e'

#alias cdar="set -f ; cdxhelper archive"
#alias cdbn="set -f ; cdxhelper bin"
#alias cdtl="set -f ; cdxhelper tools"
#alias cdc="set -f ; cdxhelper cnv"
#alias cdd="set -f ; cdxhelper $CUST"
#alias cds="set -f ; cdxhelper snag"
#alias cdx="set -f ; cdxhelper exp"
#alias cdb="set -f ; cdxhelper mbr"
#alias cdg="set -f ; cdxhelper mgd"
#alias cdp="set -f ; cdxhelper prv"
#alias cdt="set -f ; cdxhelper tpl"
#alias ddd="set -f ; cdxhelper data"
#alias ddb="set -f ; cdxhelper dmbr"
#alias ddg="set -f ; cdxhelper dmgd"
#alias ddp="set -f ; cdxhelper dprv"
#alias ddt="set -f ; cdxhelper dtpl"

#foreground colors (30-37)
alias myblack='echo "\033[30m"'
alias myred='echo "\033[31m"'
alias mygreen='echo "\033[32m"'
alias mybrown='echo "\033[33m"'
alias myblue='echo "\033[34m"'
alias mypurple='echo "\033[35m"'
alias mycyan='echo "\033[36m"'
alias myltgray='echo "\033[37m"'
#bg colors (40-47)
alias myblackbg='echo "\033[40m"'
alias myredbg='echo "\033[41m"'
alias mygreenbg='echo "\033[42m"'
alias mybrownbg='echo "\033[43m"'
alias mybluebg='echo "\033[44m"'
alias mypurplebg='echo "\033[45m"'
alias mycyanbg='echo "\033[46m"'
alias myltgraybg='echo "\033[47m"'

alias mynon='echo "\033[m"'
alias mycolors='echo "30=black; 31=red; 32=green; 33=brown; 34=blue; 35=purple; 36=cyan; 37=ltgray; see mybg"'
alias mybg='echo "40=black; 41=red; 42=green; 43=brown; 44=blue; 45=purple; 46=cyan; 47=ltgray; non=no number"'

#####################################
# Customize shell prompts
#####################################
#$(ls -1 | wc -l) files $(du -hs 2>/dev/null | cut -f1)
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
alias myotto='. /home/montijo/bin/my_otto'

#export OTTOSRC=$OTTOBIN/../src
#export OTTODIR=$HOME/.otto
#export OTTOCFG=$OTTODIR/ottocfg.txt
#export OTTOLOG=$OTTODIR/log
#export OTTODB=$OTTODIR/ottodb.dat

# Define personal RUNID for use by Autosys Jobs - 
#CAUTION - rename this to 'TST' after use to prevent overwriting results!!
#export LDTGT=DEVC
#export LDTGTH=HISC
#export RUNID=DEVC1
#export DB_PSWD=CONV_PSWD
#export CUSTDB="KSCUST2"

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
	#y      Allow write access to your terminal.
	#n      Disallow write access to your terminal.
	#mesg y

	#UNIX
	#echo "\033[36m"
	#banner "Hola,"
	#banner "$LOGNAME!"
	#echo "\033[m"  

	#echo '$CONVDIR orginally set to:'$CONVDIR
	echo ""
	echo '$PATH AFTER env_setup.sh: '$PATH
	echo ""
	echo '$HISTFILE:'$HISTFILE
	echo ""
	date

	#from #Check email UNIX
	# mailcheck to detect file/dir changes
	export MAILCHECK=0
	export MAILPATH=$MAIL?"You've got mail!":$HOME?"File in $HOME changed!":$DSKS?"File in $DSKS changed!":$REPOSDIR?"File in $REPOSDIR changed!"

	# If multiple directories have same name,
	# cd into local directory first, otherwise 1st directory found in CDPATH
	# NOTE: '..' also finds parallel directories, e.g., src, sysin, bin
	export CDPATH=".:$HOME/develop:$HOME/develop/$CUST:$CONVSHR:$CONVDIR:.."

	#ottocheck
	svccheck 2>/dev/null
	#if [ -f $HOME/bin/wintitle ]; then
	#	$HOME/bin/wintitle "$CUST"
	#fi
	## Run bash
	#bash
	#if [ $? -eq 0 ]; then
	#	exit
	#fi

	#shopt
	tfaljilchk 2>/dev/null
fi 
