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

NOTE: Incorporates the following repos as submodules:
  .vim/bundle/Damian-Conway-s-Vim-Setup (heads/master)
  .vim/bundle/LargeFile (5)
  .vim/bundle/Vundle.vim (0.9.1-182-gb255382)
  .vim/bundle/bash-support.vim (4.2.1)
  .vim/bundle/cfname (3.0)
  .vim/bundle/gruvbox (1.3.5)
  .vim/bundle/setcolors.vim (heads/master)
  .vim/bundle/vim-colorschemes (heads/master)
  .vim/bundle/vim-fugitive (v3.6-49-gb7287bd)
  .vim/bundle/vim-json (heads/master)
  .vim/bundle/vim-json-line-format (heads/master)
  .vim/bundle/vim-searchindex (heads/master)
  .vim/bundle/vim-superman (0.10.0-7-g19d3074)
  .vim/bundle/vim-vinegar (v1.0-19-gbb1bcdd)

NOTE: The documap plugin comes from Damian Conway's Vim Setup (https://github.com/thoughtstream/Damian-Conway-s-Vim-Setup), which is why it's symlinked.
To use another plugin from Damian's repo, follow the same setup as documap.
