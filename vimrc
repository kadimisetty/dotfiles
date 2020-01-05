" Vim Initialization File {{{1
" vim: foldmethod=marker:foldlevel=0:nofoldenable:
" Author: Sri Kadimisetty


"PLUGINS {{{1
"Start vim-plug
call plug#begin('~/.vim/plugged')

"Active Plugins (Run :sort! on this contiguous list after insertion){{{2
Plug 'Zaptic/elm-vim'
Plug 'airblade/vim-gitgutter'
Plug 'altercation/vim-colors-solarized'
Plug 'bps/vim-textobj-python'
Plug 'c-brenn/phoenix.vim'
Plug 'chrisbra/NrrwRgn'
Plug 'elixir-editors/vim-elixir'
Plug 'fatih/vim-go'
Plug 'hspec/hspec.vim'
Plug 'janko/vim-test'
Plug 'junegunn/gv.vim'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'junegunn/vim-easy-align'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-user'
Plug 'kassio/neoterm'
Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'
Plug 'mattn/emmet-vim'
Plug 'meck/vim-brittany'
Plug 'mhinz/vim-mix-format'
Plug 'mhinz/vim-startify'
Plug 'mmorearty/elixir-ctags'
Plug 'morhetz/gruvbox'
Plug 'mxw/vim-jsx'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neomake/neomake'
Plug 'neovimhaskell/haskell-vim'
Plug 'pangloss/vim-javascript'
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
Plug 'python/black'
Plug 'rizzatti/dash.vim'
Plug 'romainl/vim-cool'
Plug 'rstacruz/vim-closer'
Plug 'simnalamburt/vim-mundo'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'tomtom/tcomment_vim' "Does embedded filetypes unlike tpope/vim-commentary
Plug 'tpope/tpope-vim-abolish'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-liquid'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'vim-airline/vim-airline'

"NERDTree. Save order.
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

"vim-prettier installs it's own prettier with npm.
"Also enable for listed formats
Plug 'prettier/vim-prettier', { 'do': 'npm install' }

"Uses external fzf installed via homebrew. Save order.
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

"Projections. Save order.
Plug 'tpope/vim-projectionist'
Plug 'c-brenn/fuzzy-projectionist.vim'

"Tabular and Markdown. Save order.
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown' "Put after dependency - 'godlygeek/tabular'

"Vim-Devicons. Load as last plugin
Plug 'ryanoasis/vim-devicons' "Requires encoding utf-8. Set as such elsewhere.


"Inactive Plugins {{{2
"Plug 'tpope/vim-commentary'
"Plug 'tpope/vim-markdown'
"Plug 'w0rp/ale' "Drags down vim when used with elixir

"Finish vim-plug
call plug#end()


"SEARCH {{{1
set infercase       "Infer case matching while doing keyword completions
set ignorecase      "Case insensitive Search
set hlsearch        "For non-case sensitive search
set smartcase       "Perform case-detection slightly more sensibly
set wrapscan        "Wrap search scan around the file
set incsearch       "Match search incrementally


"MISC PREFERENCES {{{1
"Leaders {{{2
let mapleader = '\'
let maplocalleader = '\\'

"Wildignore {{{2
"Ignore these file patterns while completing file/dir names
"(Also used by plugins like CtrlP, NERDTree etc.)

"Ignoring: Usual culprits
set wildignore+=*.o,*.obj,*.exe,*.so,*.dll,*.pyc

"Ignoring: Source Control
set wildignore+=.svn,.hg,.bzr,.git,.git/*

"Ignoring: CSS Preprocessors
set wildignore+=.sass-cache,*.class,*.scssc,*.cssc,

"Ignoring: JS & Node
set wildignore+=.sass-cache,*.class,*.scssc,*.cssc,

"Ignoring: Elixir Mix & Phoenix etc.
set wildignore+=*/_build/*,*/cover/*,*/deps/*,*/.fetch/*,erl_crash.dump,mix.lock
set wildignore+=*.ez,*.beam,*/config/*.secret.exs,.elixir_ls/*

"Ignoring: Python Projects
set wildignore+=.ropeproject,__pycache__,*.egg-info,.DS_Store

"Encodings {{{2
scriptencoding  utf-8       "Set character encoding in the script. Place before encoding.
set encoding=utf-8          "Set default file encoding to UTF-8
set title                   "Enable setting title

"Completions & Ignores {{{2
set wildmenu                "Perform things like menu completion with wildchar(often tab) etc.
set iskeyword+=_,$,@,%,#,-  "Treat as keywords

set printoptions=header:0,duplex:long,paper:A4

"Diffs {{{2
"open diffs in vertical split
set diffopt+=vertical

"Misc {{{2
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

set completeopt=menu,menuone,noinsert,preview
" Session preferences. Do not save some options into the sessions file, so
" they dont override any vimrc changes made when the session is revoked later.
set ssop-=options       "Dont store global and local values into session file
set ssop-=folds         "Dont store folds into session file


"FILETYPE PREFERENCES {{{1
" Filetype settings {{{2
filetype on             "Detect filetypes
filetype plugin on      "Activate builtin set of filetypes plugins
filetype indent on      "Activate builtin and computed indentations

"Set Tabs & Spaces for common filetyes {{{2
"TODO - Use a plugin for this
" Only do this part when compiled with support for autocommands

augroup filetype_rss
    autocmd!
    " Treat .rss files as XML. Place before encoding.
    autocmd BufNewFile,BufRead *.rss setfiletype xml
augroup end

augroup filetype_md
    autocmd!
    "Use md for markdown instead of the default module2
    autocmd BufNewFile,BufRead *.md  setfiletype markdown
augroup end

augroup filetype_help
    autocmd!
    autocmd FileType help setlocal textwidth=78
    autocmd BufWinEnter *.txt call MoveHelpToNewTab()
augroup end
function MoveHelpToNewTab ()
    if &buftype ==# 'help' | wincmd T | endif
endfunction


"INDENTS & FOLDS {{{1
"Vi Folding Specifics {{{2
augroup foldmethod_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup end

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

"Wraps & Indents {{{2
"Enables :Wrap to set settings required for soft wrap
command! -nargs=* Wrap set wrap linebreak nolist

set cindent                 "Use C's indenting rules
set smarttab                "Insert bkanks according to listed shiftwidth/tabstop/softtabstop
set expandtab               "Use appropriate number of spaces to insert a tab when autodindent is on
set pastetoggle=<F12>       "Same indentation on pastes

set cf                      "Allow error files and error jumping
set timeoutlen=350          "Wait for this long anticipating for a command

"Backup Preferences {{{2
set backup                  "Make a backup before writing the file
set backupdir=~/.vim/backup "Use this directory to store backups
set directory=/tmp/         "List of directory names to create the swp files in
set backupcopy=yes          "Make a backup and then overwrite orginal file
set backupskip=/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*


"UI CHANGES {{{1
"Misc {{{2
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

"Title {{{2
set title
set titleold="Terminal"
if has('statusline')
    "Clear title string
    set titlestring=
    "Show + if file has been modified
    set titlestring+=%M
    "Show base filename
    set titlestring+=%f
    "Show [help] if help window
    set titlestring+=%h
    "Show [RO] if read-only
    set titlestring+=%r
    "Show [Preview] if preview window
    set titlestring+=%w
endif

"Change Cursor Shape based on Mode {{{2
"Terminal Escape Sequence Numbers for Cursor Shapes
"0, 1 or none - Blink Block (Default)
"2 - Steady Block
"3 - Blink Underline
"4 - Steady Underline
"6 - Steady Vertical Bar
if $TERM_PROGRAM =~ "Apple_Terminal"
    let &t_SI="\033[6 q" "Vertical bar in Insert mode
    let &t_SR="\033[4 q" "Underline in Replace mode
    let &t_EI="\033[2 q" "Steady Block in Normal mode
elseif $TERM_PROGRAM =~ "Hyper"
    let &t_SI="\033[6 q" "Vertical bar in Insert mode
    let &t_SR="\033[4 q" "Underline in Replace mode
    let &t_EI="\033[2 q" "Steady Block in Normal mode
elseif $TERM_PROGRAM =~ "iTerm"
    "iTerm cursors look much better, especially contrast on hover.
    "https://hamberg.no/erlend/posts/2014-03-09-change-vim-cursor-in-iterm.html
    let &t_SI = "\<Esc>]50;CursorShape=1\x7" "Vertical bar in Insert mode
    let &t_EI = "\<Esc>]50;CursorShape=0\x7" "Steady Block in Normal mode
    let &t_SR = "\<esc>]50;CursorShape=2\x7" "Underline in Replace mode
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
colorscheme gruvbox

"Whitespace & Other Special Characters {{{2
set scrolloff=1             "Keep cursor these many lines above bottom of screen
set nowrap                  "Wrap Long lines
set autoindent              "Indent as previous line
set softtabstop=4
set shiftwidth=4            "Use indents as length of 4 spaces
set shiftround              "Round indent to multiple of 'shiftwidth'
set tabstop=4               "A tab counts for these many spaces
set backspace=2             "Make backspace behave more like the popular usage

"Remove trailing whitespaces and ^M characters {{{3
"TODO - More filetypes
"TODO - Move into a plugin to support prefs eg. `confirmations` or `conditions`
augroup whitespace_preferences
    autocmd!
    filetype on
    " make and yaml files are particular about whitespace syntax
    autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
    autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
    " Customisations based on preferences
    autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType javascript setlocal ts=2 sts=2 sw=2 noexpandtab
augroup end
augroup whitespace_trailing
    autocmd!
    autocmd FileType c,cpp,java,php,js,twig,xml,yml,elm autocmd BufWritePre <buffer> call RemoveTrailingWhitespace()
augroup end
function RemoveTrailingWhitespace ()
     call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))
endfunction


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


"MOVEMENT {{{1
"Tab Pages Movement {{{2
" Move between tabs with just the <Tab> key
nnoremap <Tab>      :tabnext<CR>
nnoremap <S-Tab>    :tabprevious<CR>


"Window Movement {{{2
" Disabling Space movement because both <C-u> not <C-b> hinder text editing
" when they're triggered by mistake in insert mode by <S-Space> which seem to
" happen to often with me. <C-u> clears line back to input cursor and <C-b>
" insert a  character into text which confuses me temporarily.
" nnoremap <Space> <C-d>
" nnoremap <S-Space> <C-b>

"Window Focus {{{2
"Move focus to window facing h
nnoremap <silent> <C-h> :wincmd h<CR>
"Move focus to window facing j
nnoremap <silent> <C-j> :wincmd j<CR>
"Move focus to window facing k
nnoremap <silent> <C-k> :wincmd k<CR>
"Move focus to window facing l
nnoremap <silent> <C-l> :wincmd l<CR>
"Move focus to previous window. (Disabled for use by plugins like CtrlP, fzf etc.)
" nnoremap <silent> <C-p> :wincmd p<CR>

"Window Splits {{{2
"Equal size windows
nnoremap <silent> <leader>w= :wincmd =<CR>
"Split window horizontally
nnoremap <silent> <leader>sh :split<CR>
"Split window vertically
nnoremap <silent> <leader>sv :vsplit<CR>


"HANDY FUNCTIONS {{{1
"Make environment writing friendly {{{2
func! WriteMode()
  setlocal formatoptions=1
  setlocal noexpandtab
  "gj and gk move with wrapped lines
  map j gj
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
nnoremap <silent> <leader>w :call WriteMode()<CR>
" TODO - Make ToggleWriteMode


" Initialise new files with corresponding skeleton templates {{{2
augroup skeleton_files
    autocmd!
    autocmd BufNewFile * silent! 0r ~/.vim/templates/skeleton.%:e
augroup end

" Jump to the last known valid cursor position {{{2
augroup cursor_position
    autocmd!
    autocmd BufReadPost *
                \ if line("'\"") > 0 && line("'\"") <= line("$") |
                \   exe "normal g`\"" |
                \ endif
augroup end


"MAPPINGS {{{1

"Close helper windows {{{2
"Close all helper windows
nnoremap <leader>z  :pclose \| lclose<CR>
"Close Preview window quickly
nnoremap <leader>zp :pclose<CR>
"Close Location close quickly
nnoremap <leader>zl :lclose<CR>

"Edit vimrc
nnoremap <silent> <leader>v :edit $MYVIMRC<CR>

"Terminal {{{2
nnoremap <leader>tn :<c-u>rightbelow terminal<cr>

" Save with Ctrl-S {{{2
nnoremap <C-S>  :update<CR>
vnoremap <C-S>  <C-C>:update<CR>
inoremap <C-S>  <C-O>:update<CR>

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

"Flip cursorcolumn on demand {{2
"nnoremap <silent> <leader>c :setlocal cursorcolumn!<CR>
"Use shortcuts from 'tpope/vim-unimpaired' instead
"
"   ON    OFF     TOGGLE  OPTION
"   ----------------------------------------------------------------------
"   [oc   ]oc     yoc     'cursorline'
"   [ou   ]ou     you     'cursorcolumn'
"   [ox   ]ox     yox     'cursorline' 'cursorcolumn' (x as in crosshairs)
"
"NOTE: The mnemonic for y is that if you tilt it a bit it looks like a switch.


"PLUGINS PREFERENCES {{{1

"coc.nvim {{{2
" These suggestions are from Coc's README:

" Allow installed extensions
let g:coc_global_extensions = ['coc-elixir', 'coc-snippets']

" Use 300 as defauilt 4000 is toos slow for diagnostic messages
set updatetime=300

" Don't give |ins-completion-menu| messages like match 1 of 2, Pattern not found etc.
set shortmess+=c

" Map <tab> to trigger completion and navigate to the next item: >
" (Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin)
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()

" Map <tab> for trigger completion, completion confirm, snippet expand and jump
" like VSCode.
" Note: Needs `coc-snippets` extension
inoremap <silent><expr> <TAB>
    \ pumvisible() ? coc#_select_confirm() :
    \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
"TODO: convert this to toggle documentation
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" TODO: Change from :Format etc. to something else to avoid mental mnemonic clash my regular
" <localLdear>f for formats
" Use `:Format` to format current buffer
command! -nargs=0 CocFormat :call CocAction('format')
" Use `:Fold` to fold current buffer
command! -nargs=? CocFold :call CocAction('fold', <f-args>)
" use `:OR` for organize import of current buffer
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

"netrw {{{2
let g:netrw_banner=0

"Prettier {{{2
" max line length that prettier will wrap on
let g:prettier#config#print_width = 60
"Don't change focus to quickfix window on errors
" let g:prettier#quickfix_auto_focus = 1

"ALE {{{2
"Lint after leaving Insert Mode. Off by Default
let g:ale_lint_on_insert_leave = 1
"Lint only on save
" let g:ale_lint_on_save = 1
let g:ale_sign_error = '●'
let g:ale_sign_warning = '⚠'
"Enable ESLint(fixing and linting) only for JavaScript.
let g:ale_fixers = {'javascript': ['eslint']}
let g:ale_linters = {'javascript': ['eslint']}

"fzf {{{2
let g:fzf_command_prefix = 'F'
nnoremap <C-P>      :FFiles<CR>
nnoremap <C-P><C-G> :FGFiles<CR>
nnoremap <C-P><C-S> :FGFiles?<CR>
nnoremap <C-P><C-B> :FBuffers<CR>
nnoremap <C-P><C-R> :FRg<CR>
nnoremap <C-P><C-L> :FLines<CR>
nnoremap <C-P><C-W> :FWindows<CR>

"Airline {{{2
let g:airline_theme='gruvbox'

" Initialize Airline Symbols if not created.
" Avoid overwriting existing Airline symbols
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

"airline builtin extension - tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#tab_min_count = 2
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#tab_nr_type = 1 "Just tab number
let g:airline#extensions#tabline#show_tab_count = 0
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#show_close_button = 0

"airline gutentag extension
"Enable the airline gutentag extension
let g:airline#extensions#gutentags#enabled = 1

"airline coc-nvim exension
"Enable vim-airline integration. Comes with airline.
let g:airline#extensions#coc#enabled = 1

"pangloss/vim-javascript {{{2
"Enable Concealing
set conceallevel=1
"Conceal corresponding keywords with symbols
let g:javascript_conceal_arrow_function = "⇒"
let g:javascript_conceal_function = "ƒ"

"Rainbow Parenthesis (junegunn) {{{2
"Toggle Rainbow
nnoremap <silent> <localleader>r :RainbowParentheses!!<CR>

"plasticboy/vim-markdown {{{2
"Enable fenced code syntax highlighting for following languages
let g:vim_markdown_fenced_languages = []
"Disable conceal for markdown only (seperate from vim conealleavel)
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0

"NERDTree {{{2
nnoremap <C-n> :NERDTreeToggle<CR>
"Find and reveal active buffer's file within NERDTree window
nnoremap <C-n><C-f> :NERDTreeFind<CR>

"Show minimal UI(without help-text, bookmark-label etc.)
let g:NERDTreeMinimalUI = 1
let g:NERDTreeMinimalMenu = 1
let g:NERDTreeSortHiddenFirst = 1
let g:NERDTreeRespectWildIgnore = 1
let g:NERDTreeShowHidden=1

"Automaticaly close NERDTree when it's a tab's last window left
augroup nerdtree_close
    autocmd!
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup END


"neoterm {{{2
nnoremap <leader>nn :<c-u>rightbelow Tnew<cr>
nnoremap <leader>nc :<c-u>exec v:count.'Tclear'<cr>

"Mundo {{{2
"Undo settings recommended by vim-mundo
"Enable persistent undo so that undo history persists across vim sessions
set undofile
set undodir=~/.vim/undo
nnoremap <silent> <leader>m :MundoToggle<CR>

"vim-projectionist-elixir {{{2
"Open alternate file
nnoremap <silent> <leader>a :A<CR>
"Open alternate file in a split window
nnoremap <silent> <leader>as :AS<CR>
"Open alternate file in a vertical split window
nnoremap <silent> <leader>av :AV<CR>
"Open alternate file in another tab
nnoremap <silent> <leader>at :AT<CR>

"python-mode {{{2
let g:pymode_python = 'python3'
let g:pymode_folding = 1 "Experimental Feature. Remove if problematic.
let g:pymode_rope = 1

let g:pymode_rope_complete_on_dot = 0 "I don't like the popup resizing windows

"pymode-rope scans current dir then upwards for .ropeproject to set as root
"Scan could  be slow. So only check if .ropeproject root is in current dir.
"To manually set .ropeproject root dir, set g:pymode_rope_project_root
let g:pymode_rope_lookup_project = 0

"From pymode docs - Beware that when editing python files in multiple windows
"vim computes the folding for every typed character. So use this:
augroup pymode_unset_folding_in_insert_mode
    autocmd!
    autocmd InsertEnter *.py setlocal foldmethod=marker
    autocmd InsertLeave *.py setlocal foldmethod=expr
augroup END

"MixFormat {{{2
"Format elixir files with mix-format
let g:mix_format_options = '--check-equivalent'
augroup elixir_mix_format
    autocmd!
    autocmd FileType elixir nnoremap <silent> <localleader>f :MixFormat<CR>
    autocmd FileType elixir nnoremap <silent> <localleader>fd :MixFormatDiff<CR>
augroup END

"vim-go {{{2
augroup go_format
    autocmd!
    au FileType go nmap <leader>r <Plug>(go-run)
    autocmd FileType go nnoremap <silent> <localleader>f :GoFmt<CR>
augroup END

"Black {{{2
let g:black_linelength=79
"Format python files with Black
augroup python_black_format
    autocmd!
    autocmd FileType python nnoremap <silent> <localleader>f :Black<CR>
augroup END

"Startify {{{2
let g:startify_files_number = 4
let g:startify_custom_header = 'startify#fortune#boxed()'

"EasyAlign {{{2
"Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
"Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"Tagbar {{{2
nnoremap <silent> <leader>tb :TagbarToggle<CR>
let g:tagbar_width = 30

"Gutentag {{{2
"Specify directory to create the tag files. instead of storing at project root
let g:gutentags_cache_dir = '~/.tags_cache'

"Neomake {{{2
augroup neomake
    autocmd!
    " Execute Neomake after writing buffer
    autocmd! BufWritePost * Neomake
augroup end

"junegunn/gv.vim {{{2
"GV to open commit browser
nnoremap <leader>g :GV<CR>

"neovimhaskell/haskell-vim {{{2
"Indentaion might vary from brittany's preferences. Secede to brottany's.
"Suggested changes from the README.
let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords
"Docs contains indentation configuration. Add if required.

"meck/vim-brittany {{{2
"Trigger brittany when saving (default = 1)
let g:brittany_on_save = 1

augroup haskell_brittany_format
    autocmd!
    autocmd FileType haskell nnoremap <silent> <localleader>f :Brittany<CR>
augroup END

"rizzatti/dash.vim {{{2
"Lookup word under cursor in Dash.app. Use filetype as keyword unless
"configured otherwise
nmap <silent> <localleader>d <Plug>DashSearch
"TODO Customize keyword map. e.g. dash lookup in an elixir file would search both
"elixir and phoenix docsets. Consult :help DashConfig_map

"Zaptic/elm-vim {{{2
"Elm default mappings
"<Leader>m	Compile the current buffer.
"<Leader>b	Compile the Main.elm file in the project.
"<Leader>t	Runs the tests of the current buffer or 'tests/TestRunner'.
"<Leader>r	Opens an elm repl in a subprocess.
"<Leader>e	Shows the detail of the current error or warning.
"<Leader>d	Shows the type and docs for the word under the cursor.
"<Leader>w	Opens the docs web page for the word under the cursor
"Disable above elm-vim's default mappings
let g:elm_setup_keybindings = 0

"Format with elm-format
augroup elm_format
    autocmd!
    autocmd FileType elm nnoremap <silent> <localleader>f :ElmFormat<CR>
augroup END

" Format current buffer on save
let g:elm_format_autosave = 1

" Display format errors
let g:elm_format_fail_silently = 1


"CREDITS & INSPIRATION {{{1
"Some External Inspirations:
"Tim Pope (of course)
"Ryan Tomayko
"Drew Neil
"Derek Wyatt
"Gary Bernhardt
"http://vim.spf13.com/
"github.com/joshcom/vimconfig/
"blog.sanctum.geek.nz/page/2/
"http://dhruvasagar.com/2013/03/28/vim-better-foldtext
