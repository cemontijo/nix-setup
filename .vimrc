"============================================================================
" TODO: Add newer options. Requires Vim 8.0+:
"============================================================================
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
"if has('syntax') && has('eval')
"	packadd matchit
"endif
" Show @@@ in the last line if it is truncated. 8.0?
"set display=truncate
"============================================================================

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
:set nocompatible "required for Vundle

"Turn off due to vulnerability and keep my own settings:
"https://arstechnica.com/information-technology/2019/06/if-you-havent-patched-vim-or-neovim-text-editors-you-really-really-should/ 
set nomodeline
set modelines=0

" A sample vimrc file:
"	$VIMRUNTIME/vimrc_example.vim

"ru! defaults.vim                " Use Enhanced Vim defaults
"aug vimStartup | au! | aug END  " Revert last positioned jump, as it is defined below
"let g:skip_defaults_vim = 1     " Do not source defaults.vim again (after loading this system vimrc)

"Verbose Mode to tell you what Vim does (debugging)
"The lower the number, the less granularity
":set verbose=1

"set/see all vim options:
":set all 

"TODO: Add CUSTOM paths for Vim to search at runtime 
if $USER == $PRIVILEGED_USER
	:set rtp+=/usr/local/conv/etc/vim
	":set rtp+=/usr/local/conv/etc/vim/bundle/Vundle.vim
	":set rtp+=/home/montijo/.vim
endif
":set runtimepath+=~/.vim/plugin

"============================================================================
"Plugin Managers
"Vundle downloads/updates plugins from GitHub/online
"NOTE: Requires git, HTTPS
"============================================================================
"UNUSED: To use single plugin files, move them to ~/.vim/ftdetect
"UNUSED: execute pathogen#infect('bundle/{}', '~/vim_stuff/pathogen_plugins/{}')

filetype off                  " required
" set the Vim runtime path to include Vundle and initialize
set runtimepath+=~/.vim/bundle/Vundle.vim

"call vundle#begin('~/some/path/here') " alternatively, pass a path where Vundle should install plugins
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

"=====[ Enable Nmap command for documented mappings ]================
"https://github.com/thoughtstream/Damian-Conway-s-Vim-Setup/blob/master/plugin/documap.vim
Plugin 'thoughtstream/Damian-Conway-s-Vim-Setup', {'rtp': 'plugin/'}
Plugin 'documap' "symlink

"Plugin 'Valloric/YouCompleteMe'
"Plugin 'ucompleteme'

Plugin 'google/vim-searchindex'
"Plugin 'vim-indexed-search-master'
"Plugin 'vim-searchindex-master'

"Plugin 'netrw' "Fix broken netrw installed on server

"Plugin 'elzr/vim-json'
"Plugin 'vim-json-master'

"Requires cscope installed on server, and Vim must have it turned on
"Plugin 'cscope-maps'

"Mappings Collide with other plugins
Plugin 'bash-support.vim' 

" Color schemes
Plugin 'gruvbox' 
"Plugin 'twilight' 
"Plugin 'twilight256.vim' 
"Plugin 'jellybeans.vim' 
"Plugin 'Solarized' 
"Plugin 'badwolf' 
"Plugin 'molokai' 
Plugin 'flazz/vim-colorschemes'
Plugin 'felixhummel/setcolors.vim'

"display C functions in brackets on statusline
Plugin 'cfname'
"Plugin 'taglist.vim'

"Plugin 'proc.vim' "Use custom proc.vim instead (installed in ~/.vim/syntax)

"Plugin 'sqlplus.vim' "Old version. New version (installed in ~/.vim/plugin):
"https://www.vim.org/scripts/script.php?script_id=2821

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
"-- plugin on GitHub repo:
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-vinegar'
"Plugin 'tpope/vim-sensible'
"-- plugin from http://vim-scripts.org/vim/scripts.html:
"Plugin 'L9'
"-- Git plugin not hosted on GitHub:
"Plugin 'git://git.wincent.com/command-t.git'
"-- git repos on your local machine (i.e. when working on your own plugin):
"Plugin 'file:///home/gmarik/path/to/plugin'
"-- The sparkup vim script is in a subdirectory of this repo called vim.
"   Pass the path to set the runtimepath properly:
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
"-- Install L9 and avoid a Naming conflict if you've already installed a
"   different version somewhere else:
"Plugin 'ascenator/L9', {'name': 'newL9'}

Plugin 'jez/vim-superman'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"============================================================================
" Post-Plugin configurations:
"============================================================================
"call ucompleteme#Setup()

" bash-support.vim plugin settings:
"let g:BASH_AlsoBash = [ '*.ksh' ]

"[Enable Nmap command for documented mappings w/o plugin manager]
"runtime plugin/documap.vim
"============================================================================

"if has('cscope')
"	set cscopetag cscopeverbose
"	if has('quickfix')
"		set cscopequickfix=s-,c-,d-,i-,t-,e-
"	endif
"	cnoreabbrev csa cs add
"	cnoreabbrev csf cs find
"	cnoreabbrev csk cs kill
"	cnoreabbrev csr cs reset
"	cnoreabbrev css cs show
"	cnoreabbrev csh cs help
"	command -nargs=0 Cscope cs add $VIMSRC/src/cscope.out $VIMSRC/src
"endif

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
	finish
endif

"============================================================================
" Finding/Searching/Paths
"============================================================================
" Search down into subfolders
" " Provides tab-completion for all file-related tasks
" Also sets path for find command:
" TODO: Add custom paths to search in
:set path+=**
if exists('$DSKS')
	:set path+=$DSKS/*/*
endif

:set incsearch		" do incremental searching
:set ignorecase smartcase " Turn on case-insensitive matches (but only when pattern is all-lowercase)
:set hlsearch		" do highlighted searching

"Maps / for regex searches by prefixing \v for more natural syntax
:nnoremap / /\v

"Make delete key in Normal mode remove the persistently highlighted matches
:nmap <silent>  <Del>  :nohlsearch<CR>
"============================================================================
" FILE BROWSING:
" " Tweaks for browsing
" " NOW WE CAN:
" " - :edit a folder to open a file browser
" " - <CR>/v/t to open in an h-split/v-split/tab
" " - check |netrw-browse-maps| for more mappings
"let g:netrw_banner=0        " disable annoying banner
"let g:netrw_list_hide=netrw_gitignore#Hide()
"let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'
"let g:netrw_browse_split=4  " open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view

" turn on the "visual bell" - which is much quieter than the "audio blink"
":set vb 

" make the last line where the status is two lines deep so you can see status always
set laststatus=2   

" Show EOL type and last modified timestamp, right after the filename
" Set the statusline
" NOTE: this overrides Cfname plugin that displays current function WHENEVER ~/.vimrc is sourced
"set statusline=%f               " filename relative to current $PWD
"set statusline+=%h              " help file flag
"set statusline+=%m              " modified flag
"set statusline+=%r              " readonly flag
"set statusline+=\ (%{strftime(\"%H:%M\ %d/%m/%Y\",getftime(expand(\"%:p\")))})  " last modified timestamp
"set statusline+=%=              " Rest: right align
"set statusline+=%l,%c%V         " Position in buffer: linenumber, column, virtual column
"set statusline+=\ %P            " Position in buffer: Percentage
set statusline+=\ [%{&ff}]      " Fileformat [unix]/[dos] etc...

"								*cpo-$*
"		$	When making a change to one line, don't redisplay the
"			line, but put a '$' at the end of the changed text.
"			The changed text will be overwritten when you type the
"			new text.  The line is redisplayed if you type any
"			command that moves the cursor from the insertion
"			point.
:set cpoptions+=$W

":set virtualedit=onemore "Allow the cursor to move just past the end of the line

" Inverse highlighting for cursor...
"highlight CursorInverse term=inverse ctermfg=black ctermbg=white

" Set up highlighter at high priority (i.e. 99)
"call matchadd('CursorInverse', '\%#', 99)

"=====[ Highlight row and column on request ]===================

" Toggle cursor row highlighting on request...
highlight CursorLine   term=bold ctermfg=black ctermbg=cyan  cterm=bold
Nmap <silent> ;R [Toggle cursor line highlighting] :set cursorline!<CR>

" Toggle cursor column highlighting on request...
" " (via visualguide.vim plugin, so as to play nice)
"nmap <silent> \  :silent call VG_Show_CursorColumn('flip')<CR>
"vmap <silent> \  :<C-W>silent call VG_Show_CursorColumn('flip')<CR>gv
"imap <silent> <C-\> <C-O>:silent call VG_Show_CursorColumn('flip')<CR>

"============================================================================
" Change the way the current line/column is highlighted
"============================================================================
"highlight CursorLine    term=bold  cterm=inverse
"highlight CursorColumn  term=bold  ctermfg=cyan  ctermbg=white
"============================================================================
" Turn on the markers for the current line/column
"============================================================================
":set cursorline
":set cursorcolumn
"If you only want the highlighting in the current window you can use
"these autocommands: 
"au WinLeave * set nocursorline nocursorcolumn
"au WinEnter * set cursorcolumn
"============================================================================
" Highlight anything in the 81st column of long lines
"============================================================================
:highlight ColorColumn ctermbg=magenta
"call matchadd('ColorColumn', '\%81v', 100)
" Set up a permanent universal vertical marker after 80 columns
"set colorcolumn=81

"=====[ Comments are important ]==================
highlight Comment term=bold ctermfg=white

" for vim in term set coloring
"set term=xtermc

:set number "line numbers
":set relativenumber "line numbers, slow

" The ":syntax enable" command will keep your current color settings.  This
" allows using ":highlight" commands to set your preferred colors before or
" after using this command.  If you want Vim to overrule your settings with the
" defaults, use: > :syntax on
:syntax enable

":color ron
:colo devbox-dark-256
:color darkburn

":source ~/.vim/bundle/setcolors.vim/plugin/setcolors.vim
"let nowcolors = 'breeze earth less aqua gothic'
":SetColors all
":SetColors now

"When a bracket is inserted, briefly jump to the matching one.  The
"jump is only done if the match can be seen on the screen.  The time to
"show the match can be set with 'matchtime'.
:set showmatch

"List the tags that match [ident], using the
"			information in the tags file(s).
"			When [ident] is not given, the last tag name from the
"			tag stack is used.

" Vim support file to define the default menus
" You can also use this as a start for your own set of menus.
:source $VIMRUNTIME/menu.vim

" When completing, show all options, insert common prefix, then iterate
:set wildmode=list:longest,full
:set wildmenu

" allow backspacing over everything in insert mode
:set backspace=indent,eol,start

:set history=1000	 " keep # of lines of Vim command line history
:set ruler		     " show the cursor position all the time
:set showcmd		   " display incomplete commands
:set showmode      " show the current mode

"============================================================================
" Make folds auto-open and auto-close when the cursor moves over them
"============================================================================
:set foldopen=all
":set foldclose=all
"============================================================================
" Set up persistent undo (with all undo files in one directory)
"============================================================================
if has('persistent_undo')
	set undofile
endif
:set undodir=$HOME/.VIM_UNDO_FILES
:set undolevels=50000
"============================================================================
if has("vms")
	set nobackup		" do not keep a backup file, use versions instead
	"else
	"  set backup		" keep a backup copy of old file that appends ~
endif

" For Win32 GUI : remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, t, , g)

"When editing a text file, if you want word wrapping,
"but only want line breaks inserted when you explicitly press the Enter key:
:set nowrap
":set linebreak
":set nolist  " list disables linebreak

" In many terminal emulators the mouse works just fine, thus enable it.
" Copy/paste with the mouse and Visual mode ('mouse' option must be set, see
" above):
" 1. Press left mouse button on first letter of text, move mouse pointer to last
"    letter of the text and release the button.  This will start Visual mode and
"    highlight the selected area.
" 2. Press y to yank the Visual text in the unnamed register.
" 3. Click the left mouse button at the insert position.
" 4. Click the middle mouse button.
if has('mouse')
	set mouse=r
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

	" Enable file type detection.
	" Use the default filetype settings, so that mail gets 'tw' set to 72,
	" 'cindent' is on in C files, etc.
	" Also load indent files, to automatically do language-dependent indenting.
	filetype plugin indent on

	"M&S Specific file file checking
	augroup filetypedetect

		"For all files, set the format options, turn off C indentation, and finally set the comments option to the default. 
		":autocmd FileType * set formatoptions=tcql nocindent comments&

		"Configure .sc, .ctl, .jil files for Vim
		autocmd BufRead,BufNewFile *.sc  set filetype=c
		autocmd BufRead,BufNewFile *.ctl  set filetype=conf
		autocmd BufRead,BufNewFile *.jil  set filetype=conf
		autocmd BufNewFile,BufRead *.patch set filetype=diff

		"au BufRead,BufNewFile,BufEnter *.sc CFunEnablestatusinfo "DOESN'T WORK

		"For all C/C++/SC files, set the formatoptions, turn on C indentation/syntax, and set the comments option.
		"autocmd FileType c,cpp,sc set formatoptions=croql syntax=c cindent comments=sr:/*,mb:*,ex:*/,://
		autocmd FileType c,cpp,sc set formatoptions=croql syntax=proc cindent comments=sr:/*,mb:*,ex:*/,://

		"au FileType c,sc setl ofu=ccomplete#CompleteCpp
		au FileType php setl ofu=phpcomplete#CompletePHP
		au FileType ruby,eruby setl ofu=rubycomplete#Complete
		au FileType html,xhtml setl ofu=htmlcomplete#CompleteTags
		au FileType css setl ofu=csscomplete#CompleteCSS

		au BufNewFile,BufRead *.buf			setf sql
		" CASA DAT files
		au BufNewFile,BufRead *.dat			setf dat
		" CASA database output files
		au BufNewFile,BufRead dbase.out			setf dbase
		" Grammar description files
		au BufNewFile,BufRead *_dat.g			setf g
		" Sim Script files
		au BufNewFile,BufRead *.sim			setf simscript
		" CASA SMDL files
		au BufNewFile,BufRead *.SMDL			setf smdl

	augroup END

	autocmd Filetype diff
				\ highlight WhiteSpaceEOL ctermbg=red |
				\ match WhiteSpaceEOL /\(^+.*\)\@<=\s\+$/

	" Put these in an autocmd group, so that we can delete them easily.
	augroup vimrcEx
		au!
		" For all text files set 'textwidth' to 78 characters.
		autocmd FileType text setlocal textwidth=78

		"====[ Goto last location in non-empty files ]=======
		" When editing a file, always jump to the last known cursor position.
		" Don't do it when the position is invalid or when inside an event handler
		" (happens when dropping a file on gvim).
		" Also don't do it when the mark is in the first line, that is the default
		" position when opening a file.
		"autocmd BufReadPost *
		"			\ if line("'\"") > 1 && line("'\"") <= line("$") |
		"			\   exe "normal! g`\"" |
		"			\ endif

		" Remember the positions in files with some git-specific exceptions"
		autocmd BufReadPost *
					\ if line("'\"") > 0 && line("'\"") <= line("$")
					\           && &filetype !~# 'commit\|gitrebase'
					\           && expand("%") !~ "ADD_EDIT.patch"
					\           && expand("%") !~ "addp-hunk-edit.diff" |
					\   exe "normal g`\"" |
					\ endif

	augroup END

endif "has autocmd


" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
	command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
				\ | wincmd p | diffthis
endif

:set autoindent		" always set autoindenting on
":set cindent      " c indentation

"Number of spaces that a <Tab> in the file counts for:
:set tabstop=2

"'shiftwidth' 'sw'	number	(default 8)
"			local to buffer
"	Number of spaces to use for each step of (auto)indent.  Used for
"	|'cindent'|, |>>|, |<<|, etc. When zero the 'ts' value will be used. 
:set shiftwidth=2

"Replace tabs with spaces:
"If you want absolutely no tabs in your file, you can set the 'expandtab'
"('et') option. When this option is set, the <Tab> key inserts a series of spaces.
"(Note that setting 'expandtab' does not affect any existing tabs. In other words,
"any tabs in the document remain tabs. If you want to convert tabs to spaces, use
"the :retab (:ret) command
":set expandtab
":retab 

"============================================================================
" Other useful Key mappings
"============================================================================
"====[ I'm sick of typing :%s/.../.../gn ]=======
Nmap S  [Shortcut for :s///gn]  :%s//gn<LEFT><LEFT>
vmap S                         :Blockwise s//gn<LEFT><LEFT>

Nmap <expr> M  [Shortcut for :s/<last match>//gn]  ':%s/' . @/ . '//gn<LEFT><LEFT>'
vmap <expr> M ':s/' . @/ . '//gn<LEFT><LEFT>'

" Don't use Ex mode, use Q for formatting
":map Q gq

" XML formatting
":map <F5> :%s/<\([^>]\)*>/\r&\r/g<enter>:g/^$/d<enter>vat=
":map <F6> vatJxvito<right><left>x
":map <F7> /\v^\s*([a-zA-Z\-0-9\$])<enter>qm<F6>nq@q1000@@:1<enter>

" one or more lines:
"vmap ,px !xmllint --format -<CR>

" pretty-print current line
"nmap ,px !!xmllint --format -<CR>

" For pasting outside text into VIM terminal:
"	Mappings are checked first, thus overrule 'pastetoggle'.  However,
"	when 'paste' is on mappings are ignored in Insert mode, thus you can do
"	this: >
:map <F10> :set paste<CR>
:map <F11> :set nopaste<CR>
:imap <F10> <C-O>:set paste<CR>
:imap <F11> <nop>
:set pastetoggle=<F11>
"<	This will make <F10> start paste mode and <F11> stop paste mode.
"	Note that typing <F10> in paste mode inserts "<F10>", since in paste
"	mode everything is inserted literally, except the 'pastetoggle' key
"	sequence.	When the value has several bytes 'ttimeoutlen' applies.

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
" inoremap <C-U> <C-G>u<C-U>

" map vimrc file cmds
:map <F6> :source ~/.vimrc<CR>
":map <F9> :sp ~/.vimrc<CR>
command! Vimrc :vs $MYVIMRC

"Define some nice abbreviations: 
:ab #d #define
:ab #i #include
"Define some abbreviations to draw comments.
:ab #b /****************************************
:ab #e ^V^H*****************************************/
:ab #l /*------------------------------------------------------*/

"============================================================================
" Vim command notes
"============================================================================
"Autocomplete
"Completing file names					*compl-filename*
"							*i_CTRL-X_CTRL-F*
"Use Ctrl-N to get a list of word suggestions while in insert mode. Type :help
"i_CTRL-N to see Vim's documentation on this functionality.

" Vim has an autocompletion feature for typing path in insert mode! It calls this feature as file name completion.
" Ctrl-x Ctrl-f: This is the shortcut to autocomplete path in insert mode. Start typing a path (absolute or relative) and use this keyboard shortcut. 
" You will see a dropdown menu filled with the next entries from the filesystem that can be used to fill the path.
"
" Ctrl-n or Ctrl-p: Shortcuts to move up and down the entries in the
" autocomplete dropdown menu. If you move off the top or bottom of the
" dropdown menu, you get the empty entry.
