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

"Enable Syntax highlighting
syntax enable

"Make backspace behave more like the popular usage
set backspace=2


" BEHAVIOR {{{1
" Make W and Q beahve like their lower case counterparts
command! W w
command! Q q


" MOVEMENT {{{1
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

"FUNCTIONS {{{1
function! RemoveTrailingWhitespace ()
     call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))
endfunction
command! -nargs=0 RemoveTrailingWhitespace :call RemoveTrailingWhitespace()

function! MoveHelpToNewTab ()
    if &buftype ==# 'help' | wincmd T | endif
endfunction


" MAPPING {{{1
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


" FILETYPE {{{1
augroup filetype_help
    autocmd!
    autocmd FileType help setlocal textwidth=80
    autocmd BufWinEnter *.txt call MoveHelpToNewTab()
augroup end

" OTHER PREFERENCES {{{1


