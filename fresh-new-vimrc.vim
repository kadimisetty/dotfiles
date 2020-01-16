" vim: foldmethod=marker:foldlevel=0:nofoldenable:
"
" SRI'S FRESH VIMRC {{{1
" A basic fresh vimrc designed to be used by a clean vim that can be started with
"   $ vim --clean -S ./clean-vimrc.vim
"
" Author: Sri Kadimisetty <https://github.com/kadimisetty>




" APPEARANCE {{{1

" COLORSCHEME {{{2
set t_Co=256
" }}}2

" Don't show the status line
set laststatus=0

" Don't show the ruler
set noruler

" Don't show partial commands on the bottom right
set noshowcmd

" Don't show mode updates in the bottom left
set noshowmode

" Don't show line numbers untill necessary
set nonumber

" Do not shift cursor back to line beginning while scrolling
set nostartofline

" Show a visual indication instead of ringing an annoying bell.
set visualbell

" Shell like tab-completion
set wildmode=full

" Hide tilde characters that represent non-existent lines after last line
highlight EndOfBuffer ctermfg=black ctermbg=black

" CHANGE CURSOR SHAPE BASED ON MODE {{{2
" Terminal Escape Sequence Numbers for Cursor Shapes:
"   0, 1 or none - Blink Block (Default)
"   2 - Steady Block
"   3 - Blink Underline
"   4 - Steady Underline
"   6 - Steady Vertical Bar
if $TERM_PROGRAM =~ "Apple_Terminal"
    "Vertical bar in Insert mode
    let &t_SI="\033[6 q"
    "Underline in Replace mode
    let &t_SR="\033[4 q"
    "Steady Block in Normal mode
    let &t_EI="\033[2 q"
elseif $TERM_PROGRAM =~ "Hyper"
    "Vertical bar in Insert mode
    let &t_SI="\033[6 q"
    "Underline in Replace mode
    let &t_SR="\033[4 q"
    "Steady Block in Normal mode
    let &t_EI="\033[2 q"
elseif $TERM_PROGRAM =~ "iTerm"
    "iTerm cursors look much better, especially contrast on hover.
    "https://hamberg.no/erlend/posts/2014-03-09-change-vim-cursor-in-iterm.html
    "Vertical bar in Insert mode
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    "Steady Block in Normal mode
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
    "Underline in Replace mode
    let &t_SR = "\<esc>]50;CursorShape=2\x7"
endif
" }}}2

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
" Move between tabs with just the <Tab> key
nnoremap <Tab>      :tabnext<CR>
nnoremap <S-Tab>    :tabprevious<CR>

"Move focus to window facing h
nnoremap <silent> <C-h> :wincmd h<CR>
"Move focus to window facing j
nnoremap <silent> <C-j> :wincmd j<CR>
"Move focus to window facing k
nnoremap <silent> <C-k> :wincmd k<CR>
"Move focus to window facing l
nnoremap <silent> <C-l> :wincmd l<CR>




"FUNCTIONS & COMMANDS {{{1

" Removes trailing whitespace in entire buffer
function! RemoveTrailingWhitespace ()
     call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))
endfunction
command! -nargs=0 RemoveTrailingWhitespace :call RemoveTrailingWhitespace()

" Moves the help window into it's own tab
function! MoveHelpToNewTab ()
    if &buftype ==# 'help' | wincmd T | endif
endfunction

" Customizes the Vim startup screen
function! CustomizeStartupScreen()
    " Verify vim started without arguments
    if (!argc() && line2byte('$') == -1)

        " Start a new buffer and make it act like a start screen
        enew
        setlocal
                    \ bufhidden=wipe
                    \ buftype=nofile
                    \ nobuflisted
                    \ nocursorcolumn
                    \ nocursorline
                    \ nolist
                    \ nonumber
                    \ norelativenumber
                    \ noswapfile

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

        " On begiinning insert mode, start a new buffer and business as usual
        nnoremap <buffer><silent> e :enew<CR>
        nnoremap <buffer><silent> i :enew <bar> startinsert<CR>
        nnoremap <buffer><silent> o :enew <bar> startinsert<CR>

        " Shortcuts to quit
        nnoremap <buffer><silent> ZZ :quit<CR>
    endif
endfunction




" MAPPINGS {{{1

" Save with Ctrl-S
nnoremap <C-S>  :update<CR>
vnoremap <C-S>  <C-C>:update<CR>
inoremap <C-S>  <C-O>:update<CR>

" Retain visual selection after an indentation shift.
vnoremap < <gv
vnoremap > >gv
" Yank to end of line, just like C or D
nnoremap Y y$
" Retain cursor position after done joining two lines
nnoremap J mzJ`z




" FILETYPES {{{1

augroup filetype_help
    autocmd!
    autocmd FileType help setlocal textwidth=80
    autocmd BufWinEnter *.txt call MoveHelpToNewTab()
augroup end




" MISCELLANEOUS {{{1


