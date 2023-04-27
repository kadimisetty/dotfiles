" Vim Initialization File {{{1
" vim: foldmethod=marker:foldlevel=0:nofoldenable:
" Author: Sri Kadimisetty


"PLUGINS {{{1
"Initialize  vim-plug {{{2
call plug#begin('~/.vim/plugged')

"Active Plugins {{{2
" NOTE: Keep this list sorted

Plug 'LnL7/vim-nix'
Plug 'Zaptic/elm-vim'
Plug 'airblade/vim-gitgutter'
Plug 'axelf4/vim-strip-trailing-whitespace'
Plug 'bps/vim-textobj-python'
Plug 'c-brenn/phoenix.vim'
Plug 'cespare/vim-toml'
Plug 'chrisbra/NrrwRgn'
Plug 'christoomey/vim-sort-motion'
Plug 'christoomey/vim-titlecase'
Plug 'dag/vim-fish'
Plug 'dense-analysis/ale'
Plug 'elixir-editors/vim-elixir'
Plug 'fatih/vim-go'
Plug 'fladson/vim-kitty'
Plug 'gcmt/taboo.vim'
Plug 'gruvbox-community/gruvbox'
Plug 'hspec/hspec.vim'
Plug 'janko/vim-test'
Plug 'jiangmiao/auto-pairs'
Plug 'joukevandermaas/vim-ember-hbs'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/gv.vim'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vim-peekaboo'
Plug 'kadimisetty/dash.vim', {'branch': 'fix-open-flicker'}
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-user'
Plug 'kevinoid/vim-jsonc'
Plug 'lifepillar/pgsql.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'machakann/vim-highlightedyank'
Plug 'majutsushi/tagbar'
Plug 'mattn/emmet-vim'
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
Plug 'pest-parser/pest.vim'
Plug 'purescript-contrib/purescript-vim'
Plug 'idris-hackers/idris-vim'
Plug 'psf/black', { 'branch': 'stable' }
Plug 'raimon49/requirements.txt.vim', {'for': 'requirements'}
Plug 'rob-b/gutenhasktags'
Plug 'romainl/vim-cool'
Plug 'rust-lang/rust.vim'
Plug 'sdiehl/vim-ormolu'
Plug 'sgur/vim-textobj-parameter'
Plug 'simnalamburt/vim-mundo'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'tmux-plugins/vim-tmux'
Plug 'tomtom/tcomment_vim' "Does embedded filetypes unlike tpope/vim-commentary
Plug 'tpope/tpope-vim-abolish'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-liquid'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'tweekmonster/django-plus.vim'
Plug 'vale1410/vim-minizinc'
Plug 'vim-airline/vim-airline'
Plug 'vmchale/dhall-vim'
Plug 'wfxr/minimap.vim' "Requires `code-minimap` available via cargo, nix etc.
Plug 'wsdjeg/vim-fetch'



"NERDTree. Save order.
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

"vim-prettier installs it's own prettier with npm.
"Also enable for listed formats
Plug 'prettier/vim-prettier', { 'do': 'npm install' }

"fzf binary is updated upon fzf plugin upgrade. Save order.
" fzf is basic integration and fzf.vim is vim plugin
Plug 'junegunn/fzf'
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

augroup filetype_python
    autocmd!
    " Toggle trailing colon on current line
    autocmd FileType python nnoremap <silent> <localleader>:  :call ToggleTrailingCharacterOnLine(":", line("."))<CR>
    " Toggle trailing comma on current line
    autocmd FileType python nnoremap <silent> <localleader>,  :call ToggleTrailingCharacterOnLine(",", line("."))<CR>
    " Toggle leading `async`/`await` keywords on current line
    autocmd FileType python nnoremap <silent> <localleader>a  :call ToggleAsyncOrAwaitKeywordPython(".")<CR>
    " Toggle `pass` keywork on current line
    autocmd FileType python nnoremap <silent> <localleader>p  :call TogglePassKeywordPython(".")<CR>
    " Toggle `pass` keywork on current line, replacing any existing content
    autocmd FileType python nnoremap <silent> <localleader>P  :call TogglePassKeywordReplacingContentPython(".")<CR>
augroup end
function! TogglePassKeywordReplacingContentPython(line_number)
    " Toggles leading keywords `pass`
    let line_content = getline(a:line_number)
    let trimmed_line_content = trim(line_content)
    if (trimmed_line_content =~# "^pass")
        execute 'normal ^d4l'
    else
        execute 'normal Spass'
    endif
endfunction
function! TogglePassKeywordPython(line_number)
    " Toggles leading keywords `pass`
    let line_content = getline(a:line_number)
    let trimmed_line_content = trim(line_content)
    if (trimmed_line_content =~# "^pass")
        execute 'normal ^d4l'
    else
        execute 'normal Ipass'
    endif
endfunction
function! ToggleAsyncOrAwaitKeywordPython(line_number)
    " Toggles leading keywords `async` or `await` on given line.
    " NOTE: This is bound to python's async grammar i.e. if line
    " begins with `def`(function) then `async` is toggled, else `await` (not
    " function) is toggled.
    let line_content = getline(a:line_number)
    let trimmed_line_content = trim(line_content)
    if ((trimmed_line_content =~# "^async ") || (trimmed_line_content =~# "^await "))
        execute 'normal ^d6l'
    else
        if (trimmed_line_content =~# "^def ")
            execute 'normal Iasync '
        else
            execute 'normal Iawait '
        endif
    endif
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
    " Toggle leading `pub` keyword on current line
    autocmd FileType rust nnoremap <silent> <localleader>p  :call TogglePubKeyword(".")<CR>
    " Toggle trailing `into()` on content of current line
    autocmd FileType rust nnoremap <silent> <localleader>i  :call ToggleTrailingInto(".")<CR>
    " Toggle leading `async` keyword on current line
    autocmd FileType rust nnoremap <silent> <localleader>a  :call ToggleAsyncKeywordRust(".")<CR>
    " Toggle trailing `await` on content of current line
    autocmd FileType rust nnoremap <silent> <localleader>A  :call ToggleTrailingAwaitKeyword(".")<CR>
    " Toggle trailing question mark on current line
    autocmd Filetype rust nnoremap <silent> <localleader>?  :call ToggleTrailingQuestionMark(".")<CR>
    " Toggle wrapping `Ok()` and `Err()` on current line
    autocmd FileType rust nnoremap <silent> <localleader>o  :call ToggleWrappingTagOnCurrentLine("Ok")<CR>
    autocmd FileType rust nnoremap <silent> <localleader>e  :call ToggleWrappingTagOnCurrentLine("Err")<CR>
    " Toggle leading `_` on current word
    autocmd FileType rust nnoremap <silent> <localleader>_  :call ToggleLeadingUnderscoreOnWordUnderCursor()<CR>
augroup end

function! ToggleTrailingAwaitKeyword(line_number)
    " Toggles trailing `await` keyword on line of provided line number

    let trimmed_line_content = getline(a:line_number)->trim()

    " Ensure trimmed line is not empty
    if strchars(trimmed_line_content) > 0

        " TRAILING `?;`
        if trimmed_line_content =~# '?;$'
            " TRAILING `.await` BEHIND `?;`?
            if trimmed_line_content =~# '.await?;$'
                " YES: Remove trailing `.await`
                execute "normal mm$hd6h`m"
            else
                " NO: Insert `.await` behind trailing `?;`
                execute "normal mm$hi.await\e`m"
            endif

        " TRAILING `;`
        elseif trimmed_line_content =~# ';$'
            " TRAILING `.await` BEHIND `;`?
            if trimmed_line_content =~# '.await;$'
                " YES: Remove trailing `.await`
                execute "normal mm$d6h`m"
            else
                " NO: Insert `.await` behind trailing `;`
                execute "normal mm$i.await\e`m"
            endif

        " NO TRAILING `?;` OR `;`
        else
            " TRAILING `.await`?
            if trimmed_line_content =~# '.await$'
                " YES: Remove trailing `.await`
                execute "normal mm$d5hx`m"
            else
                " NO: Insert trailing `.await`
                execute "normal mmA.await\e`m"
            endif
        endif
    endif
endfunction
function! ToggleLeadingUnderscoreOnWordUnderCursor()
    " Toggles `_` on word under cursor
    "
    " NOTE: Uses `wb` to jump to first letter of word.
    " TODO:
    "   Fix bug where while `wb` always lands cursor at beginning of word,
    "   it has a catch where it can't work if cursor is on last letter of last
    "   word in file (and thereby also single letter words at end of file).

    " Get current word
    let word_under_cursor = expand("<cword>")

    " Act only if cursor is on top of a word that is at least 1 letter long
    if len(word_under_cursor) > 0
        if word_under_cursor =~# "^_"
            " Remove leading underscore on word under cursor
            execute 'normal mmwb"_x`mh'
        else
            " Insert leading underscore on word under cursor
            execute "normal mmwbi_\e`ml"
        endif
    endif
endfunction
function! ToggleWrappingTagOnCurrentLine(tag)
    " Toggles wrapping line content with supplied tag e.g. `Ok()` or `Err()`

    let trimmed_line_content = trim(getline("."))
    if len(trimmed_line_content) == 0
        " Empty line: Produce empty tag e.g. Ok(())
        execute 'normal I' . a:tag . '()'
    else
        " Non-empty line: Toggle tag around current line content. e.g. `Ok("x") and `"x"`

        " Check if line begins with tag name e.g. `Ok` or `Err`
        if trimmed_line_content =~#  '^' . a:tag
            " Remove leading tag and `(`
            execute 'normal ^d' . (len(a:tag)+1) . 'l'
            " Check if trailing semicolon
            if trimmed_line_content =~ ';$'
                " Remove `)` before trailing semicolon
                execute 'normal $h"_x'
            else
                " Remove trailing semicolon
                execute 'normal $"_x'
            endif
        else
            " Add leading tag and `(`
            execute 'normal I' . a:tag . '('
            " Check if trailing semicolon
            if trimmed_line_content =~ ';$'
                " Add `)` before trailing semicolon
                execute 'normal $i)'
            else
                " Add trailing `)`
                execute 'normal A)'
            endif
        endif
    endif
endfunction
function ToggleTrailingQuestionMark(line_number)
    " Toggles trailing `?` character in both `?` and `?;` forms
    " TODO: Adapt and use ToggleTrailingCharacterOnLine
    " LOGIC:
    "   1. Ensure non-empty trimmed line
    "   2. Check if there is a trailing `?`
    "       YES: Remove trailing `?`
    "       NO:  Check if there is a trailing `;`
    "               NO:  Add trailing `?`
    "               YES: Check if there is `?` behind trailing `;`
    "                       YES: Remove that `?` before trailing `;`
    "                       NO:  Add `?` before trailing `;`

    let line_content = getline(a:line_number)
    let trimmed_line_content = trim(line_content)

    " Ensure trimmed line is not empty
    if strwidth(trimmed_line_content) > 0
        " Check if there is a trailing `?`
        if (line_content[-1:] == '?' )
            " Remove trailing `?`
            call setline(a:line_number, line_content[:-2])
        else
            " Check if there is a trailing `;`
            if (line_content[-1:] == ';' )
                " Check if there is `?` behind trailing `;`
                if (line_content[-2:-1] == '?;' )
                    " Remove that `?` before trailing `;`
                    call setline(a:line_number, line_content[:-3] . ';')
                else
                    " Add `?` before trailing `;`
                    call setline(a:line_number, line_content[:-2] . '?;')
                endif
            else
                " Add trailing `?`
                call setline(a:line_number, line_content . '?')
            endif
        endif
    endif
endfunction
function! ToggleTrailingInto(line_number)
    " Toggles the into keyword on last word of a non-empty line.
    " TODO: Make more flexible i.e. remove hardocded positions.
    " LOGIC:
    "   line has trailing `;`?
    "       YES: line has `.into()` before trailing `;`?
    "               YES: remove `.into()` before trailing `;`
    "               NO: insert `.into()` before trailing `;`
    "       NO: line ends with `.into()`
    "               YES: remove .into()
    "               NO: append `.into()`

    let line_content = getline(a:line_number)
    let trimmed_line_content = trim(line_content)
    if len(trimmed_line_content) == 0
        " Ensure non-empty line
        return
    else
        if trimmed_line_content =~# ';$'
            if trimmed_line_content =~# 'into();$'
                execute 'normal $d7h'
            else
                execute 'normal $i.into()'
            endif
        else
            if trimmed_line_content =~# 'into()$'
                execute 'normal $d6hx'
            else
                echomsg "into()$"
                execute 'normal A.into()'
            endif
        endif
    endif
endfunction
function! ToggleAsyncKeywordRust(line_number)
    let line_content = getline(a:line_number)
    let trimmed_line_content = trim(line_content)
    if (trimmed_line_content =~# "^async ")
        execute 'normal ^d6l'
    else
        execute 'normal Iasync '
    endif
endfunction
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
    " TODO: Accept more than a single character
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
    " Chosing formatprg as hindent to keep a secondary formatprg at hand
    " NOTE: Requires `hindent` in `$PATH`
    " TODO: Call via `stack` (like `ALE` does for `hlint`)
    autocmd FileType haskell setlocal formatprg=hindent

    " Append current word with a trailing `'`
    " TODO: Use a function to allow adding and removing trailing `'`
    autocmd FileType haskell nnoremap <silent> <localleader>'  ea'<Esc>

    " Insert module line on new buffers
    " i.e. for a new buffer named `Foo.hs` add the module line `module Foo where`
    autocmd BufNewFile *.hs :execute
                \ "normal! Imodule " . expand("%:t:r") . " where\<cr>\<cr>\<esc>"
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

augroup filetype_elm
    " Insert module line on new buffers  i.e. for a new buffer named `Foo.elm`
    " add the module line at the top:
    "   `module Foo exposing (..)`
    autocmd BufNewFile *.elm :execute
                \ "normal! Imodule " . expand("%:t:r") . " exposing (..)\<cr>\<cr>\<esc>"
augroup end


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
set novisualbell        "Don't show visual bell (enabled when audio bell is turned off)
set belloff=all         "Stop all error bellsof
set formatoptions+=n    "Support lists (numbered, bulleted)
set virtualedit=block   "Allow cursor to go to invalid places only in visually selected blocks
set wildmode=full       "Tab-Completion ala zsh

set background=dark

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

" Change cursor shapes for different modes {{{2
"
" Reference for Terminal Escape Sequence Numbers for Cursor Shapes:
" +------------+-----------------------+
" | 0, 1, none | Blink Block (Default) |
" | 2          | Steady Block          |
" | 3          | Blink Underline       |
" | 4          | Steady Underline      |
" | 6          | Steady Vertical Bar   |
" +------------+-----------------------+
if $TERM =~ "xterm-kitty"
    let &t_SI="\033[6 q"
    let &t_SR="\033[4 q"
    let &t_EI="\033[2 q"
elseif $TERM_PROGRAM =~ "Apple_Terminal"
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
" NOTE:
"   1. This previous used to be `…` but in 9.x version,
"      so using `> ` in the meantime.
"   2. The trailing space required a backslash.
set showbreak=>\

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

"Whitespace {{{3
"TODO - More filetypes
"TODO - Move into a plugin to support prefs eg. `confirmations` or `conditions`
augroup whitespace_preferences
    autocmd!
    filetype on

    " NOTE:
    "   `softtabstop` set to 0 disables it.
    "   `shiftwidth` set to 0 makes it use `tabstop` value.

    autocmd FileType make setlocal tabstop=4 softtabstop=0 shiftwidth=0 noexpandtab
    autocmd FileType yaml setlocal tabstop=2 softtabstop=2 shiftwidth=0 expandtab

    autocmd FileType html,css,javascript,haskell
                \ setlocal
                \ tabstop=2
                \ softtabstop=2
                \ shiftwidth=2
                \ expandtab
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
    autocmd BufNewFile * silent! 0r ~/.vim/skeletons/skeleton.%:e
augroup end


"MAPPINGS {{{1
" Windows {{{2
" NOTE: These are deliberately identical to my tmux pane mappings
" Make horizontal split
" NOTE: Regretfully `<c-w>-` just doesn't fit into my vim mapping system..
" So temporarily relying on good ol' `<c-w>v` and `<c-w>s` for the splits.
" and freeing up `<c-w>-`. `vim-vinegar` can use it in the meantime.
" nnoremap <silent> <c-w>-        :split<CR>
" Make vertical split
" nnoremap <silent> <c-w>\|       :vsplit<CR>
" Equal size windows
nnoremap <silent> <leader>w=    :wincmd =<CR>
" Close all windows and exit
nnoremap <leader>Q              :qa<CR>
" Close all other windows(in current tab page)
" (`<c-w>o` for window, `<c-w>O` for tab page)
nnoremap <silent> <C-w>o        :<C-u>only<CR>

" Duplicate current window
" - Preferably the new window should be at the same cursor position
" - It's not really duplicated, but same as a regular `:split` but is a good
"   mnemonic and pairs well with my equivalent tab page operation
" - For windows it is `<c-w>d` and for tab pages it's `<c-w>D`
" - doing a `:split` and not a `:vsplit`
nnoremap <silent> <C-w>d        :<C-u>split<CR>

" Tab pages {{{2

" Duplicate current buffer in a new tab page and keep cursor position
nnoremap <silent> <C-w>D        :<C-u>tab split<CR>

" Quick jumps  {{{3
" Jump to last accessed tab page
nnoremap <silent> <C-w><C-w>     :tabnext #<CR>
" Jump to first and last tab pages using `1` and `0` ala my xmonad
nnoremap <silent> <C-w>`         :<c-u>tabfirst<CR>
nnoremap <silent> <C-w>0         :<c-u>tablast<CR>
" Jump to tab pages at positions `1-9`
" TODO: Make it so when a position isn't present, jump to largest tab position
"       i.e. if only `1-4` positions are present, on say `7` go to `4`.
nnoremap <silent> <C-w>1         :<c-u>tabfirst<CR>
nnoremap <silent> <C-w>2         :<c-u>execute "normal! 2gt"<CR>
nnoremap <silent> <C-w>3         :<c-u>execute "normal! 3gt"<CR>
nnoremap <silent> <C-w>4         :<c-u>execute "normal! 4gt"<CR>
nnoremap <silent> <C-w>5         :<c-u>execute "normal! 5gt"<CR>
nnoremap <silent> <C-w>6         :<c-u>execute "normal! 6gt"<CR>
nnoremap <silent> <C-w>7         :<c-u>execute "normal! 7gt"<CR>
nnoremap <silent> <C-w>8         :<c-u>execute "normal! 8gt"<CR>
nnoremap <silent> <C-w>9         :<c-u>execute "normal! 9gt"<CR>
" Jump to next/previous tab page with `<Tab>`
nnoremap <silent> <Tab>         :<c-u>tabnext<CR>
nnoremap <silent> <S-Tab>       :<c-u>tabprevious<CR>
"3}}}

" NOTE:
"   Doing the second part of the `<c-w>*` mappings both with and
"   without `<C-*>` to account for when a control is help onto longer
"   than from the first `<C-w>` key.

" Opening new tab pages
" OPTION 1 USING `<c-w>c/C`:
"   REASON: Matches with the tmux equivalent.
"   CONS: `<C-w>c` is used to close a vim window(and a tab if it only has one
"   window) but I want to have parity with the tmux key equivalents, hence
"   sticking with `<C-w>c` mapping. Due to the overlap with `<C-w>c` sometimes
"   vim misunderstands the mapping and closes window/tab instead, which is annoying
"   but the only solution is to stop using `<C-w>c` which I'm not going to do at the moment.
"
"   nnoremap <silent> <C-w>c        :<C-u>tabnew<CR>
"   nnoremap <silent> <C-w><C-c>    :<C-u>tabnew<CR>
"   nnoremap <silent> <C-w>C        :<C-u>-tabnew<CR>
"   nnoremap <silent> <C-w><C-C>    :<C-u>-tabnew<CR>
"
" OPTION 2 USING `<c-w>N`:
"   REASON: Matches with the vim new window shortcut `<c-w>n`.
"   CONS: `<c-w>N` is very close to my current kitty term's
"   meta key `Ctrl-Shift` because of the uppercase `N`. This is a con because
"   `META+W` closes current open tabpage in kitty, but it does ask to cofirm,
"   so there's that at least. Because of this, I'm not doing `<c-w><c-N>` here.
nnoremap <silent> <C-w>N        :<C-u>tabnew<CR>

" Closing tab pages
nnoremap <silent> <C-w>x        :<C-u>tabclose<CR>
nnoremap <silent> <C-w><C-x>    :<C-u>tabclose<CR>
" Close all other tab pages (`<c-w>o` for window, `<c-w>O` for tab page)
nnoremap <silent> <C-w>O        :<C-u>tabonly<CR>

" Move tab page forwards/backward
function! TabMoveBy1(rightOrLeft, isWrapped)
    " Moves tab page right or left by 1 and allows wrapping
    "
    " NOTE:
    "   1. There are quivalent commands like `:-tabmove` to move tab page left
    "       but in sitautions when already first, those commands' errors are too
    "       jarring for me.
    "   2. This function allows wrapping across the tab page list.
    "
    " Arguments:
    "   rightOrLeft
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
" 1. Within tmux do:`set-window-option -g xterm-keys on`
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
" WRAPPING OFF:
nnoremap <silent> <c-w><s-left>          :call TabMoveBy1("left", 0)<CR>
nnoremap <silent> <c-w><s-right>         :call TabMoveBy1("right", 0)<CR>
" WRAPPING ON:
" nnoremap <silent> <c-w><s-left>          :call TabMoveBy1("left", 1)<CR>
" nnoremap <silent> <c-w><s-right>         :call TabMoveBy1("right", 1)<CR>
" TO FIRST OR LAST: (`:tabmove 0` moves to the first position and `:tabmove` to the last)
" NOTE: Doing both gx and xg variations, because I forget otherwise.
nnoremap <silent> <c-w>g<s-left>          :<c-u>tabmove 0<CR>
nnoremap <silent> g<c-w><s-left>          :<c-u>tabmove 0<CR>
nnoremap <silent> <c-w>g<s-right>         :<c-u>tabmove<CR>
nnoremap <silent> g<c-w><s-right>         :<c-u>tabmove<CR>
"
" Simple Left/Right movement with no wrapping or error reporting.
" nnoremap <silent> <c-w><s-left>          :execute "tabmove -1"<CR>
" nnoremap <silent> <c-w><s-right>         :execute "tabmove +1"<CR>

" Rename tab page
" NOTE: Requires the `gcmt/taboo.vim` plugin
function! RenameTabpageWithTaboo(prefillCurrentTabpageName)
    " Renames current tab page name using a `Taboo.vim` plugin helper.
    " Arguments: prefillCurrentTabpageName (0 is False, 1 is True)
    " NOTE: It is desirable to go through the taboo plugin to rename the
    " tabpage over native commands.

    " Assert supplied argument values are valid first
    if !(index([0, 1], a:prefillCurrentTabpageName) >= 0)
        " Invalid a:prefillCurrentTabpageName:
        echoerr 'Invalid a:prefillCurrentTabpageName given. Should be `0` for False or `1` for True'
    else
        " Valid a:prefillCurrentTabpageName:
        if get(g:, 'loaded_taboo', 0) && exists("*TabooTabName")
            let l:currentTabPageName = TabooTabName(tabpagenr())
            if (len(l:currentTabPageName) == 0)
                let l:newName = input("TAB NAME: ")
            else
                if (a:prefillCurrentTabpageName == 0)
                    let l:newName = input("TAB NAME (" . l:currentTabPageName . "): ")
                else
                    let l:newName = input("TAB NAME (" . l:currentTabPageName . "): ", l:currentTabPageName)
                endif
            endif
            execute 'TabooRename ' . l:newName
        else
            " Taboo plugin is not loaded
            echoerr "Unable to rename tab (`gcmt/taboo.vim` plugin is not loaded)."
        endif
    endif
endfunction
nnoremap <silent> <C-w>,    :call RenameTabpageWithTaboo(0)<CR>

"Move through jump list {{{2
"ISSUE: By default `<c-o>` and `<c-i>` move backward and forward in jumplist.
"   but `<c-i>` is generally the same code as `Tab` which I use in tab page
"   navigation mappings, hence `<c-i>/Tab` is not available for this use.
"FIX: Use unimpaired-style mappings `[j` and `]j` to navigate the jump list.
" 1. Move backward/forward through jump list by 1 step
nnoremap <silent> [j :<c-u>execute "normal! \<c-o>"<CR>
nnoremap <silent> ]j :<c-u>execute "normal! 1\<c-i>"<CR>
" TODO: 2. Move to backward-most/forward-most position in jump list
" nnoremap <silent> [J
" nnoremap <silent> ]J

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

" Start from first considering comments {{{2
" `S`(synonym of `cc`) deletes content of line and starts insert linewise
" preserving indent. With `gS` do the same but leave preceding(/ending)
" comment markers intact i.e, for a line denoting `>` as indent level, doing
" `gS` at cursor position `|` will result in:
" 1. BEFORE: `>>>># Some comment|`
"    AFTER : `>>>>#|`
" 2. BEFORE: `>>>>Some line|`
"    AFTER : `>>>>|`
" 3. BEFORE: `>>>>/*Some line/*`
"    AFTER : `>>>>/*|*/`
" 3. BEFORE: `>>>>/* Some line /*`
"    AFTER : `>>>>/* | */`
" 4. BEFORE: `>>>>/*Some line|...`
"    AFTER : `>>>>/*|`

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

" Save session to global directory {{{2
" NOTE: Choosing global directory, i.e. directory where vim launched from, so
"   the `Session.vim` file will always exist in that directory as it will be
"   treated as project root directory. This is safe for instances when there is
"   a tabpage with a different working directory set with `:tcd` present.

" Create session file `./Session.vim` in global directory
nnoremap <leader>m :call MakeSessionInGlobalDirectory()<CR>
function! MakeSessionInGlobalDirectory()
    let path_separator = execute('version') =~# 'Windows' ? '\' : '/'
    try
        execute 'mksession' fnameescape(getcwd(-1) . path_separator . "Session.vim")
    catch /E189/ "Session already exists
        echoerr "ERROR E189: A `Session.vim` file already exists at this location."
        return
    endtry
    echo "Session.vim saved in global directory."
endfunction

" Create/overwrite session file `./Session.vim` in global directory
nnoremap <leader>M :call MakeSessionInGlobalDirectoryOverwriteIfNeeded()<CR>
function! MakeSessionInGlobalDirectoryOverwriteIfNeeded()
    let path_separator = execute('version') =~# 'Windows' ? '\' : '/'
    try
        execute 'mksession' fnameescape(getcwd(-1) . path_separator . "Session.vim")
    catch /E189/ "Session already exists
        execute 'mksession!' fnameescape(getcwd(-1) . path_separator . "Session.vim")
        echo "Session.vim overwritten in global directory."
        return
    endtry
    echo "Session.vim saved in global directory."
endfunction

" Start insert on new line from indent of existing text (i.e. `normal jS`) {{{2
" NOTE: `jS` doesn't work well, so using `j^C` to acheive the same effect
nnoremap go   :execute 'normal j^C'<CR>
nnoremap gO   :execute 'normal k^C'<CR>

" Move across "softly-wrapped" lines {{{2
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

" Make heading lines above/below current line with `[` & `]` {{{2
function DrawHeadingLineWithCharacter(character, aboveOrBelow)
    " Arguments:
    "   character: Character to use to draw in heading line
    "   aboveOrBelow: ['above', 'below']

    if !(index(['above', 'below'], a:aboveOrBelow) >= 0)
        " Invalid a:aboveOrBelow
        echoerr 'Invalid a:aboveOrBelow given. Should be `above` or `below`'

    elseif (strlen(a:character) != 1)
        "Invalid a:character length. Should be 1.
        echoerr 'Currently only supports a sigle character.'

    else
        let current_line_length = strdisplaywidth(getline('.'))
        let line_content = repeat(a:character, current_line_length)
        if a:aboveOrBelow == 'above'
            call append(line('.')-1, line_content)
        else " belo
            call append(line('.'), line_content)
        endif
    endif
endfunction
nnoremap <silent> [- :<c-u>call DrawHeadingLineWithCharacter('-', 'above')<CR>
nnoremap <silent> ]- :<c-u>call DrawHeadingLineWithCharacter('-', 'below')<CR>
nnoremap <silent> [_ :<c-u>call DrawHeadingLineWithCharacter('_', 'above')<CR>
nnoremap <silent> ]_ :<c-u>call DrawHeadingLineWithCharacter('_', 'below')<CR>
nnoremap <silent> [= :<c-u>call DrawHeadingLineWithCharacter('=', 'above')<CR>
nnoremap <silent> ]= :<c-u>call DrawHeadingLineWithCharacter('=', 'below')<CR>


"PLUGINS PREFERENCES {{{1
"tpope/vim-surround {{{2
"NOTE: There was a change made to use `S` in stead of `s` in visual mode, to
"not interfere with muscle memory but I don't use `v_s`, so going to to just
"`s` with `vim-surround` as I prefer that more than `v_s`.
vmap s S

"gruvbox {{{2
"Enable gruvbox colorscheme
colorscheme gruvbox
let g:gruvbox_contrast_dark = "hard"

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

" tpope/tpope-vim-abolish {{{2
" NOTE: Subvert is an abolish command
" NOTE: Temporarily disabled beacuse I'm using the <space><space> mapping for fzf search.
" nnoremap <Space> :%Subvert/<C-r>=expand("<cword>")<CR>

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
" NOTE: I'm using <spacE> instead of <c-p> now
nnoremap <silent> <nowait> <space><space>    :FZFFiles<CR>
nnoremap <silent> <nowait> <space>b          :FZFBuffers<CR>
nnoremap <silent> <nowait> <space>g          :FZFGFiles<CR>
nnoremap <silent> <nowait> <space>l          :FZFLines<CR>
nnoremap <silent> <nowait> <space>m          :FZFMaps<CR>
nnoremap <silent> <nowait> <space>r          :FZFRg<CR>
nnoremap <silent> <nowait> <space>t          :FZFTags<CR>
nnoremap <silent> <nowait> <space>w          :FZFWindows<CR>



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

" airline builtin extension - tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#tab_min_count = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline#extensions#tabline#show_tab_count = 0
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#tab_min_count = 1
" let g:airline#extensions#tabline#show_tab_nr = 1
" let g:airline#extensions#tabline#tab_nr_type = 1 " Just tab number

" Change alt seperators(ones away from active tab) to a taller glyph:
let g:airline#extensions#tabline#left_alt_sep = '│'
let g:airline#extensions#tabline#right_alt_sep = '│'

" Make airline theme modifications here
autocmd User AirlineAfterTheme call s:update_highlights()
function! s:update_highlights()
    " Subtle tabline bg
    " TODO: Uncouple from gruvbox theme look. Link to another highlight
    highlight airline_tabfill ctermfg=236 ctermbg=236
endfunction

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

"airline fzf extension
let g:airline#extensions#fzf#enabled = 1

" airline NerdTree extension
let g:airline#extensions#nerdtree_statusline = 1

" airline NrrwRgn integration
let g:airline#extensions#nrrwrgn#enabled = 1

" airline terminal integration
let g:airline#extensions#term#enabled = 1

"pangloss/vim-javascript {{{2
"Enable Concealing
set conceallevel=1
"Conceal corresponding keywords with symbols
let g:javascript_conceal_function = "ƒ"


" elixir-editors/vim-elixir {{{2
augroup eelixir_filetypes
    " TODO: Move to a seperate elixir/phoenix section
    autocmd BufNewFile,BufRead *.html.heex   set filetype=heex
    autocmd BufNewFile,BufRead *.html.eex    set filetype=eex

    autocmd BufNewFile,BufRead *.html.heex   set syntax=eelixir
    autocmd BufNewFile,BufRead *.html.eex    set syntax=eelixir
augroup END

"jiangmiao/auto-pairs {{{2
" Toggle autopairs (default: '<M-p>')
" TODO: Find replacement that works in insert-mode, or just stay with `<M-p>`
let g:AutoPairsShortcutToggle = 'yoa'

" Fast wrap word. All pairs, including `<>`, considered a block (default: `<M-e>`)
" TODO: Find a better shortcut. Ideal would have been a `<c-e>` variant like
" `<c-E>` but `<c-e>` is taken by `vim-rsi`, so look up what's using `<c-E>`
" Since I plan to use all `<M-*>` for overlays, I'm shunning default `<M-e>`
" let g:AutoPairsShortcutFastWrap = '<c-E>'

augroup rust_pairs
    autocmd!
    autocmd Filetype rust  let b:AutoPairs =
                \ extendnew(g:AutoPairs, {"|": "|", "<": ">"})
                \ ->filter({_idx, val -> val != "'"})
augroup END
augroup python_pairs
    autocmd!
    autocmd Filetype python let b:AutoPairs =
                \ extendnew(g:AutoPairs, {"__": "__"})
augroup end
augroup django_template_tag_pairs
    autocmd!
    autocmd Filetype htmldjango let b:AutoPairs =
                \ extendnew(g:AutoPairs, {"{%": "%}", "{{": "}}"})
augroup end
augroup elixir_template_tag_pairs
    autocmd Filetype heex,eex let b:AutoPairs =
                \ extendnew(g:AutoPairs, {"<%": "%>","<%=": "%>"})
augroup END

"junegunn/rainbow_parentheses.vim {{{2
let g:rainbow#pairs = [['(', ')'], ['[', ']'], [ '{', '}'], ['<', '>']]

" NOTE: Place after any vim-unimpaired preferences because I'm overriding the
" default `r` for `relativenumber` using in vim-unimpaired.
" Toggle
nnoremap <silent> yor :<c-u>RainbowParentheses!!<CR>
" Activate
nnoremap <silent> [or :<c-u>RainbowParentheses<CR>
" Deactivate
nnoremap <silent> ]or :<c-u>RainbowParentheses!<CR>


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
" Specify directory to create the tag files. instead of storing at project root
" TODO: Clean this cache directory occasionally it can get very large over time.
let g:gutentags_cache_dir = '~/.tags_cache'
let g:gutentags_project_info = [{'type': 'haskell', 'glob': '*.cabal'} ]
" Using `rob-b/gutenhasktags`:
" NOTE: See my private clone at: `kadimisetty/gutenhasktags`.
let g:gutentags_ctags_executable_haskell = 'gutenhasktags'

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
" Open GV commit browser
nnoremap <silent> <leader>g :call ToggleGVCommitBrowser('GV')<CR>
" Open GV commit browser with commits that affect current file only
nnoremap <silent> <localleader>g :call ToggleGVCommitBrowser('GV!')<CR>
" Note: Ignoring similar mapping for GV? because that might convolute
" my muscle memory

"neovimhaskell/haskell-vim {{{2
"Suggested changes from the README.
let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords
"Docs contains indentation configuration. Add if required.

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

" joukevandermaas/vim-ember-hbs {{{2
" Apply Error highlight to unescaped html inside `{{{` expressions
hi link hbsUnescapedIdentifier Error
" Apply Error highlight to the `{{{` and `}}}` tags themselves
hi link hbsUnescapedHandles Error

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

    " InDirect mappings to 'rust-lang/rust.vim' via `ReplaceCargoCommand`
    autocmd FileType rust nnoremap <silent> <leader>cr :call ReplaceCargoCommand('run')<CR>
    autocmd FileType rust nnoremap <silent> <leader>cb :call ReplaceCargoCommand('build')<CR>
    autocmd FileType rust nnoremap <silent> <leader>ct :call ReplaceCargoCommand('test')<CR>
    autocmd FileType rust nnoremap <silent> <leader>cc :call ReplaceCargoCommand('check')<CR>

    " Project specific Run Command
    autocmd FileType rust nnoremap <silent> <leader>r :call ReplaceCargoCommand('run')<CR>

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
augroup END

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


" janko/vim-test {{{2
nnoremap <silent> <leader>t      :<c-u>TestSuite<CR>
nnoremap <silent> <localleader>t :<c-u>TestFile<CR>
nnoremap <silent> <localleader>n :<c-u>TestNearest<CR>
nnoremap <silent> <leader>l      :<c-u>TestLast<CR>

" junegunn/goyo.vim {{{2
let g:goyo_width = 80
nnoremap <silent> <c-g> :Goyo<CR>

autocmd! User GoyoEnter nested call <SID>goyo_enter()
function! s:goyo_enter()
    set shortmess+=w
    set wrap linebreak
    nnoremap j gj
    nnoremap k gk
    nnoremap 0 g0
    nnoremap ^ g^
    nnoremap $ g$
    vnoremap j gj
    vnoremap k gk
    vnoremap 0 g0
    vnoremap ^ g^
    vnoremap $ g$
  if exists('$TMUX')
    silent !tmux set status off
    silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  endif
endfunction

autocmd! User GoyoLeave nested call <SID>goyo_leave()
function! s:goyo_leave()
    set shortmess-=w
    set nowrap nolinebreak
    unmap j
    unmap k
    unmap 0
    unmap ^
    unmap $
  if exists('$TMUX')
    silent !tmux set status on
    silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  endif
endfunction

" machakann/vim-highlightedyank {{{2
let g:highlightedyank_highlight_duration = 250

" fatih/vim-go {{{2
let g:go_def_mapping_enabled=0
augroup golang
    autocmd!

    " File specific
    autocmd FileType go nnoremap <silent> <localleader>f :GoFmt<CR>

    " Project specific
    autocmd FileType go nnoremap <silent> <leader>gb :GoBuild<CR>
    autocmd FileType go nnoremap <silent> <leader>gt :GoTest<CR>
    autocmd FileType go nnoremap <silent> <leader>gv :GoVet<CR>
    autocmd FileType go nnoremap <silent> <leader>gr :GoRun<CR>

    " Project specific Run Command
    autocmd FileType go nnoremap <silent> <leader>r :call RunGoRunOnCurrentDirectoryInTerminal()<CR>
    function! RunGoRunOnCurrentDirectoryInTerminal()
        " Run `go run .` in a terminal window. If a similar window already
        " exists from a previous run, that window is replaces. i.e.
        " i.e. it's buffer(and window) is deleted
        " and a fresh `go run .` command is run on a new term window

        " Get a list of open buffers in current tabpage and close them if
        " their name matches with the supplied go command. Then run the
        " desired command
        let buffers_in_current_tabpage = tabpagebuflist(tabpagenr())
        for b in buffers_in_current_tabpage
            " Check if buffer has matching name and is of type `terminal`
            if  (bufname(b) =~# ('^!go run .' )) && (getbufvar(b, '&buftype') ==# 'terminal' )
                execute ('bdelete ' . b)
            endif
        endfor
        execute (':terminal go run .')
    endfunction
augroup END

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
let g:taboo_tab_format = "%d %f"
let g:taboo_renamed_tab_format = "%d %l"


" neoclide/coc.nvim {{{2
" Coc Mappings {{{3
" NOTE: Using `l` for lsp as a mnemonic
" NOTE: Keep these mappings as nmaps and not nnoremaps
" Navigate all diagnostics
nmap <silent> [l <Plug>(coc-diagnostic-prev)
nmap <silent> ]l <Plug>(coc-diagnostic-next)
" Navigate only error diagnostics
nmap <silent> [L <Plug>(coc-diagnostic-prev-error)
nmap <silent> ]L <Plug>(coc-diagnostic-next-error)

nmap <silent> ld <Plug>(coc-definition)
nmap <silent> ly <Plug>(coc-type-definition)
nmap <silent> lr <Plug>(coc-rename)
nmap <silent> ln <Plug>(coc-references)
nmap <silent> lt <Plug>(coc-refactor)
nmap <silent> li <Plug>(coc-implementation)
nmap <silent> <localleader>x <Plug>(coc-fix-current)
" nmap <silent> lr <Plug>(coc-references)
nmap <silent> l. <plug>(coc-command-repeat)
vmap <silent> l. <plug>(coc-command-repeat)
"`s` mnemonic for `sort import`. TODO: Make this use a plug.
nmap <silent> ls :<c-u>call CocAction('organizeImport')<CR>
" search workspace symbols (use space like rest of my search mappings)
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" codeactions on current line
nmap <silent> la <Plug>(coc-codeaction-line)
vmap <silent> la <Plug>(coc-codeaction-selected)
" codeaction on entire file
nmap <silent> lA <Plug>(coc-codeaction)

" Toggle outline
nnoremap <silent><nowait> lo  :call ToggleOutline()<CR>
function! ToggleOutline() abort
let winid = coc#window#find('cocViewId', 'Outline')
if winid == -1
    call CocActionAsync('showOutline', 1)
else
    call coc#window#close(winid)
endif
endfunction

" Format visual selection
vmap lf  <Plug>(coc-format-selected)
" Format entire buffer
nmap lf  <Plug>(coc-format)
" TODO: Make `coc-format` action work on motions for e.g. `gfip`

" Run `:CocFix` and choose fix
nnoremap <silent> lx :<c-u>CocFix<cr>
" Try fix on current line
nmap <silent> lX <Plug>(coc-fix-current)

" Enable/Disable/Toggle Coc with unimpaired-style mappings
" Clash with unimpaired's `l` for line endings
nnoremap <silent> ]ol :<c-u>CocDisable<CR>
nnoremap <silent> [ol :<c-u>CocEnable<CR>
nnoremap <silent> yol :call CocAction('diagnosticToggle')<CR>

" Toggle `inlay hints` (implemented via virtual text in vim9)
" NOTE: Enable/disable actions aren't available in coc-nvim yet.
nnoremap <silent> yoh :CocCommand document.toggleInlayHint<CR>

" Show Documentation
nnoremap <silent> lk :call <SID>coc_show_documentation()<CR>
function! s:coc_show_documentation()
    "Note: This can be closed with :pclose which I mapped into <leader>z
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

" Coc Text Objects {{{3
" NOTE: Text objects require 'textDocument.documentSymbol' lsp support
" Functions
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)
" Structs/Classes
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Coc Completions {{{3
" Use <c-space> to trigger completion:
if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
else
    inoremap <silent><expr> <c-@> coc#refresh()
endif

" To make <CR> confirm selection of selected complete item or notify coc.nvim
" to format on enter:
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#_select_confirm()
            \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Helper function for trigger completion
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Trigger Completion Strategy:
" Make <tab> behave like in VSCode i.e. for:
"  1. Trigger completion
"  2. Completion confirm
"  3. Snippet expand
"  4. Jump
" NOTE: `coc-snippets` extension required for this to work
" NOTE: With this strategy, cannot utilize <S-Tab>
inoremap <silent><expr> <TAB>
  \ coc#pum#visible() ? coc#_select_confirm() :
  \ coc#expandableOrJumpable() ?
  \ "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ coc#refresh()

" Trigger keys to go next/prev in snippet insertion positions:
" Defaults are <C-j> for next and <C-k> for prev
" let g:coc_snippet_next='<C-j>'
" let g:coc_snippet_prev='<C-k>'

" Coc Highlights {{{3
" Contrast in CocFloating + gruvbox is terrible, so changing highlight group.
" IMPORTANT: Needs to be done AFTER loading gruvbox
" TODO: `CocFloating` links to `Pmenu`, so configure `Pmenu` directly
highlight CocDisabled ctermbg=237 ctermfg=240
highlight CocFloating term=standout ctermbg=237 ctermfg=250
" NOTE: CocMenuSel can only accomodate `bg` not `fg`
highlight CocMenuSel ctermbg=238

" Coc Miscellaneous {{{3
" Use `:CocFormat` to format current buffer
command! -nargs=0 CocFormat :call CocAction('format')
" Use `:CocFold` to fold current buffer
command! -nargs=? CocFold :call CocAction('fold', <f-args>)
" use `:CocOR` for organize import of current buffer
command! -nargs=0 CocOR   :call CocAction('runCommand', 'editor.action.organizeImport')

" Load coc extensions (activated by filetype)
let g:coc_global_extensions = [
            \ 'coc-vimlsp',
            \ 'coc-snippets',
            \ 'coc-json',
            \ 'coc-pyright',
            \ 'coc-elixir',
            \ 'coc-rust-analyzer'
            \ ]

" Coc recommends faster update time to show diagnostic messages (default is 4000ms)
set updatetime=300

" Disable ins-completion-menu messages like match 1 of 2, Pattern not found etc.
set shortmess+=c

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

augroup coc_update_signature_help_on_jump_placeholder
  autocmd!
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end


" TRANSIENT PREFERENCES {{{1
function! SourceFileIfExists(filename)
    " SourceFileIfExists checks wheether file with supplied filename exists
    " before sourcing it
    if filereadable(expand(a:filename))
        execute 'source ' . fnameescape(a:filename)
    endif
endfunction
call SourceFileIfExists('~/.vim-local-preferences.vim')
call SourceFileIfExists('~/.vim-transient-preferences.vim')
call SourceFileIfExists('~/.vim-experiments.vim')


" ANYTHING BELOW THIS LINE WAS ADDED IN HASTE AND NEEDS TO BE SORTED {{{1
