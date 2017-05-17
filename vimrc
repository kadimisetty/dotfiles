" Vim Configuration File
" vim: foldmethod=marker:foldlevel=0:nofoldenable:

"PLUGINS {{{1
"Vim-Plug {{{2
call plug#begin('~/.vim/plugged')

"Plugins {{{2
"Inactive Plugins {{{3
"Active Plugins {{{3
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-markdown'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'gregsexton/MatchTag'

"Finish Vim-Plug
call plug#end()


"SEARCH {{{1
set infercase       "Infer case matching while doing keyword completions
set ignorecase      "Case insensitive Search
set hlsearch        "For non-case sensitive search
set smartcase       "Perform case-detection slightly more sensibly
set wrapscan        "Wrap search scan around the file
set incsearch       "Match search incrementally

"Ignore these file patterns while completing file/dir names
set wildignore+=*.o,*.obj,*.exe,*.so,*.dll,*.pyc,
            \.svn,.hg,.bzr,.git,
            \.sass-cache,*.class,*.scssc,*.cssc,sprockets%*,*.lessc


"MISC PREFERENCES {{{1
syntax on               "Turn on syntax highlighting
set hidden              "Unsaved bufers are allowed to move to the background
set showmode            "Show current modeline
set autoread            "Sync loaded file to changes on disk
set laststatus=2        "Always display a status line, even when there's just 1 window
set mousehide           "Hide mouse pointer while typing
set mouse=a             "Automatically detect mouse usage
set history=500         "Remember 500 items in history
set showcmd             "Show partial command in the last line at the bottom

"Use the external program [`par`](http://www.nicemice.net/par/) to format paragraphs
"gwip will still use vim's own formatprg
set formatprg=par\ -w50

"Look for vim modelines in the first 3 lines of a file(3 to allow for encoding, title)
set modeline
set modelines=3

" Session preferences. Do not save some options into the sessions file, so
" they dont override any vimrc changes made when the session is revoked later.
set ssop-=options       "Dont store global and local values into session file
set ssop-=folds         "Dont store folds into session file


"FILETYPE PREFERENCES {{{1
" Filetype settings {{{2
filetype on             "Detect filetypes
filetype plugin on      "Activate builtin set of filetypes plugins
filetype indent on      "Activate builtin and computed indentations

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
  " Treat .rss files as XML. Place bfore encoding.
  autocmd BufNewFile,BufRead *.rss setfiletype xml
endif

" Vi Folding Specifics {{{2
augroup ft_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
    autocmd FileType help setlocal textwidth=78
    autocmd BufWinEnter *.txt if &ft == 'help' | wincmd L | endif
    
    "Use md for markdown instead of the default module2
    autocmd BufNewFile,BufRead *.md  setf markdown
augroup END


"INDENTS & FOLDS {{{1
set foldopen=block,insert,jump,mark,percent,quickfix,search,tag,undo
set foldmethod=syntax
set foldlevelstart=1
let javaScript_fold=1       "JavaScript
let perl_fold=1             "Perl
let php_folding=1           "PHP
let r_syntax_folding=1      "R
let ruby_fold=1             "Ruby
let sh_fold_enabled=1       "sh
let vimsyn_folding='af'     "Vim script
let xml_syntax_folding=1    "XML

set scrolloff=3             "Keep cursor these many lines above bottom of screen
set nowrap                  "Wrap Long lines
set autoindent              "Indent as previous line
set softtabstop=4
set shiftwidth=4            "Use indents as length of 4 spaces
set tabstop=4               "A tab counts for these many spaces
set backspace=2             "Make backspace behave more like the popular usage

"Enables :Wrap to set settings required for soft wrap
command! -nargs=* Wrap set wrap linebreak nolist

set cindent                 "Use C's indenting rules
set smarttab                "Insert bkanks according to listed shiftwidth/tabstop/softtabstop
set expandtab               "Use appropriate number of spaces to insert a tab when autodindent is on
set pastetoggle=<F12>       "Same indentation on pastes

set cf                      "Allow error files and error jumping
set timeoutlen=350          "Wait for this long anticipating for a command

scriptencoding  utf-8       "Set character encoding in the script. Place before encoding.
set encoding=utf-8          "Set default file encoding to UTF-8
set title                   "Enable setting title
set wildmenu                "Perform things like menu completion with wildchar(often tab) etc.
set iskeyword+=_,$,@,%,#,-  "Treat as keywords

set backup                  "Make a backup before writing the file
set backupdir=~/.vim/backup "Use this directory to store backups
set directory=/tmp/         "List of directory names to create the swp files in
set backupcopy=yes          "Make a backup and then overwrite orginal file
set backupskip=/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*

set printoptions=header:0,duplex:long,paper:A4



"UI CHANGES {{{1
set number                          "Display line numbers
set ruler                           "Display line nujmber and cursor position
set nostartofline                   "Do not shift cursor back to line beginning while scrolling
set report=0                        "Threshold for number of lines changed
set ch=2                            "Command line height(1 is default)
set nolazyredraw                    "Redraw screen while executing macros, registers, untyped commands etc.
set showmatch                       "When cursor is on bracket, briefly jump to coupled bracket
set mat=5                           "Spend this much time switching the cursor to the coupled bracket
set visualbell                      "Show a visual indication instead of ringing an annoying bell.
set formatoptions+=n                "Support lists (numbered, bulleted)
set virtualedit=block               "Allow cursor to go to invalid places only in visually selected blocks
set wildmode=full                   "Tab-Completion ala zsh

set debug=msg,throw                 "Show error messages and throw exceptions

"Show ellipsis on a soft break
set showbreak=…

set synmaxcol=2048                  "For performance, only do syntax highlight upto these columns
set nocursorline                    "Highlight the screen line of cursor
set nocursorcolumn                  "Highlight the screen column of cursor
syntax enable                       "Enable Syntax highlighting

set background=dark                 "Use a theme with a dark background 

set splitbelow                      "Position newly split windows to thebelow
set splitright                      "Position newly split windows to the right

"Remove trailing whitespaces and ^M characters {{{2
augroup WhiteSpaceCleaner
    autocmd!
    autocmd FileType c,cpp,java,php,js,python,twig,xml,yml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))
augroup END


"ABBREVIATIONS, TYPOS, ALIASES & CONCEALS {{{1
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


"MOVEMENT {{{1
"Tab Pages Movement {{{2
" Move between tabs with just the <Tab> key
nnoremap <Tab>      :tabnext<CR>
nnoremap <S-Tab>    :tabprevious<CR>


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
"In Command line, make <C-p> and <C-n> behave like <Up> and <Down> {{{2
" else they do not filter command line history
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" Save with Ctrl-S {{{2
noremap <C-S>      :update<CR>
vnoremap <C-S>     <C-C>:update<CR>
inoremap <C-S>     <C-O>:update<CR>

"Move across "softly-wrapped" lines {{{2
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
"Make a "Word Proessor" writing environment {{{2
func! WordProcessorMode() 
  " set thesaurus+=/Users/sbrown/.vim/thesaurus/mthesaur.txt
  setlocal formatoptions=1 
  setlocal noexpandtab 
  map j gj 
  map k gk
  setlocal spell spelllang=en_us 
  set complete+=s
  set formatprg=par
  setlocal wrap 
  setlocal linebreak 
endfu 
com! WP call WordProcessorMode()

" Run  current buffer through a python interpreter {{{2
" TODO - Accomodate both python versions
map <buffer> <S-e> :w<CR>:!/usr/bin/env python % <CR>

" Initialise known file formats with my own starter templates {{{2
if has("autocmd")
    " TODO - Create these templates
    " autocmd BufNewFile * silent! 0r ~/.vim/templates/template.%:e
endif

" Jump to the last known valid cursor position {{{2
if has("autocmd")
     autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \   exe "normal g`\"" |
            \ endif
 endif


"PLUGINS PREFS {{{1
"netrw {{{2
let g:netrw_banner=0

"Airline {{{@
let g:airline_theme='solarized'

let g:airline_symbols = {}
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#show_close_button = 1
let g:airline#extensions#tabline#close_symbol = '×'
let g:airline#extensions#tabline#show_tab_nr = 1

"Ctrl-P {{{2
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'


"CREDITS & INSPIRATION {{{1
"Author:Sri Kadimisetty 
"Tim Pope (of course)
"Ryan Tomayko
"Drew Neil
"Derek Wyatt
"Gary Bernhardt
"http://vim.spf13.com/
"github.com/joshcom/vimconfig/
"blog.sanctum.geek.nz/page/2/