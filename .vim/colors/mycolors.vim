" Vim color file
" Maintainer:	Dan Gruhn <Dan.Gruhn@Emergent-it.com>
" Last Change:	2001 August 21

" This color scheme uses a white background.

" First remove all existing highlighting.
set background=light
hi clear
if exists("syntax_on")
  syntax reset
endif

let colors_name = "mycolors"

"hi Normal ctermfg=Black ctermbg=White guifg=Black guibg=White

" Groups used in the 'highlight' and 'guicursor' options default value.
hi ErrorMsg term=standout ctermbg=DarkRed ctermfg=White guibg=Red guifg=White
hi IncSearch term=reverse cterm=reverse gui=reverse
hi ModeMsg term=bold cterm=bold gui=bold
hi StatusLine term=reverse,bold cterm=reverse,bold gui=reverse,bold
hi StatusLineNC term=reverse cterm=reverse gui=reverse
hi VertSplit term=reverse cterm=reverse gui=reverse
hi Visual term=reverse cterm=reverse gui=bold guifg=White guibg=Blue
hi VisualNOS term=underline,bold cterm=underline,bold gui=underline,bold
hi DiffText term=reverse cterm=bold ctermbg=Red gui=bold guibg=Red
hi Cursor guibg=Black guifg=White
hi lCursor guibg=Cyan guifg=NONE
hi Directory term=bold ctermfg=DarkBlue guifg=Blue
hi LineNr term=underline ctermfg=Brown guifg=Brown
hi MoreMsg term=bold ctermfg=DarkGreen gui=bold guifg=SeaGreen
hi NonText term=bold ctermfg=Blue gui=bold guifg=Blue guibg=White
hi Question term=standout ctermfg=DarkGreen gui=bold guifg=SeaGreen
hi Search term=reverse ctermbg=Yellow ctermfg=NONE guibg=Yellow guifg=NONE
hi SpecialKey term=bold ctermfg=DarkBlue guifg=Blue
hi Title term=bold ctermfg=DarkMagenta gui=bold guifg=Magenta
hi WarningMsg term=standout ctermfg=DarkRed guifg=Red
hi WildMenu term=standout ctermbg=Yellow ctermfg=Black guibg=Yellow guifg=Black
hi Folded term=standout ctermbg=Grey ctermfg=DarkBlue guibg=LightGrey guifg=DarkBlue
hi FoldColumn term=standout ctermbg=Grey ctermfg=DarkBlue guibg=Grey guifg=DarkBlue
hi DiffAdd term=bold ctermbg=LightBlue guibg=LightBlue
hi DiffChange term=bold ctermbg=LightMagenta guibg=LightMagenta
hi DiffDelete term=bold ctermfg=Blue ctermbg=LightCyan gui=bold guifg=Blue guibg=LightCyan

" Colors for syntax highlighting
hi String	ctermfg=Blue guifg=Blue gui=NONE
hi Comment	term=bold ctermfg=DarkGreen guifg=DarkCyan gui=NONE
hi Constant	term=underline ctermfg=DarkRed guifg=DarkMagenta gui=NONE
hi Identifier	term=underline ctermfg=DarkCyan guifg=Red gui=NONE
hi PreProc	term=underline ctermfg=DarkMagenta guifg=DarkGreen gui=NONE
hi Special	term=bold ctermfg=DarkMagenta guifg=green gui=NONE
hi Statement	ctermfg=Brown guifg=Brown gui=NONE
hi Type		term=underline ctermfg=DarkBlue guifg=DarkBlue gui=NONE 
hi Ignore	ctermfg=white guifg=bg gui=NONE
hi Error 	term=reverse ctermbg=Red ctermfg=White guibg=Red guifg=White gui=NONE
hi Todo	 	term=standout ctermbg=Yellow ctermfg=Black guifg=Blue guibg=Yellow gui=NONE

if &t_Co > 8
  hi Statement ctermfg=Brown guifg=Brown gui=NONE
endif

" vim: sw=2
