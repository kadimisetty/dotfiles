
" Credit: Derek Wyatt, http://vim.spf13.com/
"
"
"
"Not compatible with vi
set nocompatible


"-VUNDLE--BEGIN------------------------------------
"Vundle Installation - needs to be in this exact location
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'


"Vundle Packages
Bundle 'tpope/vim-fugitive'
Bundle 'altercation/vim-colors-solarized'
Bundle 'Lokaltog/vim-powerline'
Bundle 'mutewinter/vim-indent-guides'
Bundle 'tpope/vim-surround.git'
Bundle 'gregsexton/MatchTag'
Bundle 'myusuf3/numbers.vim'
Bundle 'Shougo/neocomplcache'
Bundle 'godlygeek/tabular.git'
Bundle 'groenewege/vim-less'


"-VUNDLE--END--------------------------------------





"Turn on filetypes etc.
filetype on
filetype plugin on
filetype indent on

"Turn on syntax highlighting
syntax on

"Hide buffers
set hidden

"Show current mode
set showmode



"SEARCH------------------------------------------------------------------------
"Case Insensitive Search
set ignorecase
"For non-case sensitive search
set hlsearch
set smartcase
"Wrap search scan around the file
set wrapscan
"Match search incrementally
set incsearch
set wildignore+=*.o,*.obj,*.exe,*.so,*.dll,*.pyc,.svn,.hg,.bzr,.git,
  \.sass-cache,*.class,*.scssc,*.cssc,sprockets%*,*.lessc



"Allow backspace over indent. eol, start-of-insert
set backspace=2

set cpoptions+=$


"set status line according to Derek Wyatt's preference
set stl=%f\ %m\ %r\ Line:\ %l/%L[%p%%]\ Col:\ %c\ Buf:\ #%n\ [%b][0x%B]


"Always display a status line, even for just one window
set laststatus=2


"Hide mouse pointer while typing
set mousehide

"Automatically detect mouse usage
set mouse=a

"Remeber 500 items in history
set history=500

"Handle folding
set foldopen=block,insert,jump,mark,percent,quickfix,search,tag,undo


"While scrolling keep cursor atleast these many lines above the bottom
set scrolloff=3

"Cursor is allowed to go to invalid places
"set virtualedit=all


"Wrap Long lines
set nowrap

"Indent as previous line
set autoindent
"Use indents as length of 4 spaces
set shiftwidth=2
set tabstop=2
"Delete everythong with backspace
set backspace=2
set cindent
set smarttab
set expandtab

"Same indentation on pastes
set pastetoggle=<F12>

"Remove trailing whitespaces and ^M characters
autocmd FileType c,cpp,java,php,js,python,twig,xml,yml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))


"Allow error files and error jumping
set cf


"Set leader to ,
let mapleader = ","

"time to wait for a command
set timeoutlen=350



"Encoding & small UI adjustments
set encoding=utf-8
set number
set ruler
set title
set wildmenu


"Fixing typos
command! W w
command! Q q

"" Toggle spelling mode with ,s
nmap <silent> <leader>s :set spell!<CR>
" Edit vimrc with ,v
nmap <silent> <leader>v :e ~/vimrc<CR>


"Initialise known file formats with my own starter templates in this location
if has("autocmd")
    autocmd BufNewFile * silent! 0r ~/.vim/templates/template.%:e
endif

"Turn on solarized colorscheme
syntax enable
set background=dark
"set background=light
colorscheme solarized


"Powerline

let g:Powerline_symbols = 'fancy'
set fillchars+=stl:\ ,stlnc:\


"Backups
set backup
set backupdir=~/.vim/backup
set directory=~/.vim/tmp



" Window Movement
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-l> :wincmd l<CR>
" Previous Window
nmap <silent> <C-p> :wincmd p<CR>

" Equal Size Windows
nmap <silent> <leader>w= :wincmd =<CR>

" Window Splitting
nmap <silent> <leader>sh :split<CR>
nmap <silent> <leader>sv :vsplit<CR>


" Plugin--Neocachecompl
let g:neocomplcache_enable_at_startup=1
let g:neocomplcache_enable_auto_select=1 "Select the first entry automatically
let g:neocomplcache_enable_cursor_hold_i=1
let g:neocomplcache_cursor_hold_i_time=300
let g:neocomplcache_auto_completion_start_length=1

" Tab / Shift-Tab to cycle completions
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"

" Required to make neocomplcache_cursor_hold_i_time work
" See https://github.com/Shougo/neocomplcache/issues/140
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
