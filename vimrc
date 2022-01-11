" Vim Initialization File {{{1
" vim: foldmethod=marker:foldlevel=0:nofoldenable:
" Author: Sri Kadimisetty


"PLUGINS {{{1
"Start vim-plug
call plug#begin('~/.vim/plugged')

"Active Plugins (Run :sort! on this contiguous list after insertion){{{2

Plug 'LnL7/vim-nix'
Plug 'Zaptic/elm-vim'
Plug 'airblade/vim-gitgutter'
Plug 'andymass/vim-matchup'
Plug 'axelf4/vim-strip-trailing-whitespace'
Plug 'bps/vim-textobj-python'
Plug 'c-brenn/phoenix.vim'
Plug 'cespare/vim-toml'
Plug 'chrisbra/NrrwRgn'
Plug 'christoomey/vim-sort-motion'
Plug 'christoomey/vim-titlecase'
Plug 'dense-analysis/ale'
Plug 'elixir-editors/vim-elixir'
Plug 'gcmt/taboo.vim'
Plug 'gruvbox-community/gruvbox'
Plug 'hspec/hspec.vim'
Plug 'janko/vim-test'
Plug 'junegunn/gv.vim'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vim-peekaboo'
Plug 'kadimisetty/dash.vim', {'branch': 'fix-open-flicker'}
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-user'
Plug 'kevinoid/vim-jsonc'
Plug 'lifepillar/pgsql.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'
Plug 'mattn/emmet-vim'
Plug 'meck/vim-brittany'
Plug 'mhinz/vim-mix-format'
Plug 'mhinz/vim-startify'
Plug 'mmorearty/elixir-ctags'
Plug 'mxw/vim-jsx'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neomake/neomake'
Plug 'neovimhaskell/haskell-vim'
Plug 'pangloss/vim-javascript'
Plug 'pbrisbin/vim-syntax-shakespeare'
Plug 'purescript-contrib/purescript-vim'
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
Plug 'python/black'
Plug 'rob-b/gutenhasktags'
Plug 'romainl/vim-cool'
Plug 'rstacruz/vim-closer'
Plug 'rust-lang/rust.vim'
Plug 'simnalamburt/vim-mundo'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'tmux-plugins/vim-tmux'
Plug 'tomtom/tcomment_vim' "Does embedded filetypes unlike tpope/vim-commentary
Plug 'tpope/tpope-vim-abolish'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-liquid'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'tweekmonster/django-plus.vim'
Plug 'vim-airline/vim-airline'
Plug 'vmchale/dhall-vim'
Plug 'wfxr/minimap.vim', {'do': ':!cargo install --locked code-minimap'}


"NERDTree. Save order.
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

"vim-prettier installs it's own prettier with npm.
"Also enable for listed formats
Plug 'prettier/vim-prettier', { 'do': 'npm install' }

"fzf binary is updated upon fzf plugin upgrade. Save order.
" fzf is basic integration and fzf.vim is vim plugin
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

"Projections. Save order.
Plug 'tpope/vim-projectionist'
Plug 'c-brenn/fuzzy-projectionist.vim'

"Tabular and Markdown. Save order.
"(godlygeek/tabular is a dependency for plasticboy/vim-markdown)
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

"Vim-Devicons. Load as last plugin
Plug 'ryanoasis/vim-devicons' "Requires encoding utf-8. Set as such elsewhere.


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
set wildignore+=*.o,*.obj,*.exe,*.so,*.dll,*.pyc,*.lock

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

"Ignoring: Haskell Projects
set wildignore+=.stack-work,.stackwork/*


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
set noshowmode          "Don't print mode changes upon entering a new mode e.g. --INSERT--
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
set sessionoptions+=tabpages
set sessionoptions+=globals

"Close quickfix window if it's the last one left
"SEE: https://vim.fandom.com/wiki/Automatically_quit_Vim_if_quickfix_window_is_the_last
augroup quickfix_to_be_closed
    autocmd!
    autocmd BufEnter * call CloseQuickfixIfItIsLastOpenWinLeftInTab()
augroup end
" close if quickfix is the last window left in this tab
function! CloseQuickfixIfItIsLastOpenWinLeftInTab()
  if (&buftype=="quickfix" && winnr('$') < 2)
      quit
  endif
endfunction


"FILETYPE PREFERENCES {{{1
" Filetype settings {{{2
filetype on             "Detect filetypes
filetype plugin on      "Activate builtin set of filetypes plugins
filetype indent on      "Activate builtin and computed indentations

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
function! MoveHelpToNewTab ()
    if &buftype ==# 'help' | wincmd T | endif
endfunction

augroup filetype_rust
    autocmd!
    autocmd FileType rust setlocal formatprg=rustfmt
    " Toggle trailing semicolon on current line
    autocmd FileType rust nnoremap <silent> <localleader>; :call ToggleTrailingCharacterOnLine(";", line("."))<CR>
    " Toggle trailing comma on current line
    autocmd FileType rust nnoremap <silent> <localleader>, :call ToggleTrailingCharacterOnLine(",", line("."))<CR>
    " Toggle leading `let/let mut` keywords on current line
    autocmd FileType rust nnoremap <silent> <localleader>l  :call ToggleLetKeyword(".", 0, 1)<CR>
    autocmd FileType rust nnoremap <silent> <localleader>lm :call ToggleLetKeyword(".", 1, 0)<CR>
    " Toggle  leading `pub` keyword on current line
    autocmd FileType rust nnoremap <silent> <localleader>p  :call TogglePubKeyword(".")<CR>
augroup end
function! TogglePubKeyword(line_number)
    let line_content = getline(a:line_number)
    let trimmed_line_content = trim(line_content)
    if (trimmed_line_content =~# "^pub ")
        execute 'normal ^d4l'
    else
        execute 'normal Ipub '
    endif
endfunction
function! ToggleTrailingCharacterOnLine (character, line_number)
    let line_content = getline(a:line_number)
    " Ensure line is not empty
    if strwidth(line_content) > 0
        if (line_content[-1:] == a:character)
            call setline(a:line_number, line_content[:-2])
        else
            call setline(a:line_number, line_content . a:character)
        endif
    endif
endfunction
function! ToggleLetKeyword (line_number, toggle_let_mut, toggle_let)
    "TODO: While this function accepts a line_number, the helpe fucntions within
    " only act upon the current line to accomodate the current way of restoring
    " the cursor position. Rewrite them to accept an arbitrary line number.

    " Assert provided toggle_* arguments are mutually exclusive booleans
    if (a:toggle_let_mut == a:toggle_let)
        echoerr "Provided arguments make it imposible to decide between exclusive keywords - `let` and `let mut`"

    else
        let line_content = getline(a:line_number)
        let trimmed_line_content = trim(line_content)

        " Note whether line begins with `let mut` or `let`
        " 1. First check for leading `let mut`
        if (trimmed_line_content =~# "^let mut ")
            let has_let_mut = 1
        else
            let has_let_mut = 0

            " 2. Next check for leading `let`
            " (Nesting to avoid `let mut` matcfhes)
            if (trimmed_line_content =~# "^let ")
                let has_let = 1
            else
                let has_let = 0
            endif
        endif

        " TOGGLING LOGIC:
        " +--------------+------------------+----------------+
        " |              | a:toggle_let_mut | a:toggle_let   |
        " +==============+==================+================+
        " | has_let_mut  | RemoveLetMut()   | RemoveLetMut() |
        " |              |                  | PrependLet()   |
        " +--------------+------------------+----------------+
        " | has_let      | RemoveLetMut()   | RemoveLet()    |
        " |              | PrependLet()     |                |
        " +--------------+------------------+----------------+
        " | !has_let_mut | PrependLetMut()  | PrependLet()   |
        " | !has_let     |                  |                |
        " +--------------+------------------+----------------+

        " Helper functions that modify current line:
        " TODO:
        " - Cover edge cases while restoring the cursor
        " - Accept arbitrary line number instead of acting on current line
        " - Remove the use of normal
        function! PrependLetMut()
            let save_pos = getpos(".")
            execute 'normal Ilet mut '
            call setpos('.', save_pos)
            execute 'normal 8l'
        endfunction
        function! RemoveLetMut()
            let save_pos = getpos(".")
            execute 'normal ^2dw'
            call setpos('.', save_pos)
            execute 'normal 8h'
        endfunction
        function! PrependLet()
            echo "PrependLet"
            let save_pos = getpos(".")
            execute 'normal Ilet '
            call setpos('.', save_pos)
            execute 'normal 4l'
        endfunction
        function! RemoveLet()
            let save_pos = getpos(".")
            execute 'normal ^dw'
            call setpos('.', save_pos)
            execute 'normal 4h'
        endfunction

        " Run logic
        if a:toggle_let_mut && has_let_mut
            call RemoveLetMut()
        elseif a:toggle_let_mut && has_let
            call RemoveLet()
            call PrependLetMut()
        elseif a:toggle_let_mut && (!has_let_mut && !has_let)
            call PrependLetMut()

        elseif a:toggle_let && has_let_mut
            call RemoveLetMut()
            call PrependLet()
        elseif a:toggle_let && has_let
            call RemoveLet()
        elseif a:toggle_let && (!has_let_mut && !has_let)
            call PrependLet()
        else
            " NoOp
        endif
    endif
endfunction

augroup filetype_haskell
    autocmd!
    " Requires hindent to installed globally.
    " Chosing formatprg as hindent because Brittany is used by default anyway
    " and with formatprg can call upon a second formatter hindent as needed
    " autocmd FileType haskell setlocal formatprg=stylish-haskell
    " autocmd FileType haskell setlocal formatprg=brittany
    autocmd FileType haskell setlocal formatprg=hindent

    " Append current word with a trailing `'`
    " TODO: Use a function to allow adding and removing trailing `'`
    autocmd FileType haskell nnoremap <silent> <localleader>'  ea'<Esc>

    "Turn on the sign column as I use it a lot with linters etc.
    autocmd FileType haskell setlocal signcolumn=yes

    " Insert module line on new buffers
    " i.e. for a new buffer named `Foo.hs` add the module line `module Foo where`
    autocmd BufNewFile *.hs :execute
                \ "normal! Imodule " . expand("%:r") . " where\<cr>\<cr>\<esc>"
augroup end

augroup haskell_stack_helper
    autocmd!

    " PROJECT WIDE COMMANDS (using <leader>)
    " i.e. Run `stack` on entire project
    autocmd FileType haskell nnoremap <silent> <leader>sr :call term_start(
                \ "stack run",
                \ { "term_name":"stack run"
                \ })<CR>
    autocmd FileType haskell nnoremap <silent> <leader>st :call term_start(
                \ "stack test",
                \ { "term_name":"stack test"
                \ })<CR>
    autocmd FileType haskell nnoremap <silent> <leader>sg :call term_start(
                \ "stack ghci",
                \ { "term_name":"stack ghci"
                \ , "term_finish": "close"
                \ })<CR>
    autocmd FileType haskell nnoremap <silent> <leader>sb :call term_start(
                \ "stack build",
                \ { "term_name":"stack build"
                \ })<CR>
    autocmd FileType haskell nnoremap <silent> <leader>sbf :call term_start(
                \ "stack build --fast",
                \ { "term_name":"stack build fast"
                \ })<CR>
    autocmd FileType haskell nnoremap <silent> <leader>sbw :call term_start(
                \ "stack build --fast --file-watch",
                \ { "term_name":"stack build watch"
                \ , "term_rows":3
                \ })<CR>


    " FILE SPECIFIC COMMANDS (using <localleader>)
    " i.e. Run `stack` on file in current buffer
    autocmd FileType haskell nnoremap <silent> <localleader>sr :call term_start(
                \ "stack runhaskell " . expand('%:~'),
                \ { "term_name": "stack run " . expand('%:p:t')
                \ })<CR>
    autocmd FileType haskell nnoremap <silent> <localleader>sg :call term_start(
                \ "stack ghci " . expand('%:p:t'),
                \ { "term_name":"stack ghci " . expand('%:p:t')
                \ , "term_finish": "close"
                \ })<CR>

    " Makes easier to type the last part of `stack new FOO kadimisetty/basic`
    " by providing an imap for appending "kadimisetty/basic" to the end of line.
    " This is for when opening zsh shell currently being written in $EDITOR
    " with the shortcut commanbd <C-x><C-e>. See help section
    " `edit-and-execute-command` in `man bash`. Bash has sligtlty different
    " behavior from zh. Prefer the zsh behavior.
    " Why `kb`? For `kadimisetty basic`.
    " Does: Inserts the text, switches to normal mode and exits to shell.
    autocmd FileType zsh inoremap <silent> <leader>kb kadimisetty/basic<esc>ZZ
    autocmd FileType zsh nnoremap <silent> <leader>kb A kadimisetty/basic<esc>ZZ
augroup END

augroup haskell_stack_helper_package_yaml
    autocmd!
    " For package.yaml, only allow:
    " `stack build`
    " `stack build --fast`

    " PROJECT WIDE COMMANDS (using <leader>)
    " i.e. Run `stack` on entire project
    autocmd BufEnter package.yaml nnoremap <silent> <leader>sb :call term_start(
                \ "stack build",
                \ { "term_name":"stack build"
                \ })<CR>
    autocmd BufEnter package.yaml nnoremap <silent> <leader>sbf :call term_start(
                \ "stack build --fast",
                \ { "term_name":"stack build fast"
                \ })<CR>
augroup END


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
  let foldtextstart = strpart('' . line, 0, (winwidth(0)*2)/3)
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


" Set vertical window sepertor to pipelike symbol │ with no vertical spaces
set fillchars+=vert:│

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

" Change Cursor Shape based on Mode {{{2
"
" Terminal Escape Sequence Numbers for Cursor Shapes) Reference:
" +------------+-----------------------+
" | 0, 1, none | Blink Block (Default) |
" | 2          | Steady Block          |
" | 3          | Blink Underline       |
" | 4          | Steady Underline      |
" | 6          | Steady Vertical Bar   |
" +------------+-----------------------+
if $TERM_PROGRAM =~ "Apple_Terminal"
    let &t_SI="\033[6 q" "Vertical bar in Insert mode
    let &t_SR="\033[4 q" "Underline in Replace mode
    let &t_EI="\033[2 q" "Steady Block in Normal mode
elseif $TERM_PROGRAM =~ "iTerm"
    "iTerm cursors look much better, especially contrast on hover.
    "https://hamberg.no/erlend/posts/2014-03-09-change-vim-cursor-in-iterm.html
    let &t_SI = "\<Esc>]50;CursorShape=1\x7" "Vertical bar in Insert mode
    let &t_EI = "\<Esc>]50;CursorShape=0\x7" "Steady Block in Normal mode
    let &t_SR = "\<esc>]50;CursorShape=2\x7" "Underline in Replace mode
elseif $TERM_PROGRAM =~ "tmux"
    " NOTE: When `$TERM_PROGRAM`  shows `tmux` it isn't possible to
    " say whether we are in `terminal.app` or `iTerm.app`, so using the
    " same settings for `terminal.app` since they work for both `terminal.app`
    " and `iTerm`, unlike `iTerm's`.
    let &t_SI="\033[6 q"
    let &t_SR="\033[4 q"
    let &t_EI="\033[2 q"
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
    autocmd FileType haskell setlocal ts=2 sts=2 sw=2 expandtab
augroup end
" Disable my whitespace_trailing map/func (removes in entire buffer on save) in favor of
" the plugin 'axelf4/vim-strip-trailing-whitespace' that only removes
" white space on changed lines in buffer. To remove trailing whitespace in
" entire file use it's provided command :StripTrailingWhitespace instead.
" augroup whitespace_trailing
"     autocmd!
"     autocmd FileType c,cpp,java,php,js,twig,xml,yml,elm autocmd BufWritePre <buffer> call RemoveTrailingWhitespace()
" augroup end
" function! RemoveTrailingWhitespace ()
"      call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))
" endfunction


"ABBREVIATIONS, TYPOS, ALIASES & CONCEALS {{{1
"Abbreviations & Typos
" Common `iabbrev`s like `iabbrev improt import` etc. moved to file recommended
" by `Abolish.vim`: `~/.vim/after/plugin/abolish.vim`

augroup elm_abbreviations
    autocmd!
    autocmd FileType elm abbreviate <buffer> :: :
augroup END

command! W w
command! Q q
"Retain visual selection after an indentation shift.
vnoremap < <gv
vnoremap > >gv
"Yank to end of line, just like C or D
nnoremap Y y$
"Retain cursor position after done joining two lines
nnoremap J mzJ`z
" Toggle spelling mode.
nnoremap <silent> <leader>ss :set spell!<CR>


"MOVEMENT {{{1
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

" Jump to the last known valid cursor position {{{2
augroup cursor_position
    autocmd!
    autocmd BufReadPost *
                \ if line("'\"") > 0 && line("'\"") <= line("$") |
                \   exe "normal g`\"" |
                \ endif
augroup end

"HANDY FUNCTIONS {{{1
"Make environment writing friendly {{{2
function! WriteMode()
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


"MAPPINGS {{{1
" Windows {{{2
" NOTE: These are deliberatly identical to my tmux pane mappings
" Make horizontal split
nnoremap <silent> <c-w>-        :split<CR>
" Make vertical split
nnoremap <silent> <c-w>\|       :vsplit<CR>
" Equal size windows
nnoremap <silent> <leader>w=    :wincmd =<CR>
" Close all windows and exit
nnoremap <leader>Q              :qa<CR>

" Tab pages {{{2
" Move between tabs with just the <Tab> key
nnoremap <silent> <Tab>         :tabnext<CR>
nnoremap <silent> <S-Tab>       :tabprevious<CR>
" NOTE: These are deliberatly identical to my tmux mappings
" Open a new blank tab page AFTER the current one
nnoremap <silent> <c-w>c        :tabnew<CR>
" Open a new blank tab page BEFORE the current one
nnoremap <silent> <c-w>C        :-tabnew<CR>
" Close current tab page
nnoremap <silent> <c-w>x        :tabclose<CR>
" Move tab page forwards/backward
function! TabMoveBy1(rightOrLeft, isWrapped)
    " TODO: Accept user-supplied number of tab page spots to move by.
    "
    " Arguments:
    "   rightOr
    "       Left="left", Right="right"
    "   isWrapped
    "       0=false, 1=true
    "
    " TAB MOVING LOGIC:
    " +---------------+--------------+-----------------+----------------+-----------------+
    " |               |  IS ONLY TAB | IS FIRST TAB    | IS LAST TAB    | IS MIDDLE TAB   |
    " +---------------+==============+=================++++++++++++++++++=================+
    " | TO MOVE LEFT  |  Error(Only) | Error(First)    | Move left by 1 | Move left by 1  |
    " +---------------+--------------+-----------------+----------------+-----------------+
    " | TO MOVE LEFT  |  Error(Only) | Move to last    | Move left by 1 | Move left by 1  |
    " | W/ WRAP       |              |                 |                |                 |
    " +---------------+--------------+-----------------+----------------+-----------------+
    " | TO MOVE RIGHT |  Error(Only) | Move right by 1 | Error(Last)    | Move right by 1 |
    " +---------------+--------------+-----------------+----------------+-----------------+
    " | TO MOVE RIGHT |  Error(Only) | Move right by 1 | Move to first  | Move right by 1 |
    " | W/ WRAP       |              |                 |                |                 |
    " +---------------+--------------+-----------------+----------------+-----------------+
    "
    " Collect information required for logic
    let numberOfTabs=tabpagenr("$")
    let currentTabNr=tabpagenr()
    if numberOfTabs == 1 | let isOnlyTab = 1 | else | let isOnlyTab = 0 | endif
    if currentTabNr == 1 | let isFirstTab = 1 | else | let isFirstTab = 0 | endif
    if currentTabNr == numberOfTabs | let isLastTab = 1 | else | let isLastTab = 0 | endif
    if (currentTabNr > 1) && (currentTabNr < numberOfTabs)
        let isMiddleTab = 1
    else
        let isMiddleTab = 0
    endif

    " Follow logic
    if (a:rightOrLeft ==? "left") && (a:isWrapped == 0)
        if isOnlyTab
            " ERR
            echo "Only tab page"
        elseif isFirstTab
            " ERR
            echo "Alredy first"
        elseif isLastTab
            " MOVE LEFT 1
            execute "tabmove -1"
        elseif isMiddleTab
            " MOVE LEFT 1
            execute "tabmove -1"
        endif
    elseif (a:rightOrLeft ==? "left") && (a:isWrapped == 1)
        if isOnlyTab
            " ERR
            echo "Only tab page"
        elseif isFirstTab
            "MOVE TO LAST
            execute "tabmove"
        elseif isLastTab
            "MOVE LEFT 1
            execute "tabmove -1"
        elseif isMiddleTab
            "MOVE LEFT  1
            execute "tabmove -1"
        endif
    elseif (a:rightOrLeft ==? "right") && (a:isWrapped == 0)
        if isOnlyTab
            " ERR
            echo "Only tab page"
        elseif isFirstTab
            "MOVE RIGHT 1
            execute "tabmove +1"
        elseif isLastTab
            " ERR
            echo "Already last"
        elseif isMiddleTab
            " MOVE RIGHT 1
            execute "tabmove +1"
        endif
    elseif (a:rightOrLeft ==? "right") && (a:isWrapped == 1)
        if isOnlyTab
            " ERR
            echo "Only tab page"
        elseif isFirstTab
            "MOVE RIGHT 1
            execute "tabmove +1"
        elseif isLastTab
            "MOVE TO FIRST
            execute "0tabmove"
        elseif isMiddleTab
            "MOVE RIGHT 1
            execute "tabmove +1"
        endif
    else
        echoerr "Unrecognized argument(s), expecting: (\"left\"/\"right\", 0/1)"
    endif
endfunction
" NOTE: vim and tmux do not use the same codes for <s-left> and <s-right> and
" so without the following fix, vim cannot properly interpret <s-left> and
" <s-right>. (SEE: https://superuser.com/a/402084/99601).
" FIX:
" 1. Withing tmux do:`set-window-option -g xterm-keys on`
" 2. Here, in vimrc, do:
if &term =~ '^screen'
    " tmux will send xterm-style keys when its xterm-keys option is on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif
" 3. Now proceed with <s-left> and <s-right> working as expected, map tab movement
" to them:
" WRAPPING OFF
nnoremap <silent> <c-w><s-left>          :call TabMoveBy1("left", 0)<CR>
nnoremap <silent> <c-w><s-right>         :call TabMoveBy1("right", 0)<CR>
"
" WRAPPING ON
" nnoremap <silent> <c-w><s-left>          :call TabMoveBy1("left", 1)<CR>
" nnoremap <silent> <c-w><s-right>         :call TabMoveBy1("right", 1)<CR>
"
" Simple Left/Right movement with no wrapping or error reporting.
" nnoremap <silent> <c-w><s-left>          :execute "tabmove -1"<CR>
" nnoremap <silent> <c-w><s-right>         :execute "tabmove +1"<CR>

" Rename tab page
" NOTE: Requires the `gcmt/taboo.vim` plugin
function! RenameTabpageWithTaboo()
    " NOTE: It is desirable to go through the taboo plugin to rename the
    " tabpage over native commands.
    if get(g:, 'loaded_taboo', 0) && exists("*TabooTabName")
        let l:currentTabPageName = TabooTabName(tabpagenr())
        if (len(l:currentTabPageName) == 0)
            let l:newName = input("NAME: ")
        else
            let l:newName = input("NAME (" . l:currentTabPageName . "): ")
        endif
        execute 'TabooRename ' . l:newName
    else
        " Taboo plugin is not loaded
        echoerr "Unable to rename tab (`gcmt/taboo.vim` plugin is not loaded)."
    endif
endfunction
nnoremap <silent> <C-w>,    :call RenameTabpageWithTaboo()<CR>

"Toggle quickfix and location list windows {{{2
function! ToggleQuickFix()
    " 1. Check if quickfix is open. 0 for close, 1+ for open
    let l:quickfix_is_open = len(filter(getwininfo(), 'v:val.quickfix && !v:val.loclist'))

    " 2. Toggle QuickFix window
    if l:quickfix_is_open == 0
        execute 'copen'
    else
        execute 'cclose'
    endif
endfunction
nnoremap <silent> <leader>q :call ToggleQuickFix()<CR>

function! ToggleLocationList()
    " 1. Check if quickfix is open. 0 for close, 1+ for open
    let l:locationlist_is_open = len(filter(getwininfo(), 'v:val.loclist && !v:val.quickfix'))

    " 2. Toggle QuickFix window
    if l:locationlist_is_open == 0
        execute 'lopen'
    else
        execute 'lclose'
    endif
endfunction
nnoremap <silent> <leader>ll :call ToggleLocationList()<CR>

"Close all helper windows
function! CloseAllHelperWindows()
    pclose
    lclose
    cclose
    call popup_clear()
endfunction
function! CloseAllHelperWindowsInAllTabsAndReturnToPreviousPosition()
    let current_tab = tabpagenr()
    tabdo windo execute 'call CloseAllHelperWindows()'
    execute 'tabnext' current_tab
endfunction
nnoremap <silent><leader>z  :call CloseAllHelperWindows()<CR>
nnoremap <silent><leader>Z  :call CloseAllHelperWindowsInAllTabsAndReturnToPreviousPosition()<CR>

"Edit vimrc {{{2
nnoremap <silent> <leader>v :edit $MYVIMRC<CR>

"Autocomplete by copying word from line above cursor{{{2
" TODO:
" - Move into a function
" - edge case: letter immediately above is empty
" - Add space after pasting the word
" - ISSUE: first word will pase fine, words after when going up with k move
"   into space and copy that space along with word. If i use a h to just go
"   back one letter, them the entire mapping fails beause there is no h on the
"   first word.
"   FIX: Move into a function and handle this case.
inoremap <silent> <C-y><Tab> <esc>kyejpa<space>

"Buffer Manipulation {{{2
"Delete buffer in current window
nnoremap <silent> <localleader>bd :bd %<CR>

"Terminal {{{2
nnoremap <leader>tn :<c-u>rightbelow terminal<cr>

" Save with <C-s> {{{2
" NOTE: Terminals consider <C-s> a legasy flow character.
" So to use <C-s>, that needs to be disabled with the following
" within bashrc/zshrc:"
" # Enable <c-s> and <c-q> in zsh with  ~/.zshrc:
" #   stty start undef
" #   stty stop undef
" #   setopt noflowcontrol
" # Enable <c-s> and <c-q> in bash with ~/.bash_profile or ~/.bashrc:
" #   stty -ixon
"
" NOTE: Vim cannot differential cases with control characters, so <c-s> and
" <c-S> are dealt with the same.
nnoremap <silent> <C-s>  :update<CR>
vnoremap <silent> <C-s>  <C-C>:update<CR>
inoremap <silent> <C-s>  <C-O>:update<CR>

" Make and load session using `./Session.vim` {{{2
" Create a session named `./Session.vim` if it doesn't exist in current directory
nnoremap <leader>m :mksession<CR>
" Create/overwrite a session named `./Session.vim` in current directory
nnoremap <leader>M :mksession!<CR>
" Load session by sourcing `./Session.vim` in current directory
nnoremap <leader>l :source ./Session.vim<CR>

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

" Toggle modifiable (i.e. Toggle read-only on current buffer) {{{2
" Mapping `yom` is in the style of tpope/vim-unimpaired
function! ToggleModifiable()
    if &modifiable
        setlocal nomodifiable
    else
        setlocal modifiable
    endif
endfunction
nnoremap <silent> yom :call ToggleModifiable()<CR>
nnoremap <silent> ]om :setlocal modifiable<CR>
nnoremap <silent> [om :setlocal nomodifiable<CR>

" Toggle signcolumn (gutter) {{{2
function! ToggleSignColumn()
    " Note: &`signcolumn` can be `yes/no/auto` but this function only toggles
    " between `yes/no` but not `auto`, so use at your discretion.
    " if (&signcolumn == 'auto' || &signcolumn == 'no')
    if &signcolumn != 'no' "Using `!= no` instead of `== auto | yes`
        setlocal signcolumn=no
    else
        setlocal signcolumn=yes
    endif
endfunction
" Using `g` instead of `s`:
" 1. `s` is being used by `spell`
" 2. `g` for `gutter`
" 3. I seem to remember it more as gutter than signcolumn anyway.
nnoremap <silent> yog :call ToggleSignColumn()<CR>
nnoremap <silent> ]og :setlocal signcolumn=yes<CR>
nnoremap <silent> [og :setlocal signcolumn=no<CR>
" This is in the style of `tpope/vim-unimpaired` and since the about
" mapping/function does not cover `auto` this does;
" the mnemonic `]oga` is for `turn on the gutter=auto`
nnoremap <silent> ]oga :setlocal signcolumn=auto<CR>

"Flip cursorcolumn on demand {{{2
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
"gruvbox {{{2
"Enable gruvbox colorscheme
colorscheme gruvbox

" Hide the filler line characters (~) by giving it the smae color as the
" background
" TODO: Place this setting in a better location i.e. not under a plugin
" preference prefereably.
highlight EndOfBuffer ctermfg=bg guifg=bg

"netrw {{{2
let g:netrw_banner=0


"Prettier {{{2
" max line length that prettier will wrap on
let g:prettier#config#print_width = 60
"Don't change focus to quickfix window on errors
" let g:prettier#quickfix_auto_focus = 1

"ALE {{{2
let g:ale_disable_lsp=1
" Use `nixfmt` instead of` nixpkgs-fmt` in nix files
let g:ale_nix_nixpkgsfmt_executable = "nixfmt"

" Linters
let g:ale_lint_on_save=1
let g:ale_lint_on_text_changed=1
let g:ale_linters_explicit=1
let g:ale_linters = {}
let g:ale_linters.nix = ['nixpkgs-fmt']
let g:ale_linters.haskell = ['hlint']
" Setting hlint executable to stack makes ALE use `stack exec hlint --`
let g:ale_haskell_hlint_executable='stack'

" Fixers
nnoremap <silent> <localleader>af :ALEFix<CR>
let g:ale_fixers_explicit = 1
" let g:ale_fix_on_save=0
" let g:ale_fixers = { '*': ['trim_whitespace', 'remove_trailing_lines'] }
let g:ale_fixers = {}
let g:ale_fixers.nix = ['nixpkgs-fmt']
" let g:ale_fixers.haskell = ['brittany']
let g:ale_fixers.haskell = ['hlint']

" Visuals
" Echo truncated error message when cursor is close to error line
let g:ale_echo_cursor=1
" Enable line number highlighting
let g:ale_sign_highlight_linenrs = 1

" Symbols
" Default g:ale_sign_error is '>>'
let g:ale_sign_error = ' ▓'
" Default g:ale_sign_warning is'--'
let g:ale_sign_warning =  ' ░'


"fzf & fzf.vim {{{2
" 1. fzf {{{3
" Layout applies to both fzf and fzf.vim mappings
let g:fzf_layout = { 'down': '40%' }

" Example of custom fzf search
" let g:fzf_layout = { 'down': '40%' }
" Search files tracked in git via `git ls-files`:
"   command! FZFGit call fzf#run(fzf#wrap({
"               \ 'source': 'git ls-files',
"               \ 'sink': 'edit',
"               \ }))
" nnoremap <C-P><C-G> :FZFGit<CR>

" 2. fzf.vim {{{3
let g:fzf_command_prefix = 'FZF'

" Disable preview window
let g:fzf_preview_window = []
" Example of customized preview window: [position, toggle key]
" let g:fzf_preview_window = ['right:40%', 'ctrl-/']

" Search files
nnoremap <silent> <C-P>      :FZFFiles<CR>
nnoremap <silent> <C-P><C-G> :FZFGFiles<CR>
nnoremap <silent> <C-P><C-B> :FZFBuffers<CR>
nnoremap <silent> <C-P><C-R> :FZFRg<CR>
nnoremap <silent> <C-P><C-L> :FZFLines<CR>
nnoremap <silent> <C-P><C-T> :FZFTags<CR>



"Airline {{{2
let g:airline_theme='gruvbox'

" Use short symbols to indicate mode
let g:airline_mode_map = {
    \ '__'     : '-',
    \ 'c'      : 'C',
    \ 'i'      : 'I',
    \ 'ic'     : 'I',
    \ 'ix'     : 'I',
    \ 'n'      : 'N',
    \ 'multi'  : 'M',
    \ 'ni'     : 'N',
    \ 'no'     : 'N',
    \ 'R'      : 'R',
    \ 'Rv'     : 'R',
    \ 's'      : 'S',
    \ 'S'      : 'S',
    \ ''     : 'S',
    \ 't'      : 'T',
    \ 'v'      : 'V',
    \ 'V'      : 'V',
    \ ''     : 'v',
    \ }

" Skip displaying fileformat if it matches the expected 'utf-8[unix]'
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'

" Initialize Airline Symbols if not created.
" Avoid overwriting existing Airline symbols
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.branch = 'שׂ'
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ' '

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

"airline ale exension
let g:airline#extensions#ale#enabled=1

"airline coc-nvim exension
"Enable vim-airline integration. Comes with airline.
let g:airline#extensions#coc#enabled = 1

"airline taboo extension
let g:airline#extensions#taboo#enabled = 1


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
nnoremap <silent> <C-n> :NERDTreeToggle<CR>
"Find and reveal active buffer's file within NERDTree window
nnoremap <silent> <C-n><C-f> :NERDTreeFind<CR>
"Refreshes the NERDTree root node
nnoremap <silent> <C-n><C-r> :NERDTreeRefreshRoot<CR>

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


"Mundo {{{2
"Undo settings recommended by vim-mundo
"Enable persistent undo so that undo history persists across vim sessions
set undofile
set undodir=~/.vim/undo

nnoremap <silent> <C-u> :MundoToggle<CR>
"Display short oneline diff to right of graph
let g:mundo_inline_undo=1
"Keep focus in the Mundo window after a revert.
let g:mundo_return_on_revert=0

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


"Black {{{2
let g:black_linelength=79
"Format python files with Black
augroup python_black_format
    autocmd!
    autocmd FileType python nnoremap <silent> <localleader>f :Black<CR>
augroup END

"Startify {{{2
let g:startify_files_number = 4
let g:startify_custom_header = ''

"EasyAlign {{{2
"NOTE: xmap and nmap for easyalign should not use the noremap versions
"Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
"Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"Tagbar {{{2
nnoremap <silent> <C-t> :TagbarToggle<CR>
let g:tagbar_width = 28

" Haskell
let g:tagbar_type_haskell = {
    \ 'ctagsbin'  : 'hasktags',
    \ 'ctagsargs' : '-x -c -o-',
    \ 'kinds'     : [
        \  'm:modules:0:1',
        \  'd:data: 0:1',
        \  'd_gadt: data gadt:0:1',
        \  't:type names:0:1',
        \  'nt:new types:0:1',
        \  'c:classes:0:1',
        \  'cons:constructors:1:1',
        \  'c_gadt:constructor gadt:1:1',
        \  'c_a:constructor accessors:1:1',
        \  'ft:function types:1:1',
        \  'fi:function implementations:0:1',
        \  'i:instance:0:1',
        \  'o:others:0:1'
    \ ],
    \ 'sro'        : '.',
    \ 'kind2scope' : {
        \ 'm' : 'module',
        \ 'c' : 'class',
        \ 'd' : 'data',
        \ 't' : 'type',
        \ 'i' : 'instance'
    \ },
    \ 'scope2kind' : {
        \ 'module'   : 'm',
        \ 'class'    : 'c',
        \ 'data'     : 'd',
        \ 'type'     : 't',
        \ 'instance' : 'i'
    \ }
\ }

" Elm
let g:tagbar_type_elm = {
          \   'ctagstype':'elm'
          \ , 'kinds':['h:header', 'i:import', 't:type', 'f:function', 'e:exposing']
          \ , 'sro':'&&&'
          \ , 'kind2scope':{ 'h':'header', 'i':'import'}
          \ , 'sort':0
          \ , 'ctagsbin':'~/code/personal/dotfiles/elmtags.py'
          \ , 'ctagsargs': ''
          \ }

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
function! ToggleGVCommitBrowser(gv_command)
    let valid_gv_commands = ['GV', 'GV!']
    if !(index(valid_gv_commands, a:gv_command) >= 0)
        " Given gv_command is invalid
        echoerr 'Invalid GV command:' . a:gv_command . ' (Only GV and GV! allowed)'
    else
        " Given gv_command is valid
        if (&filetype == 'GV')
            " Close GV window if already open
            execute 'normal gq'
        else
            " Open desired kind of GV or GV! window
            execute a:gv_command
        endif
    endif
endfunction
"GV - Opens commit browser
nnoremap <silent> <C-g> :call ToggleGVCommitBrowser('GV')<CR>
"GV! - Opens commit browser with commits that affected the current file
nnoremap <silent> <C-g>! :call ToggleGVCommitBrowser('GV!')<CR>
"Ignoring similar mapping for GV? because that might convolute my muscle memory

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

"christoomey/vim-titlecase {{{2
"Operators that call Titlecase upon expected text objects
" nmap <leader>gt <Plug>Titlecase
" vmap <leader>gt <Plug>Titlecase
" gt and gT are by default mapped to previous/next tabs but I'm using
" <Tab> and <S-Tab> for that, so remapping gt and gT is okay.
nmap gt <Plug>Titlecase
vmap gt <Plug>Titlecase
xmap gt <Plug>Titlecase
nmap gT <Plug>TitlecaseLine

"rizzatti/dash.vim {{{2
"Lookup word under cursor in Dash.app. Use filetype as keyword unless
"configured otherwise
nmap <silent> <leader>d <Plug>DashSearch


"rust-lang/rust.vim {{{2
augroup rust
    autocmd!
    "Format with rustfmt
    autocmd FileType rust nnoremap <silent> <localleader>f :RustFmt<CR>

    "CARGO
    " Direct mappings to 'rust-lang/rust.vim':
    " autocmd FileType rust nnoremap <silent> <leader>cr :Crun<CR>
    " autocmd FileType rust nnoremap <silent> <leader>cb :Cbuild<CR>
    " autocmd FileType rust nnoremap <silent> <leader>ct :Ctest<CR>
    " autocmd FileType rust nnoremap <silent> <leader>cc :Ccheck<CR>
    "
    " InDirect mappings to 'rust-lang/rust.vim' via
    " ReplaceCargoCommand
    autocmd FileType rust nnoremap <silent> <leader>cr :call ReplaceCargoCommand('run')<CR>
    autocmd FileType rust nnoremap <silent> <leader>cb :call ReplaceCargoCommand('build')<CR>
    autocmd FileType rust nnoremap <silent> <leader>ct :call ReplaceCargoCommand('test')<CR>
    autocmd FileType rust nnoremap <silent> <leader>cc :call ReplaceCargoCommand('check')<CR>
augroup END
function! ReplaceCargoCommand(command)
    " Runs validated cargo command. If a window already exists from a previous
    " cargo command, it is replaced i.e. it's buffer(and window) is deleted
    " and a fresh cargo command via `rust-lang/rust.vim` is run on a new term
    " window.

    let valid_cargo_commands = ['run', 'build', 'test', 'check']
    if index(valid_cargo_commands, a:command) < 0
        " Supplied cargo command is invalid
        echoerr "Cargo command should be one of: " . string(valid_cargo_commands)
    else
        " Get a list of open buffers in current tabpage and close them if
        " their name matches with the supplied cargo command. Then run the
        " supplied cargo command
        let buffers_in_current_tabpage = tabpagebuflist(tabpagenr())
        for b in buffers_in_current_tabpage
            " Check if buffer has mathcing name and is of type `terminal`
            if  (bufname(b) =~# ('^!cargo ' . a:command)) && (getbufvar(b, '&buftype') ==# 'terminal' )
                execute ('bdelete ' . b)
            endif
        endfor
        " uses the functions provided by vim-rust .e.g `:CRun`
        execute (':C' . a:command)
    endif
endfunction

" Format current buffer on save
let g:rustfmt_autosave = 1

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

" rob-b/gutenhasktags {{{2
let g:gutentags_project_info = [{'type': 'haskell', 'file': 'Setup.hs'} ]
let g:gutentags_ctags_executable_haskell = 'gutenhasktags'

" lifepillar/pgsql.vim {{{2
let g:sql_type_default = 'pgsql'

" wfxr/minimap.vim {{{2
let g:minimap_auto_start = 0
let g:minimap_auto_start_win_enter = 0

nnoremap <silent> <C-m> :MinimapToggle<CR>

hi MinimapBaseHighlight term=reverse  ctermfg=241 ctermbg=236
hi MinimapHighlight     term=standout cterm=bold  ctermfg=142 ctermbg=238
let g:minimap_base_highlight = 'MinimapBaseHighlight'
let g:minimap_highlight = 'MinimapHighlight'

" gcmt/taboo.vim {{{2
let g:taboo_tab_format = "%f%U %d"
let g:taboo_renamed_tab_format = "%l%U %d"

" coc-nvim {{{2
" Contrast in CocFloating + gruvbox is terrible.
" Changing to another highlight group.
" IMPORTANT: Needs to be done after loading gruvbox
hi default link CocFloating Folded

" Load these extensions (They are activated according to filetype)
let g:coc_global_extensions = ['coc-elixir', 'coc-snippets', 'coc-vimlsp', 'coc-json']

" Coc recommends faster update time to show diagnostic messages (default is 4000ms)
set updatetime=300

" Disable ins-completion-menu messages like match 1 of 2, Pattern not found etc.
set shortmess+=c

"TRIGGER COMPLETION {{{3
"(Note: Coc trigger completion Requires `coc-snippets` extension to be enabled)

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" TRIGGER COMPLETION STRATEGY 1:
" Can do <Tab>/<S-Tab> for up/down in completion
" Compromise: <Tab> can't be mapped to snippet expansion.
" inoremap <silent><expr> <TAB>
"         \ pumvisible() ? "\<C-n>" :
"         \ <SID>check_back_space() ? "\<TAB>" :
"         \ coc#refresh()
" inoremap <expr><S-Tab> pumvisible() ? "\<C-p>" : "\<C-h>"

" TRIGGER COMPLETION STRATEGY 2:
" <Tab> is mapped to snippet expansion (This is highly desired)
" Compromise: <S-Tab> goes up in completion list, but since <Tab> is already mapped,
" it cannot be mapped to go up in the completion list, slightly marring the completion experience
inoremap <silent><expr> <TAB>
    \ pumvisible() ? coc#_select_confirm() :
    \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()
inoremap <expr><S-Tab> pumvisible() ? "\<C-p>" : "\<C-h>"

"Trigger keys to go next/prev in snippet insertion positions.
"Defaults are <C-j> for next and <C-k> for prev
" let g:coc_snippet_next='<Tab>'
" Shift-Tab doesn't work for prev
" let g:coc_snippet_prev='<S-Tab>'
" }}}3

" Mappings {{{3
" NOTE: Keep these mappings as nmaps and not nnoremaps
" Navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Show Documentation
nnoremap <silent> <localleader>k :call <SID>coc_show_documentation()<CR>
function! s:coc_show_documentation()
    "Note: This can be closed with :pclose which I mapped into <leader>z
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

" Actions {{{4
nmap <silent> <localleader>ca <Plug>(coc-codeaction-line)
vmap <silent> <localleader>ca <Plug>(coc-codeaction-selected)
" Fix on current line
nmap <silent> <localleader>x <Plug>(coc-fix-current)
" Rename current word
nmap <silent> <localleader>rn <Plug>(coc-rename)

" Text Objects (requires document symbolds in LS) {{{3
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

"  Misc Coc Settings {{{3

" Use `:CocFormat` to format current buffer
" command! -nargs=0 CocFormat :call CocAction('format')
" Use `:CocFold` to fold current buffer
" command! -nargs=? CocFold :call CocAction('fold', <f-args>)
" use `:CocOR` for organize import of current buffer
" command! -nargs=0 CocOR   :call CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

augroup coc_update_signature_help_on_jump_placeholder
  autocmd!
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end


" EXPERIMENTS & TEMPORARY PREFERENCES {{{1
" Placed in a seperate file(s) to avoid tracking by VCSs
" Little experiments placed in a seperate file to avoid tracking by VCSs {{{2
source ~/.vim-experiments.vim
" Temporary Preferences {{{2
source ~/.vim-temporary-preferences.vim

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
