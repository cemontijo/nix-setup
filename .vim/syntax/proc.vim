" Vim syntax file
" Language:	Oracle Pro*C/C++
" Maintainer:	Michael Jarvis <michael@jarvis.com>
" Last Change:	2003 May 22


" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
    syntax clear
elseif exists("b:current_syntax")
    finish
endif

" Read the C++ syntax to start with, which in turn reads the C syntax
if version < 600
    so <sfile>:p:h/cpp.vim
else
    runtime! syntax/cpp.vim
    unlet b:current_syntax
endif

:syntax case ignore

" Oracle Pro C/C++ extensions...so far we just just highlight 
" EXEC SQL statements.
"syn region procStatement         start="EXEC SQL" end=";"
syn keyword procKe				 CREATE SELECT OPEN CLOSE  INSERT CURSOR FOR AND OR FROM WHERE  UPDATE INTO DO 
syn keyword funcSQL				 SUBSTR BEGIN DATABASE SQLERROR WHENEVER INCLUDE SQLCA LOG_ERROR  ASCII SYSDATE TO_NUMBER TO_DATE EXEC SQL DECLARE END SECTION UNION SUM MAX COUNT MIN NVL  
syn keyword edsDefined 			 List fprintf stderr XMLElement sqlca sqlcode 
syn keyword stringFunc		     memcpy strcpy strncpy memcmp strcmp strncmp memset atol sprintf printf 
" Default highlighting
if version >= 508 || !exists("did_proc_syntax_inits")
    if version < 508
        let did_proc_syntax_inits = 1
        command -nargs=+ HiLink hi link <args>
    else
        command -nargs=+ HiLink hi def link <args>
    endif
"    HiLink procStatement         Type
	HiLink procKe				 PreProc
	HiLink funcSQL				 Type
	HiLink edsDefined 			 Type 
	HiLink stringFunc 			 Special 
    delcommand HiLink
endif

:syntax case match

let b:current_syntax = "proc"

" vim: ts=4
