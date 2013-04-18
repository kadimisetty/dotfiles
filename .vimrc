".vimrc file
"Compiled by Sri Kadimisetty.
"Credits listed at the bottom.


set nocompatible                          "Behave like a grown-up Vim. You are not vi anymore.


"VUNDLE ----------------------------------------------------------------------
"Vundle is a *package manager* for vim bundles compatible with Pathogen
"Information and instructions available at - https://github.com/gmarik/vundle

"Vundle Vim package installation preferences require following
"to be in this order and location (and before bundles being listed).
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

"Install Vundle
Bundle 'gmarik/vundle' 

"Active Bundles
Bundle 'altercation/vim-colors-solarized'
Bundle 'mutewinter/vim-indent-guides'
Bundle 'vim-scripts/YankRing.vim'
Bundle 'sophacles/vim-processing'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'Lokaltog/vim-powerline'
Bundle 'Shougo/neocomplcache'
Bundle 'tpope/vim-commentary'
Bundle 'gregsexton/MatchTag'
Bundle 'groenewege/vim-less'
Bundle 'vimez/vim-showmarks'
Bundle 'tpope/vim-obsession'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'godlygeek/tabular' 
Bundle 'tpope/vim-abolish'
Bundle 'tpope/vim-endwise'
Bundle 'klen/python-mode'
Bundle 'sjl/vitality.vim'
Bundle 'applescript.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'sjl/gundo.vim'

"Inactive Bundles
"Bundle 'kana/vim-textobj-entire' "@TODO - Fix error or file bug report
"Bundle 'Valloric/YouCompleteMe'
"Bundle 'myusuf3/numbers.vim'
"Bundle 'wincent/Command-T'
"Bundle 'majutsushi/tagbar'
"Bundle 'textobj-entire'
"Bundle 'Python-Syntax'

"Needs to be turned back on right here after done setting up Vundle
filetype on                                 "Detect filetypes
filetype plugin on                          "Activate builtin set of filetypes plugins
filetype indent on                          "Activate builtin and computed indentations


"SEARCH ---------------------------------------------------------------------
set infercase                               "Infer case matching while doing keyword completions
set ignorecase                              "Case Insensitive Search
set hlsearch                                "For non-case sensitive search
set smartcase                               "Perform case-detection slightly more sensibly
set wrapscan                                "Wrap search scan around the file
set incsearch                               "Match search incrementally

"Ignore these file patterns while completing file/dir names
set wildignore+=*.o,*.obj,*.exe,*.so,*.dll,*.pyc,.svn,.hg,.bzr,.git,
  \.sass-cache,*.class,*.scssc,*.cssc,sprockets%*,*.lessc


"MISC PREFERENCES -----------------------------------------------------------
syntax on                                   "Turn on syntax highlighting
set hidden                                  "Unsaved bufers are allowed to move to the background
set showmode                                "Show current modeline

set key=                                    "Disable encryption by making the key empty
set autoread                                "Sync loaded file to changes on disk

set backspace=indent,eol,start              "Allow backspace to work in the insert mode
set cpoptions+=$                            "When making a change to one line , show a $ at end of changed text

"Set status line akin to Derek Wyatt's preference - http://www.derekwyatt.org/vim/the-vimrc-file/better-settings/
set stl=%f\ %m\ %r\ Line:\ %l/%L[%p%%]\ Col:\ %c\ Buf:\ #%n\ [%b][0x%B]
set laststatus=2                            "Always display a status line, even when there's just 1 window
set mousehide                               "Hide mouse pointer while typing
set mouse=a                                 "Automatically detect mouse usage
set history=500                             "Remember 500 items in history

"Folds
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

set cindent                                 "Use C's indenting rules
set smarttab                                "Insert bkanks according to listed shiftwidth/tabstop/softtabstop
set expandtab                               "Use appropriate number of spaces to insert a tab when autodindent is on
set pastetoggle=<F12>                       "Same indentation on pastes

set cf                                      "Allow error files and error jumping
scriptencoding  utf-8                       "Set character encoding in the scri[t
set timeoutlen=350                          "Wait for this long anticipating for a command

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


"UI CHANGES------------------------------------------------------------------
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
set wildmode=longest,list                   "Tab-Completion ala emacs

set debug=msg,throw                         "Show error messages and throw exceptions

set synmaxcol=2048                          "For performance, only do syntax highlight upto these columns
set nocursorline                            "Highlight the screen line of cursor
set nocursorcolumn                          "Highlight the screen column of cursor
syntax enable                               "Enable Syntax highlighting

"set background=light                       "Use a theme with a light background 
set background=dark                         "Use a theme with a dark background 
colorscheme solarized                       "Turn on solarized colorscheme (solarized is not a builtin theme)

set splitbelow                              "Position newly split windows to thebelow
set splitright                              "Position newly split windows to the right



"Remove trailing whitespaces and ^M characters
if has ("autocmd")
    autocmd FileType c,cpp,java,php,js,python,twig,xml,yml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))
endif

"LEADERS --------------------------------------------------------------------
" let mapleader = ","
" Use default leader and leave the comma for search traversal
"Leave leader as default \ instead of popular , to let , be a seach movement.

"TYPOS AND ALIASES-----------------------------------------------------------
command! W w
command! Q q

"Retain visual selection after an indentation shift.
vnoremap < <gv
vnoremap > >gv

"Yank to end of line, just like C or D
nnoremap Y y$                             

"Toggle spelling mode 
nmap <silent> <leader>ss :set spell!<CR>   
"Edit vimrc 
nmap <silent> <leader>v :edit $MYVIMRC<CR>   

"QUICKFIX WINDOW--------------------------------------------------------------
" Toggle the Quickfix window
map <silent> <leader>q :QFix<CR>          
" Jump to the next tab
map <C-c>n :cnext<CR>                     
" Jump to previous tab
map <C-c>p :cprevious<CR>                 


"MOVEMENT --------------------------------------------------------------------

"Switch between Tab Pages
nnoremap <silent> [t :tabprevious<CR>
nnoremap <silent> ]t :tabnext<CR>
nnoremap <silent> [t :tabfirst<CR>
nnoremap <silent> ]t :tablast<CR>
"Start editing in a new tab page
"nmap <leader>te :tabedit

"Switching between Buffers
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>


"Window Movement
"Move focus to window facing h
nmap <silent> <C-h> :wincmd h<CR>         
"Move focus to window facing j 
nmap <silent> <C-j> :wincmd j<CR>         
"Move focus to window facing k
nmap <silent> <C-k> :wincmd k<CR>         
"Move focus to window facing l
nmap <silent> <C-l> :wincmd l<CR>         
"Move focus to previous window
nmap <silent> <C-p> :wincmd p<CR>         

"Window Splits
"Equal size windows
nmap <silent> <leader>w= :wincmd =<CR>    
"Split window horizontally
nmap <silent> <leader>sh :split<CR>       
"Split window vertically
nmap <silent> <leader>sv :vsplit<CR>      


"MAPPINGS -------------------------------------------------------------------
"Make <C-p> and <C-n> behave like <Up> and <Down>; else they do not filter
"command line history
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>




"HANDY MACROS ---------------------------------------------------------------
" Execute current ruby line when there is a # => marker at the end replacing it with the evaled result
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


" Initialise known file formats with my own starter templates in this location
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

"Source vimrc after every save
"if has ("autocmd")
"    autocmd BufWritePost .vimrc source $MYVIMRC
"endif


"PLUGINS PREFS --------------------------------------------------------------
"Powerline
let g:Powerline_symbols = 'fancy'
set fillchars+=stl:\ ,stlnc:\

"TagBar
nnoremap <silent> <leader>tt :TagbarToggle<CR>

"Neocachecompl
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


 " Indent if we're at the beginning of a line. Else, do completion.
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

"Ctrl-P
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


"CREDITS & INSPIRATION ------------------------------------------------------
" Tim Pope (ofcourse)
" Ryan Tomayko
" Drew Neil
" Derek Wyatt
" Gary Bernhardt
" http://vim.spf13.com/
" github.com/joshcom/vimconfig/
" etc.
