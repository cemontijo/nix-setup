# .kshrc equivalent to .bashrc

# Source global definitions
if [ -f /etc/kshrc ]; then
	. /etc/kshrc
fi

set -o vi

# User specific aliases and functions
