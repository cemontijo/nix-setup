if [ -z "${BASEDIR}" ]; then export BASEDIR=..; fi
if [ -z "${DATADIR}" ]; then export DATADIR=../data; fi
if [ -z "${LOGSDIR}" ]; then export LOGSDIR=../logs; fi
if [ -z "${OUTSDIR}" ]; then export OUTSDIR=../outs; fi
if [ -z "${RPTDIR}" ];  then export RPTDIR=../rpt; fi
if [ -z "${SQLDIR}" ];  then export SQLDIR=../sql; fi
if [ -z "${SRCDIR}" ];  then export SRCDIR=../bin; fi
if [ -z "${SYNPATH}" ]; then export SYNPATH=../sysin; fi

export TMPDIR=/tmp
export CONVSHR=/conv/share

# Set up the built-in shell variables:
export HISTTIMEFORMAT="%m/%d/%Y %r %Z: "
export HISTEDIT=$(which vim)
export HISTFILE=~/.${LOGNAME}_history
export HISTFILESIZE=9999
export HISTSIZE=9999
export HISTCONTROL=""

# ksh command line editor
export EDITOR=vi

export USER="$(whoami)"
export LOGNAME="$(logname)"

# Database NLS Vars
#export LC_ALL=C.utf8 
export LC_ALL="C"
export LANG="C.utf8"
export NLS_LANG="American_America.AL32UTF8"

config_path=/usr/local/conv/etc/enabled-modules
for entry in "$config_path"/*
do
	if [ -r "$entry" ] ; then
		source "$entry"
	fi
done

# the items below all require that CONVDIR be set.  Make sure it is set before running these commands
if [ -n "${CONVDIR}" ]; then

	if [ "${SRCPATH:-xxx}" = "xxx" ]; then 
		echo "setting SRCPATH";
		export SRCPATH=../bin:/usr/local/conv/bin
	else
		echo "updating SRCPATH";
		#SRCPATH=$CONVDIR/job:/usr/local/conv/job:$SRCPATH;
		export SRCPATH=/usr/local/conv/bin:$SRCPATH
	fi

	# Set up the search paths:
	export PATH=/usr/local/conv/bin:$PATH:../bin:.

	export LD_LIBRARY_PATH=$CONVSHR/lib:/usr/local/conv/lib:$LD_LIBRARY_PATH

	export VIMINIT='source /usr/local/conv/etc/vimrc'

fi

# Set up a umask that will allow others in the group to freely access directories
umask 0002

#interactive shell
if [[ $- = *i* ]]; then

	alias ls='ls -CF --color'

	#safer removing, moving, copying
	alias rm="rm -i"
	alias mv="mv -i"
	alias cp="cp -i"

	echo
	echo "CONVERSION environment variables"
	echo "=================================================="
	echo "CONVDIR=$CONVDIR"
	echo "CONVSHR=$CONVSHR"
	echo "DATADIR=$DATADIR"
	echo "LOGSDIR=$LOGSDIR"
	echo "OUTSDIR=$OUTSDIR"
	echo "RPTDIR=$RPTDIR"
	echo "SQLDIR=$SQLDIR"
	echo "SRCDIR=$SRCDIR"
	echo "SCHEMAPATH=$SCHEMAPATH"
	echo "SYNPATH=$SYNPATH"
	echo "AIM_CONFIG=$AIM_CONFIG"
	echo "MAILRC=$MAILRC"
	echo "=================================================="
	echo ""
	echo "To switch between de-identified and PHI data contexts type 'go_d' or 'go_p'"
	echo "The de-identified context is the default upon login."
fi
