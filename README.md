# home-setup
Linux/Unix setup, config, and customization files for bash, vim, ksh, etc.

## SETUP/INSTALLATION:
To setup and use, move all desired files to your $HOME directory.


## Bash setup: 
This setup assumes the default login shell is ksh. After logging in with ksh, it will run an interactive bash shell. 

When you exit the server, the shell (ksh/bash) will run .bash_logout

.bashrc uses functions that are defined in .bash_profile


## Vim setup: 
This includes a customized .vimrc file that uses the plugins in .gitmodules.

Uses the Vundle plugin manager with several plugins already installed (see .gitmodules). Plugins can be managed and turned off easily with Vundle.

~~NOTE: I removed the .git directories from the plugins so the entire repo can be downloaded and work "out of the box"~~

NOTE: The documap plugin comes from Damian Conway's Vim Setup (https://github.com/thoughtstream/Damian-Conway-s-Vim-Setup), which is why it's symlinked.
To use another plugin from Damian's repo, follow the same setup as documap.
