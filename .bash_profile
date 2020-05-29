# NOTE: this ONLY runs if bash is your default shell
# .bash_profile

# User specific environment and startup programs
export PATH=$PATH:$HOME/bin

##############################
# Activate default conversion setup
##############################
if [ -f ~/env_setup.sh ]; then
	. ~/env_setup.sh 
fi

###############################
# Global shell functions
###############################
# /usr/local/conv/opt/shell_functions/shell_functions.module
#
# Description: Extends the bash shell with convenient
#              functions
if [[ $- = *i* ]]; then
	echo "Setting shell environment"
fi

bashmyrc()
{
	bash --init-file /home/$LOGNAME/.bashrc
}

cleanpath() 
{ 
	# clean up the PATH
	#PATH=$(echo $PATH | awk -v RS=: '{ if (!arr[$0]++) {printf("%s%s",!ln++?"":":",$0)}}')
	echo -n $PATH | awk -v RS=: '{ if (!arr[$0]++) {printf("%s%s",!ln++?"":":",$0)}}'
}

llogs ()
{
	ls -ltr $LOGSDIR/* -d
}

contexthelper ()
{
	case "$CONVDIR" in
		"/conv/convdird")  echo "DEID";;
		"/conv/convdirm")  echo "MASK";;
		"/conv2/convdirp") echo "PHI";;
		"/conv/convdirs")  echo "SNAP";;
		"/conv/convdirt")  echo "TFAL";;
		"/conv2/convdirc") echo "CLM";;
		*) echo "UNDEF";;
	esac
}

mkhelper ()
{
	set +f
	mkhelper_ls=`which --skip-alias ls`
	#
	# expect 0, 1, or 2 arguments
	# 
	case "${#}" in
		0 )
			#
			# classic make. if there's only one .mak file run it
			#
			mkhelper_file="*.mak"
			mkhelper_tgt=""
			;;
		1 )
			#
			# argument can be either a target or a make file
			# the make file shouldn't also be the name of a target
			# 
			mkhelper_file=`$mkhelper_ls ${1} 2>/dev/null | grep ".mak"`
			mkhelper_tgt=""
			if [ "$mkhelper_file" = "" ] ; then
				mkhelper_file="*.mak"
				mkhelper_tgt=${1}
			fi
			;;
		2 )
			mkhelper_file=`$mkhelper_ls ${1} 2>/dev/null | grep ".mak"`
			mkhelper_tgt=${2}
			;;
		* )
			echo Too many arguments
			mkhelper_file=""
			;;
	esac

	if [ "$mkhelper_file" != "" ] ; then
		makcount=`$mkhelper_ls $mkhelper_file 2>/dev/null | wc -w`
		if [ $makcount -eq 0 ] ; then
			mkhelper_file="makefile"
			makcount=`$mkhelper_ls $mkhelper_file 2>/dev/null | wc -w`
		fi
		if [ $makcount -eq 0 ] ; then
			mkhelper_file="Makefile"
			makcount=`$mkhelper_ls $mkhelper_file 2>/dev/null | wc -w`
		fi
		if [ $makcount -eq 0 ] ; then
			echo '  No makefile'
		else
			if [ $makcount -eq 1 ] ; then
				gmake -f $mkhelper_file $mkhelper_tgt
			else
				echo '  Ambiguous makefile'
				echo '    '`$mkhelper_ls -m $mkhelper_file`
			fi
		fi
	fi
}
alias mk="set -f ; mkhelper"

###############################
# Get the aliases and functions
###############################
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi
#if [ -f ~/.bashrc_default ]; then
#	. ~/.bashrc_default
#fi
