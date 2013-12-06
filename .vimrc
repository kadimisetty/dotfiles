" vim: foldmethod=marker:foldlevel=0

" INFO {{{1
".vimrc (Vim Configuration file)
"Author:    Sri Kadimisetty
"Credits:   Listed at the bottom
"PREAMBLE {{{1
"Vundle installation requires the following to be in this order in the
"beginning, before Vundle bundles are listed).
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle' 

"Act like a grownup Vim, you're not vi anymore
set nocompatible                          

"VIM BUNDLES {{{1
"Active Bundles {{{2

Bundle 'Lokaltog/vim-easymotion'
Bundle 'Shougo/neocomplcache'
Bundle 'altercation/vim-colors-solarized'
Bundle 'applescript.vim'
Bundle 'arsenerei/vim-ragel'
Bundle 'godlygeek/tabular' 
Bundle 'gregsexton/MatchTag'
Bundle 'groenewege/vim-less'
Bundle 'guns/vim-clojure-static'
Bundle 'kadimisetty/vim-simplebar'
Bundle 'kadimisetty/vim-yenti'
Bundle 'kien/ctrlp.vim'
Bundle 'kien/rainbow_parentheses.vim'
Bundle 'peterhoeg/vim-qml'
Bundle 'rickharris/vim-blackboard'
Bundle 'rizzatti/dash.vim'
Bundle 'rizzatti/funcoo.vim'
Bundle 'scrooloose/syntastic'
Bundle 'sjl/gundo.vim'
Bundle 'sjl/vitality.vim'
Bundle 'sophacles/vim-processing'
Bundle 'tpope/vim-abolish'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-fireplace'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-obsession'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-speeddating'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-tbone'
Bundle 'tpope/vim-unimpaired'

"Inactive Bundles {{{2
" Bundle 'wincent/Command-T'
" Bundle 'mhinz/vim-startify'
" Bundle 'Lokaltog/vim-powerline'
" Bundle 'Valloric/YouCompleteMe'
" Bundle 'Python-Syntax'
" Bundle 'kana/vim-textobj-entire' | "@TODO - Fix error or file bug report
" Bundle 'klen/python-mode'
" Bundle 'majutsushi/tagbar'
" Bundle 'myusuf3/numbers.vim'
" Bundle 'textobj-entire'
" Bundle 'vim-scripts/YankRing.vim'
" Bundle 'vimez/vim-showmarks'

"Vundle Cleanup {{{2
"Needs to be turned back on right here after done setting up Vundle
filetype on                                 "Detect filetypes
filetype plugin on                          "Activate builtin set of filetypes plugins
filetype indent on                          "Activate builtin and computed indentations

"SEARCH {{{1
set infercase                               "Infer case matching while doing keyword completions
set ignorecase                              "Case Insensitive Search
set hlsearch                                "For non-case sensitive search
set smartcase                               "Perform case-detection slightly more sensibly
set wrapscan                                "Wrap search scan around the file
set incsearch                               "Match search incrementally

"Ignore these file patterns while completing file/dir names
set wildignore+=*.o,*.obj,*.exe,*.so,*.dll,*.pyc,.svn,.hg,.bzr,.git,
  \.sass-cache,*.class,*.scssc,*.cssc,sprockets%*,*.lessc

"MISC PREFERENCES {{{1

" let mapleader = ","                       | "Use default leader and leave the comma for search traversal
syntax on                                   | "Turn on syntax highlighting
set hidden                                  | "Unsaved bufers are allowed to move to the background
set showmode                                | "Show current modeline

set key=                                    | "Disable encryption by making the key empty
set autoread                                | "Sync loaded file to changes on disk

set backspace=indent,eol,start              | "Allow backspace to work in the insert mode
set cpoptions+=$                            | "When making a change to one line , show a $ at end of changed text

"Set status line akin to Derek Wyatt's preference - http://www.derekwyatt.org/vim/the-vimrc-file/better-settings/
set stl=%f\ %m\ %r\ Line:\ %l/%L[%p%%]\ Col:\ %c\ Buf:\ #%n\ [%b][0x%B]
set laststatus=2                            | "Always display a status line, even when there's just 1 window
set mousehide                               | "Hide mouse pointer while typing
set mouse=a                                 | "Automatically detect mouse usage
set history=500                             | "Remember 500 items in history

set showcmd                                 | "Show partial command in the last line at the bottom

"Use the external program [`par`](http://www.nicemice.net/par/) to format paragraphs
"gwip will still use vim's own formatprg
set formatprg=par\ -w50

"Look for vim modelines in the first 3 lines of a file(3 to allow for encoding, title)
set modeline
set modelines=5

"Save undo-history for a file EVEN AFTER a close and reopen. Yes, possible
"Unfortunately, +persistent-undo feature is not avilable in this installation
"set persistent-undo

"
"FILETYPE PREFERENCES {{{1

"Set Tabs & Spaces for filetyes {{{2
" Only do this part when compiled with support for autocommands
if has("autocmd")
  filetype on
  " Syntax of these languages is fussy over tabs Vs spaces
  autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
  autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
  " Customisations based on house-style (arbitrary)
  autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType javascript setlocal ts=4 sts=4 sw=4 noexpandtab
  " Treat .rss files as XML
  autocmd BufNewFile,BufRead *.rss setfiletype xml
endif

" Vi Folding Specifics {{{2
augroup ft_vim
    au!
    au FileType vim setlocal foldmethod=marker
    au FileType help setlocal textwidth=78
    au BufWinEnter *.txt if &ft == 'help' | wincmd L | endif
augroup END

"Use md for markdown instead of the default module2
au BufNewFile,BufRead *.md  setf markdown

"INDENTS & FOLDS {{{1
set foldopen=block,insert,jump,mark,percent,quickfix,search,tag,undo
set foldmethod=syntax
set foldlevelstart=1
let javaScript_fold=1                       "JavaScript
let perl_fold=1                             "Perl
let php_folding=1                           "PHP
let r_syntax_folding=1                      "R
let ruby_fold=1                             "Ruby
let sh_fold_enabled=1                       "sh
let vimsyn_folding='af'                     "Vim script
let xml_syntax_folding=1                    "XML

set scrolloff=3                             "Keep cursor these many lines above bottom of screen
set nowrap                                  "Wrap Long lines
set autoindent                              "Indent as previous line

set softtabstop=4
set shiftwidth=4                            "Use indents as length of 4 spaces
set tabstop=4                               "A tab counts for these many spaces

set backspace=2                             "Make backspace behave more like the popular usage

"Enables :Wrap to set settings required for soft wrap
command! -nargs=* Wrap set wrap linebreak nolist

set cindent                                 "Use C's indenting rules
set smarttab                                "Insert bkanks according to listed shiftwidth/tabstop/softtabstop
set expandtab                               "Use appropriate number of spaces to insert a tab when autodindent is on
set pastetoggle=<F12>                       "Same indentation on pastes

set cf                                      "Allow error files and error jumping
set timeoutlen=350                          "Wait for this long anticipating for a command

scriptencoding  utf-8                       "Set character encoding in the script
set encoding=utf-8                          "Set default file encoding to UTF-8
set title                                   "Enable setting title
set wildmenu                                "Perform things like menu completion with wildchar(often tab) etc.
set iskeyword+=_,$,@,%,#,-                  "Treat as keywords

set backup                                  "Make a backup before writing the file
set backupdir=~/.vim/backup                 "Use this directory to store backups
set directory=/tmp/                         "List of directory names to create the swp files in
set backupcopy=yes                          "Make a backup and then overwrite orginal file
set backupskip=/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*

set printoptions=header:0,duplex:long,paper:A4

"Show ellipsis on a soft break
set showbreak=…

"UI CHANGES {{{1
set number                                  "Display line numbers
set ruler                                   "Display line nujmber and cursor position
set nostartofline                           "Do not shift cursor back to line beginning while scrolling
set report=0                                "Threshold for number of lines changed
set ch=2                                    "Command line height(1 is default)
set nolazyredraw                            "Redraw screen while executing macros, registers, untyped commands etc.
set showmatch                               "When cursor is on bracket, briefly jump to coupled bracket
set mat=5                                   "Spend this much time switching the cursor to the coupled bracket
set visualbell                              "Show a visual indication instead of ringing an annoying bell.
set formatoptions+=n                        "Support lists (numbered, bulleted)
set virtualedit=block                       "Allow cursor to go to invalid places only in visually selected blocks
" set wildmode=longest,list                   "Tab-Completion ala bash
set wildmode=full                           "Tab-Completion ala zsh

set debug=msg,throw                         "Show error messages and throw exceptions

set synmaxcol=2048                          "For performance, only do syntax highlight upto these columns
set nocursorline                            "Highlight the screen line of cursor
set nocursorcolumn                          "Highlight the screen column of cursor
syntax enable                               "Enable Syntax highlighting

" set background=light                       "Use a theme with a light background 
set background=dark                         "Use a theme with a dark background 
silent! colorscheme solarized               "Turn on solarized colorscheme (solarized is not a builtin theme)

set splitbelow                              "Position newly split windows to thebelow
set splitright                              "Position newly split windows to the right

augroup WhiteSpaceCleaner
    autocmd!
    "Remove trailing whitespaces and ^M characters
    autocmd FileType c,cpp,java,php,js,python,twig,xml,yml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))
augroup END

"ABBREVIATIONS, TYPOS, ALIASES & CONCEALS {{{1
"Abbreviations
iabbrev ccopy Copyright 2013 Sri Kadimisetty, all rights reserved unless otherwise noted.

command! W w
command! Q q
"Retain visual selection after an indentation shift.
vnoremap < <gv
vnoremap > >gv
"Yank to end of line, just like C or D
nnoremap Y y$                             
"Retain cursor position after done joining two lines
nnoremap J mzJ`z
"Toggle spelling mode 
nnoremap <silent> <leader>ss :set spell!<CR>   
"Edit vimrc 
nnoremap <silent> <leader>v :edit $MYVIMRC<CR>   

"Conceals
if has('conceal')
    syntax keyword pyNiceStatement lambda conceal cchar=λ
endif

"MOVEMENT {{{1
"Window Movement {{{2
"Move focus to window facing h
nnoremap <silent> <C-h> :wincmd h<CR>         
"Move focus to window facing j 
nnoremap <silent> <C-j> :wincmd j<CR>         
"Move focus to window facing k
nnoremap <silent> <C-k> :wincmd k<CR>         
"Move focus to window facing l
nnoremap <silent> <C-l> :wincmd l<CR>         
"Move focus to previous window
nnoremap <silent> <C-p> :wincmd p<CR>         

"Window Splits {{{2
"Equal size windows
nnoremap <silent> <leader>w= :wincmd =<CR>    
"Split window horizontally
nnoremap <silent> <leader>sh :split<CR>       
"Split window vertically
nnoremap <silent> <leader>sv :vsplit<CR>      

"MAPPINGS {{{1
"Make <C-p> and <C-n> behave like <Up> and <Down>; else they do not filter
"command line history
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

"Move across "softly-wrapped" lines
vnoremap <D-j> gj
vnoremap <D-k> gk
vnoremap <D-4> g$
vnoremap <D-6> g^
vnoremap <D-0> g^
nnoremap <D-j> gj
nnoremap <D-k> gk
nnoremap <D-4> g$
nnoremap <D-6> g^
nnoremap <D-0> g^
"HANDY FUNCTIONS {{{1
" Execute current ruby line when there is a #=> marker at the end replacing it with the evaled result
" http://gist.github.com/thenoseman/4113709
function! RubyExecuteLineWithMarker()
    ruby << EOF
        marker = '#=>'
        buffer = VIM::Buffer.current
        if buffer.line.match(/#{marker}/)
          result = marker + ' ' + eval(buffer.line, binding).inspect
          buffer.line = buffer.line.sub(/#{marker}.*/, result).chomp
        end
EOF
endfunction
com! RubyExecuteLineWithMarker call RubyExecuteLineWithMarker()

" Run  current buffer through a python interpreter
map <buffer> <S-e> :w<CR>:!/usr/bin/env python % <CR>


" Initialise known file formats with my own starter templates
if has("autocmd")
    autocmd BufNewFile * silent! 0r ~/.vim/templates/template.%:e
endif

" Jump to the last known valid cursor position
if has("autocmd")
     autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \   exe "normal g`\"" |
            \ endif
 endif

"Source vimrc after every save. Might be a little too much.
"if has ("autocmd")
"    autocmd BufWritePost .vimrc source $MYVIMRC
"endif

"PLUGINS PREFS {{{1
"Powerline {{{2
" let g:Powerline_symbols = 'fancy'
" set fillchars+=stl:\ ,stlnc:\

"netrw {{{2
let g:netrw_banner=0

"Python-mode {{{2
"Disable pylint checking every save
let g:pymode_lint_write = 0
"Set key 'R' for run python code
let g:pymode_run_key = 'R'
"Load show documentation plugin
let g:pymode_doc = 1
"Show python documentation
let g:pymode_doc_key = 'K'
"Maximal height of pylint error window
 let g:pymode_lint_maxheight = 3
"Autoremove unused whitespaces
let g:pymode_utils_whitespaces = 1


"Tagbar {{{2
nnoremap <silent> <leader>tt :TagbarToggle<CR>

"Syntastic {{{2
let g:syntastic_warning_symbol='⚠'

"Neocachecompl {{{2
let g:neocomplcache_enable_at_startup=1
let g:neocomplcache_enable_auto_select=1 "Select the first entry automatically
let g:neocomplcache_enable_cursor_hold_i=1
let g:neocomplcache_cursor_hold_i_time=300
let g:neocomplcache_auto_completion_start_length=1

"Tab / Shift-Tab to cycle completions
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"

"Required to make neocomplcache_cursor_hold_i_time work - https://github.com/Shougo/neocomplcache/issues/140
let s:update_time_save = &updatetime
if has ("autocmd")
    autocmd InsertEnter * call s:on_insert_enter()
endif

function! s:on_insert_enter()
  if &updatetime > g:neocomplcache_cursor_hold_i_time
    let s:update_time_save = &updatetime
    let &updatetime = g:neocomplcache_cursor_hold_i_time
  endif
endfunction

if has ("autocmd")
    autocmd InsertLeave * call s:on_insert_leave()
endif

function! s:on_insert_leave()
  if &updatetime < s:update_time_save
    let &updatetime = s:update_time_save
  endif
endfunction


"Indent if we're at the beginning of a line. Else, do completion.
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

"Ctrl-p {{{2
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
  \ }

"Set max files
let g:ctrlp_max_files = 10000
"Use *nix's find for faster searching

if has("unix")
    let g:ctrlp_user_command = {
        \   'types': {
        \       1: ['.git/', 'cd %s && git ls-files']
        \   },
        \   'fallback': 'find %s -type f | head -' . g:ctrlp_max_files
        \ }
endif

"Startify {{{2
let g:startify_show_files_number = 10
"
"Do not list these files, they just clog it up.
let g:startify_skiplist = [
            \ 'COMMIT_EDITMSG',
            \ $VIMRUNTIME .'/doc',
            \ 'bundle/.*/doc'
            \ ]

let g:startify_show_files = 1
let g:startify_bookmarks = [ '~/dev/personal/dotfiles/.vimrc' ]

"CREDITS & INSPIRATION {{{1
"Tim Pope (of course)
"Ryan Tomayko
"Drew Neil
"Derek Wyatt
"Gary Bernhardt
"http://vim.spf13.com/
"github.com/joshcom/vimconfig/
"blog.sanctum.geek.nz/page/2/
