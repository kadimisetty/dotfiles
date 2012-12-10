".vimrc file
"Compiled by Sri Kadimisetty. Credits listed at the bottom.

set nocompatible                          "No more vi

"BEGIN VUNDLE-----------------------------------------------------------------
"
"running a new system for the very first time, vundle needs to be installed - 
"  $ mkdir ~/.vim
"  $ git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
"
"
"Vundle Vim package installation software (Needs to be in this exact location)
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
"Main vundle Package (Needs to be listed first)
Bundle 'gmarik/vundle'
"Vundle Packages
Bundle 'altercation/vim-colors-solarized'
Bundle 'mutewinter/vim-indent-guides'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'Lokaltog/vim-powerline'
Bundle 'tpope/vim-surround.git'
Bundle 'godlygeek/tabular.git'
Bundle 'Shougo/neocomplcache'
Bundle 'gregsexton/MatchTag'
Bundle 'groenewege/vim-less'
Bundle 'tpope/vim-fugitive'
Bundle 'Python-Syntax'
"
"Deactivated Packages
"Bundle 'majutsushi/tagbar'
"Bundle 'myusuf3/numbers.vim'
"END VUNDLE------------------------------------------------------------------

"Needs to be turned back on  right here after done setting up Vundle
filetype on                               "Detect filetypes
filetype plugin on                        "Activate builtin set of filetypes plugins
filetype indent on                        "Activate builtin and computed indentations

syntax on                                 "Turn on syntax highlighting
set hidden                                "Unsaved bufers are allowed to move to the background
set showmode                              "Show current modeline


set key=                                  "Disable encryption by making the key empty
set autoread                              "Sync loaded file to changes on disk

"SEARCH
set ignorecase                            "Case Insensitive Search
set hlsearch                              "For non-case sensitive search
set smartcase                             "Perform case-detection slightly more sensibly
set wrapscan                              "Wrap search scan around the file
set incsearch                             "Match search incrementally
set wildignore+=*.o,*.obj,*.exe,*.so,*.dll,*.pyc,.svn,.hg,.bzr,.git,
  \.sass-cache,*.class,*.scssc,*.cssc,sprockets%*,*.lessc

set backspace=indent,eol,start            "Allow backspace to work in the insert mode
set cpoptions+=$                          "When making a change to one line , show a $ at end of changed text

"Set status line akin to Derek Wyatt's preference - http://www.derekwyatt.org/vim/the-vimrc-file/better-settings/
set stl=%f\ %m\ %r\ Line:\ %l/%L[%p%%]\ Col:\ %c\ Buf:\ #%n\ [%b][0x%B]
set laststatus=2                          "Always display a status line, even when there's just 1 window
set mousehide                             "Hide mouse pointer while typing
set mouse=a                               "Automatically detect mouse usage
set history=500                           "Remember 500 items in history
"Handle folding
set foldopen=block,insert,jump,mark,percent,quickfix,search,tag,undo
set scrolloff=3                           "Keep cursor these many lines above bottom of screen
set nowrap                                "Wrap Long lines
set autoindent                            "Indent as previous line
set shiftwidth=2                          "Use indents as length of 4 spaces
set tabstop=2                             "A tab counts for these many spaces
set backspace=2                           "Make backspace behave more like the popular usage
set cindent                               "Get the indent accotding to 'C' specifications
set smarttab                              "Insert bkanks according to listed shiftwidth/tabstop/softtabstop
set expandtab                             "Use appropriate number of spaces to insert a tab when autodindent is on
set pastetoggle=<F12>                     "Same indentation on pastes

"Remove trailing whitespaces and ^M characters
autocmd FileType c,cpp,java,php,js,python,twig,xml,yml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

set cf                                    "Allow error files and error jumping
scriptencoding  utf-8                     "Set character encoding in the scri[t
set timeoutlen=350                        "Wait for this long anticipating for a command

set encoding=utf-8                        "Set default file encoding to UTF-8
set number                                "Precede each line with the line number
set ruler                                 "Show line nujmber and cursor position
set title                                 "Enable setting title
set wildmenu                              "Perform things like menu completion with wildchar(often tab) etc.
set iskeyword+=_,$,@,%,#,-                "Treat as keywords

set debug=msg,throw                       "Show error messages and throw exceptions

set backup                                "Make a backup before writing the file
set backupdir=~/.vim/backup               "Use this directory to store backups
set directory=/tmp/                       "List of directory names to create the swp files in
set backupcopy=yes                        "Make a backup and then overwrite the orginal file
set backupskip=/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*

set printoptions=header:0,duplex:long,paper:A4


"UI CHANGES------------------------------------------------------------------
set nostartofline                         "Do not shift cursor back to line beginning while scrolling
set report=0                              "Threshold for number of lines changed
set ch=2                                  "Command line height(1 is default)
set nolazyredraw                          "Redraw screen while executing macros, registers, untyped commands etc.
set showmatch                             "When cursor is on bracket, briefly jump to coupled bracket
set mat=5                                 "Spend this much time switching the cursor to the coupled bracket
set visualbell                            "Show a visual indication instead of ringing an annoying bell.
set formatoptions+=n                      "Support lists (numbered, bulleted)
set virtualedit=block                     "Allow cursor to go to invalid places only in visually selected blocks

set synmaxcol=2048                        "For performance, only do syntax highlight upto these columns
set nocursorline                          "Highlight the screen line of cursor
set nocursorcolumn                        "Highlight the screen column of cursor
syntax enable                             "Enable Syntax highlighting
set background=dark                       "Use a theme with a dark background (as opposed to `light` themes)
colorscheme solarized                     "Turn on solarized colorscheme (solarized is not a builtin theme)


"LEADERS --------------------------------------------------------------------
let mapleader = ","

"TYPOS AND ALIASES-----------------------------------------------------------
command! W w
command! Q q

"Retain visual selection after an indentation shift.
vnoremap < <gv
vnoremap > >gv


"Yank to end of line, just like C or D
nnoremap Y y$                             

"Turn off search highlight with this new shortcut
nmap <silent> <leader>n :nohls<CR>        
"Toggle spelling mode 
nmap <silent> <leader>s :set spell!<CR>   
"Edit vimrc 
nmap <silent> <leader>v :e ~/.vimrc<CR>   

"QUICKFIX WINDOW--------------------------------------------------------------
" Toggle the Quickfix window
map <silent> <leader>q :QFix<CR>          
" Jump to the next tab
map <C-c>n :cnext<CR>                     
" Jump to previous tab
map <C-c>p :cprevious<CR>                 


"MOVEMENT --------------------------------------------------------------------
" Tabs
" Move focus to the next tab
nmap <leader>tn :tabnext<CR>
" Move focus to the previous tab
nmap <leader>tp :tabprevious<CR>
" Edit the tab
nmap <leader>te :tabedit
 
 "Window Movement
" Move focus to window facing h
nmap <silent> <C-h> :wincmd h<CR>         
" Move focus to window facing j 
nmap <silent> <C-j> :wincmd j<CR>         
" Move focus to window facing k
nmap <silent> <C-k> :wincmd k<CR>         
" Move focus to window facing l
nmap <silent> <C-l> :wincmd l<CR>         
" Move focus to previous window
nmap <silent> <C-p> :wincmd p<CR>         
" Window Splits
" Equal size windows
nmap <silent> <leader>w= :wincmd =<CR>    
" Split window horizontally
nmap <silent> <leader>sh :split<CR>       
" Split window vertically
nmap <silent> <leader>sv :vsplit<CR>      

"PLUGINS --------------------------------------------------------------------
" Powerline
let g:Powerline_symbols = 'fancy'
set fillchars+=stl:\ ,stlnc:\

" TagBar
nnoremap <silent> <leader>tt :TagbarToggle<CR>



" Neocachecompl
let g:neocomplcache_enable_at_startup=1
let g:neocomplcache_enable_auto_select=1 "Select the first entry automatically
let g:neocomplcache_enable_cursor_hold_i=1
let g:neocomplcache_cursor_hold_i_time=300
let g:neocomplcache_auto_completion_start_length=1

" Tab / Shift-Tab to cycle completions
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"

" Required to make neocomplcache_cursor_hold_i_time work - https://github.com/Shougo/neocomplcache/issues/140
let s:update_time_save = &updatetime
autocmd InsertEnter * call s:on_insert_enter()

function! s:on_insert_enter()
  if &updatetime > g:neocomplcache_cursor_hold_i_time
    let s:update_time_save = &updatetime
    let &updatetime = g:neocomplcache_cursor_hold_i_time
  endif
endfunction





"HANDY MACROS ---------------------------------------------------------------

autocmd InsertLeave * call s:on_insert_leave()

function! s:on_insert_leave()
  if &updatetime < s:update_time_save
    let &updatetime = s:update_time_save
  endif
endfunction

" Initialise known file formats with my own starter templates in this location
if has("autocmd")
    autocmd BufNewFile * silent! 0r ~/.vim/templates/template.%:e
endif

" Jump to the last known valid cursor position
 autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endi

 
"CREDITS & INSPIRATION ------------------------------------------------------
"
" Tim Pope (ofcourse)
" Ryan Tomayko
" Drew Neil
" Derek Wyatt
" http://vim.spf13.com/
" etc.
"
