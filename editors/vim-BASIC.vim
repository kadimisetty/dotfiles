"  VIM BASIC CONFIGURATION {{{1
" vim: foldmethod=marker:foldlevel=0:nofoldenable:
" Author: [Sri Kadimisetty](https://github.com/kadimisetty)
"
" NOTES {{{1
" This is a basic plugin-free vim configuration.
" TODO: Tune UI
" TODO: Fix cursor shapes (bloc/bar/underline in appropriate modes).
" INSTALLATION INSTRUCTIONS {{{2
" 1. Start a clean vim session with just this configuration.
"   `$ vim --clean -S $THISFILE.vim`
" 2. Setup as main configuration by making this file available at `$HOME/.vimrc`


" APPEARANCE {{{1
" Show status bar
set laststatus=1
" Show the ruler
set ruler
" Show partial commands on the bottom right
set showcmd
" Show mode updates in the bottom left
set showmode
" Don't show line numbers untill necessary
set number
" Do not shift cursor back to line beginning while scrolling
set nostartofline
" Do not show a visual bell indication
set novisualbell
" Shell like tab-completion
set wildmode=full
" Hide tilde characters that represent non-existent lines after last line
highlight EndOfBuffer ctermfg=black ctermbg=black
"Enable Syntax highlighting
syntax enable
"Make backspace behave more like the popular usage
set backspace=2


" BEHAVIORS {{{1
" Make W and Q behave like their lower case counterparts
command! W w
command! Q q
" Replace Vim's startup screen
augroup startup_screen
    autocmd VimEnter * call CustomizeStartupScreen()
augroup end


" MOVEMENTS {{{1
" Move between tabs with just the <tab> key
nnoremap <tab>      :tabnext<cr>
nnoremap <s-tab>    :tabprevious<cr>
"Move focus to window facing h
nnoremap <silent> <c-h> :wincmd h<cr>
"Move focus to window facing j
nnoremap <silent> <c-j> :wincmd j<cr>
"Move focus to window facing k
nnoremap <silent> <c-k> :wincmd k<cr>
"Move focus to window facing l
nnoremap <silent> <c-l> :wincmd l<cr>


" LIB {{{1
" Customizes the Vim startup screen {{{2
function! CustomizeStartupScreen()
    " Verify vim started without arguments
    if (!argc() && line2byte('$') == -1)
        " Start a new buffer and make it act like a start screen
        enew
        silent! setlocal
                    \ bufhidden=wipe
                    \ colorcolumn=
                    \ foldcolumn=0
                    \ matchpairs=
                    \ nobuflisted
                    \ nocursorcolumn
                    \ nocursorline
                    \ nolist
                    \ nonumber
                    \ norelativenumber
                    \ nospell
                    \ noswapfile
                    \ signcolumn=no
                    \ synmaxcol&
        " Display message
        call append('$', "")
        call append('$', "HELLO " . toupper($USER))
        call append('$', "Vim v" . v:version)")
        call append('$', "")
        call append('$', "-------------------------------------------")
        call append('$', "type i                 to start insert mode")
        call append('$', "type :edit <FILENAME>  to edit a file")
        call append('$', "type :help             to get help")
        call append('$', "type :q                to quit")
        " Turn off all modifications to this buffer
        setlocal nomodifiable nomodified
        " On beginning insert mode, start a new buffer and business as usual
        nnoremap <buffer><silent> e :enew<cr>
        nnoremap <buffer><silent> i :enew <bar> startinsert<cr>
        nnoremap <buffer><silent> o :enew <bar> startinsert<cr>
        " Shortcuts to quit
        nnoremap <buffer><silent> ZZ :quit<cr>
    endif
endfunction
" Moves the help window into it's own tab {{{2
function! MoveHelpToNewTab ()
    if &buftype ==# 'help' | wincmd T | endif
endfunction


" UTILITIES {{{1
" REMOVES TRAILING WHITESPACE IN ENTIRE BUFFER {{{2
function! RemoveTrailingWhitespace ()
     call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))
endfunction
command! -nargs=0 RemoveTrailingWhitespace :call RemoveTrailingWhitespace()


" MAPPINGS {{{1
" Save with `<c-s>`
nnoremap <c-s>  <cmd>update<cr>
vnoremap <c-s>  <cmd>:update<cr>
inoremap <c-s>  <cmd>:update<cr>
" Retain visual selection after an indentation shift.
vnoremap < <gv
vnoremap > >gv
" Yank to end of line, just like C or D
nnoremap Y y$
" Retain cursor position after done joining two lines
nnoremap J mzJ`z


" CUSTOM FILETYPE SETTINGS {{{1
augroup filetype_help
    autocmd!
    autocmd FileType help setlocal textwidth=80
    autocmd BufWinEnter *.txt call MoveHelpToNewTab()
augroup end


" MISCELLANEOUS - SORT ANYTHING ADDED UNDER THIS LINE {{{1
