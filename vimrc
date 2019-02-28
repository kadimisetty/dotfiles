" Vim Configuration File
" vim: foldmethod=marker:foldlevel=0:nofoldenable:


"PLUGINS {{{1
"Vim-Plug {{{2
call plug#begin('~/.vim/plugged')

"Plugins {{{2
"Active Plugins {{{3
Plug 'airblade/vim-gitgutter'
Plug 'altercation/vim-colors-solarized'
Plug 'bps/vim-textobj-python'
Plug 'chrisbra/NrrwRgn'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'godlygeek/tabular'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-user'
Plug 'mattn/emmet-vim'
Plug 'mxw/vim-jsx'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'pangloss/vim-javascript'
Plug 'romainl/vim-cool'
Plug 'styled-components/vim-styled-components'
Plug 'tomtom/tcomment_vim' "Does embedded filetypes unlike tpope/vim-commentary
Plug 'tpope/tpope-vim-abolish'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'w0rp/ale'

" vim-prettier installs it's own prettier with npm. 
" Also enable for listed formats
Plug 'prettier/vim-prettier', { 'do': 'npm install' }

"Inactive Plugins {{{3
"Plug 'tpope/vim-commentary'

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
set laststatus=2        "Always display a status line, even with only 1 window
set mousehide           "Hide mouse pointer while typing
set mouse=a             "Automatically detect mouse usage
set history=500         "Remember 500 items in history
set showcmd             "Show partial command in the last line at the bottom

"Use external program [`par`](http://www.nicemice.net/par/) to format paragraphs
"gwip will still use vim's own formatprg
set formatprg=par\ -w50

"Expect vim modelines in the first 3 lines (3 to allow for encoding, title)
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
  " make and yaml files are particular about whitespace syntax
  autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
  autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
  " Treat .rss files as XML. Place before encoding.
  autocmd BufNewFile,BufRead *.rss setfiletype xml
  " Customisations based on preferences
  autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType javascript setlocal ts=2 sts=2 sw=2 noexpandtab
endif


"INDENTS & FOLDS {{{1
" Vi Folding Specifics {{{2
augroup ft_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
    autocmd FileType help setlocal textwidth=78
    autocmd BufWinEnter *.txt if &ft == 'help' | wincmd L | endif
    
    "Use md for markdown instead of the default module2
    autocmd BufNewFile,BufRead *.md  setf markdown
augroup END
set nofoldenable            "Disable Folds by deafult
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
set shiftround              "Round indent to multiple of 'shiftwidth'
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

"Custom Fold Title {{{2
function! NeatFoldText()
  let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
  let lines_count = v:foldend - v:foldstart + 1
  let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' '
  let foldchar = matchstr(&fillchars, 'fold:\zs.')
  let foldtextstart = strpart('⨁ ' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
  let foldtextend = lines_count_text . repeat(' ', 8)
  let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
  return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
endfunction
set foldtext=NeatFoldText()


"UI CHANGES {{{1
set number              "Display line numbers
set ruler               "Display line number and cursor position
set nostartofline       "Do not shift cursor back to line beginning while scrolling
set report=0            "Threshold for number of lines changed
set ch=2                "Command line height(1 is default)
set nolazyredraw        "Redraw screen while executing macros, registers, untyped commands etc.
set showmatch           "When cursor is on bracket, briefly jump to coupled bracket
set mat=5               "Spend this much time switching the cursor to the coupled bracket
set visualbell          "Show a visual indication instead of ringing an annoying bell.
set formatoptions+=n    "Support lists (numbered, bulleted)
set virtualedit=block   "Allow cursor to go to invalid places only in visually selected blocks
set wildmode=full       "Tab-Completion ala zsh

"Change cursor shape specifically in iTerm
"https://hamberg.no/erlend/posts/2014-03-09-change-vim-cursor-in-iterm.html
if $TERM_PROGRAM =~ "iTerm"
    let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
    let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
    let &t_SR = "\<esc>]50;CursorShape=2\x7" " Underline in replace mode
endif

"Show error messages and throw exceptions
" set debug=msg,throw

"Show ellipsis on a soft break
set showbreak=…

set synmaxcol=2048      "For performance, only do syntax highlight upto these columns
set nocursorline        "Highlight the screen line of cursor
set nocursorcolumn      "Highlight the screen column of cursor

set splitbelow          "Position newly split windows to thebelow
set splitright          "Position newly split windows to the right

syntax enable           "Enable Syntax highlighting

"Use ColorScheme Dark Solarized
set background=dark
colorscheme solarized

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
"Move focus to previous window. (Currently yeidling to Ctrl-P Plugin)
" nnoremap <silent> <C-p> :wincmd p<CR>         

"Window Splits {{{2
"Equal size windows
nnoremap <silent> <leader>w= :wincmd =<CR>    
"Split window horizontally
nnoremap <silent> <leader>sh :split<CR>       
"Split window vertically
nnoremap <silent> <leader>sv :vsplit<CR>      


"MAPPINGS {{{1
"In Command line, make <C-p> and <C-n> behave like <Up> and <Down> {{{2
" cnoremap <C-p> <Up>
" cnoremap <C-n> <Down>

" Save with Ctrl-S {{{2
noremap <C-S>      :update<CR>
vnoremap <C-S>     <C-C>:update<CR>
inoremap <C-S>     <C-O>:update<CR>

"Move across "softly-wrapped" lines {{{2
"<D> is the OSX Command Key
nnoremap <D-j> gj
nnoremap <D-k> gk
nnoremap <D-4> g$
nnoremap <D-6> g^
nnoremap <D-0> g^
vnoremap <D-j> gj
vnoremap <D-k> gk
vnoremap <D-4> g$
vnoremap <D-6> g^
vnoremap <D-0> g^


"HANDY FUNCTIONS {{{1
"Make environment writing friendly {{{2
func! WriteMode() 
  setlocal formatoptions=1 
  setlocal noexpandtab 
  "gj and gk move with wrapped lines
  map j gj i
  map k gk
  "Set spelling dictionry to US
  setlocal spell spelllang=en_us 
  set complete+=s
  "Use external program `par` to format paragraph
  set formatprg=par
  setlocal wrap 
  setlocal linebreak 
endfu 
com! WP call WriteMode()

" Run current buffer through a python interpreter {{{2
" <S-e> is Shift-E
" TODO - Accomodate both 3.x(default) and 2.7
" TODO - Run only selection
" map <buffer> <S-e> :w<CR>:!/usr/bin/env python3 % <CR>

" Initialise new files with corresponding skeleton templates {{{2
if has("autocmd")
    autocmd BufNewFile * silent! 0r ~/.vim/templates/skeleton.%:e
endif

" Jump to the last known valid cursor position {{{2
if has("autocmd")
     autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \   exe "normal g`\"" |
            \ endif
 endif


"PLUGINS PREFERENCES {{{1
"netrw {{{2
let g:netrw_banner=0

"Prettier {{{2
" max line length that prettier will wrap on
let g:prettier#config#print_width = 60
"Don't change focus to quickfix window on errors
" let g:prettier#quickfix_auto_focus = 1

"ALE {{{2
"Lint after leading Insert Mode. Off by Default
let g:ale_lint_on_insert_leave = 1
"Lint only on save 
" let g:ale_lint_on_save = 1
let g:ale_sign_error = '●'
let g:ale_sign_warning = '⚠'
let g:ale_fixers = {
\  'javascript': ['eslint'],
\}

"Ctrl-P {{{2
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'
"Ignore Files in .gitignore
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
let g:ctrlp_mruf_exclude = '/tmp/.*\|/temp/.*' " MacOSX/Linux
"TODO: Customise CtrlP Status window 
" Intent - Include instruction "Use <C-F> to select next mode"
" Example - https://gist.github.com/kien/1610859

"Airline {{{2
let g:airline_theme='solarized'
" let g:airline_statusline_ontop=1 "Show Airline tabbar at the top
" let g:airline_extensions = [] "Stop all Airline Extensions

" Initialize Airline Symbols if not created. 
" Avoid overwriting existing Airline symbols
if !exists('g:airline_symbols') 
  let g:airline_symbols = {}    
endif                           
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#show_close_button = 1
let g:airline#extensions#tabline#close_symbol = '×'
let g:airline#extensions#tabline#show_tab_nr = 1

"Airline support for CtrlP. Select mode colors to use in CtrlP window 
"(Only effective if active airline theme doesn't define ctrlp colors)
let g:airline#extensions#ctrlp#color_template = 'insert' "(default)
let g:airline#extensions#ctrlp#color_template = 'normal'
let g:airline#extensions#ctrlp#color_template = 'visual'
let g:airline#extensions#ctrlp#color_template = 'replace'
"Within CtrlP window show the previous and next modes (mru, buffer, etc.)
" To switch through those modes use forward: <C-f> and backward <C-d> 
let g:airline#extensions#ctrlp#show_adjacent_modes = 1

"pangloss/vim-javascript {{{2
"Enable Concealing
set conceallevel=1
"Conceal corresponding keywords with symbols
let g:javascript_conceal_arrow_function = "⇒"
let g:javascript_conceal_function = "ƒ"


"CREDITS & INSPIRATION {{{1
"Author:Sri Kadimisetty 
"External Inspirations:
"Tim Pope (of course)
"Ryan Tomayko
"Drew Neil
"Derek Wyatt
"Gary Bernhardt
"http://vim.spf13.com/
"github.com/joshcom/vimconfig/
"blog.sanctum.geek.nz/page/2/
"http://dhruvasagar.com/2013/03/28/vim-better-foldtext
