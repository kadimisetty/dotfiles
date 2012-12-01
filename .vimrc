".vimrc file
"Compiled by Sri Kadimisetty
"See bottom for CREDITS
"
"Goodbye vi. You're now officially a vestigial organ.
set nocompatible


"--BEGIN VUNDLE----
"Vundle Vim package installation software
"Vundle Installation - needs to be in this exact location
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
"Main vundle Package 
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

"Deactivated Packages
"Bundle 'myusuf3/numbers.vim'
"--END VUNDLE------

"Needs to be turned back on and done after Vundle is listed above
filetype on
filetype plugin on
filetype indent on

syntax on                                 "Turn on syntax highlighting
set hidden                                "Hide buffers
set showmode                              "Show current mode

"SEARCH
set ignorecase                            "Case Insensitive Search
set hlsearch                              "For non-case sensitive search
set smartcase
set wrapscan                              "Wrap search scan around the file
set incsearch                             "Match search incrementally
set wildignore+=*.o,*.obj,*.exe,*.so,*.dll,*.pyc,.svn,.hg,.bzr,.git,
  \.sass-cache,*.class,*.scssc,*.cssc,sprockets%*,*.lessc



set backspace=indent,eol,start            "Allow backspace to work in the insert mode
set cpoptions+=$


"set status line according to Derek Wyatt's preference
set stl=%f\ %m\ %r\ Line:\ %l/%L[%p%%]\ Col:\ %c\ Buf:\ #%n\ [%b][0x%B]
set laststatus=2                          "Always display a status line, even for just one window
set mousehide                             "Hide mouse pointer while typing
set mouse=a                               "Automatically detect mouse usage

set history=500                           "Remeber 500 items in history

"Handle folding
set foldopen=block,insert,jump,mark,percent,quickfix,search,tag,undo


set scrolloff=3                           "Keep cursor these many lines above bottom of screen
"set virtualedit=all                      "Cursor is allowed to go to invalid places


set nowrap                                "Wrap Long lines

set autoindent                            "Indent as previous line
set shiftwidth=2                          "Use indents as length of 4 spaces
set tabstop=2
set backspace=2                           "Delete everythong with backspace
set cindent
set smarttab
set expandtab

set pastetoggle=<F12>                     "Same indentation on pastes

"Remove trailing whitespaces and ^M characters
autocmd FileType c,cpp,java,php,js,python,twig,xml,yml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))


set cf                                    "Allow error files and error jumping

scriptencoding  utf-8                     "Set character encoding in the scri[t

let mapleader = ","                       "Set leader to ,

set timeoutlen=350                        "Wait for this long anticipating for a command

nnoremap Y y$                             "Yank to end of line, just like C or D

"Encoding & small UI adjustments
set encoding=utf-8
set number
set ruler
set title                                 "Enable setting title
set wildmenu


"COMMON TYPOS
command! W w
command! Q q

nmap <silent> <leader>s :set spell!<CR>   "Toggle spelling mode 
nmap <silent> <leader>v :e ~/.vimrc<CR>   "Edit vimrc 
map <silent> <leader>q :QFix<CR>          "Toggle the Quickfix window

""Shortucts to jump to next/previous in the quickfix window
map <C-c>n :cnext<CR>
map <C-c>p :cprevious<CR>


"Initialise known file formats with my own starter templates in this location
if has("autocmd")
    autocmd BufNewFile * silent! 0r ~/.vim/templates/template.%:e
endif

syntax enable                           "Enable Syntax highlighting
set background=dark
colorscheme solarized                   "Turn on solarized colorscheme


"POWERLINE
let g:Powerline_symbols = 'fancy'
set fillchars+=stl:\ ,stlnc:\


set backup
set backupdir=~/.vim/backup
set directory=/tmp/


"TAB NAVIGATION
Nmap <leader>tn :tabnext<CR>
nmap <leader>tp :tabprevious<CR>
nmap <leader>te :tabedit

"WINDOW MOVEMENT
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-l> :wincmd l<CR>
nmap <silent> <C-p> :wincmd p<CR>
nmap <silent> <leader>w= :wincmd =<CR>  "Equal Size Windows
nmap <silent> <leader>sh :split<CR>
nmap <silent> <leader>sv :vsplit<CR>


"PLUGIN: Neocachecompl
let g:neocomplcache_enable_at_startup=1
let g:neocomplcache_enable_auto_select=1 "Select the first entry automatically
let g:neocomplcache_enable_cursor_hold_i=1
let g:neocomplcache_cursor_hold_i_time=300
let g:neocomplcache_auto_completion_start_length=1

"Tab / Shift-Tab to cycle completions
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

autocmd InsertLeave * call s:on_insert_leave()

function! s:on_insert_leave()
  if &updatetime < s:update_time_save
    let &updatetime = s:update_time_save
  endif
endfunction


"Jump to the last known valid cursor position
 autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endi

 
"------------------------------------------------------------------------------
" Credits and Isnpiration -
" Ryan Tomayko
" Drew Neil
" Derek Wyatt
" http://vim.spf13.com/
" etc.
