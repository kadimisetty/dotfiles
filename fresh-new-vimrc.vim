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
" Colorscheme colors from corporation_modified from http://bytefluent.com/vivify/
hi Normal guifg=#e1e1e6 guibg=#192224 guisp=#192224 gui=NONE ctermfg=254 ctermbg=235 cterm=NONE
hi IncSearch guifg=#2b3b3e guibg=#BD9800 guisp=#BD9800 gui=NONE ctermfg=237 ctermbg=1 cterm=NONE
hi WildMenu guifg=NONE guibg=#A1A6A8 guisp=#A1A6A8 gui=NONE ctermfg=NONE ctermbg=248 cterm=NONE
hi SignColumn guifg=#2b3b3e guibg=#536991 guisp=#536991 gui=NONE ctermfg=237 ctermbg=60 cterm=NONE
hi SpecialComment guifg=#d6ab00 guibg=NONE guisp=NONE gui=NONE ctermfg=178 ctermbg=NONE cterm=NONE
hi Typedef guifg=#637dad guibg=NONE guisp=NONE gui=bold ctermfg=67 ctermbg=NONE cterm=bold
hi Title guifg=#e1e1e6 guibg=#192224 guisp=#192224 gui=bold ctermfg=254 ctermbg=235 cterm=bold
hi Folded guifg=#2b3b3e guibg=#A1A6A8 guisp=#A1A6A8 gui=italic ctermfg=237 ctermbg=248 cterm=NONE
hi PreCondit guifg=#d6ab00 guibg=NONE guisp=NONE gui=NONE ctermfg=178 ctermbg=NONE cterm=NONE
hi Include guifg=#d6ab00 guibg=NONE guisp=NONE gui=NONE ctermfg=178 ctermbg=NONE cterm=NONE
hi TabLineSel guifg=#2b3b3e guibg=#BD9800 guisp=#BD9800 gui=bold ctermfg=237 ctermbg=1 cterm=bold
hi StatusLineNC guifg=#2b3b3e guibg=#5E6C70 guisp=#5E6C70 gui=bold ctermfg=237 ctermbg=66 cterm=bold
hi NonText guifg=#76878c guibg=NONE guisp=NONE gui=italic ctermfg=66 ctermbg=NONE cterm=NONE
hi DiffText guifg=NONE guibg=#492224 guisp=#492224 gui=NONE ctermfg=NONE ctermbg=52 cterm=NONE
hi ErrorMsg guifg=#bbc1c3 guibg=#912C00 guisp=#912C00 gui=NONE ctermfg=7 ctermbg=88 cterm=NONE
hi Debug guifg=#d6ab00 guibg=NONE guisp=NONE gui=NONE ctermfg=178 ctermbg=NONE cterm=NONE
hi PMenuSbar guifg=NONE guibg=#848688 guisp=#848688 gui=NONE ctermfg=NONE ctermbg=102 cterm=NONE
hi Identifier guifg=#d6ab00 guibg=NONE guisp=NONE gui=NONE ctermfg=178 ctermbg=NONE cterm=NONE
hi SpecialChar guifg=#d6ab00 guibg=NONE guisp=NONE gui=NONE ctermfg=178 ctermbg=NONE cterm=NONE
hi Conditional guifg=#d6ab00 guibg=NONE guisp=NONE gui=bold ctermfg=178 ctermbg=NONE cterm=bold
hi StorageClass guifg=#637dad guibg=NONE guisp=NONE gui=bold ctermfg=67 ctermbg=NONE cterm=bold
hi Todo guifg=#e1e1e6 guibg=#BD9800 guisp=#BD9800 gui=NONE ctermfg=254 ctermbg=1 cterm=NONE
hi Special guifg=#d6ab00 guibg=NONE guisp=NONE gui=NONE ctermfg=178 ctermbg=NONE cterm=NONE
hi LineNr guifg=#d6ab00 guibg=NONE guisp=NONE gui=NONE ctermfg=178 ctermbg=NONE cterm=NONE
hi StatusLine guifg=#2b3b3e guibg=#BD9800 guisp=#BD9800 gui=bold ctermfg=237 ctermbg=1 cterm=bold
hi Label guifg=#d6ab00 guibg=NONE guisp=NONE gui=bold ctermfg=178 ctermbg=NONE cterm=bold
hi PMenuSel guifg=#2b3b3e guibg=#BD9800 guisp=#BD9800 gui=NONE ctermfg=237 ctermbg=1 cterm=NONE
hi Search guifg=#2b3b3e guibg=#BD9800 guisp=#BD9800 gui=NONE ctermfg=237 ctermbg=1 cterm=NONE
hi Delimiter guifg=#d6ab00 guibg=NONE guisp=NONE gui=NONE ctermfg=178 ctermbg=NONE cterm=NONE
hi Statement guifg=#d6ab00 guibg=NONE guisp=NONE gui=bold ctermfg=178 ctermbg=NONE cterm=bold
hi SpellRare guifg=#e1e1e6 guibg=#192224 guisp=#192224 gui=underline ctermfg=254 ctermbg=235 cterm=underline
hi Comment guifg=#76878c guibg=NONE guisp=NONE gui=italic ctermfg=66 ctermbg=NONE cterm=NONE
hi Character guifg=#bbc1c3 guibg=NONE guisp=NONE gui=NONE ctermfg=7 ctermbg=NONE cterm=NONE
hi Float guifg=#bbc1c3 guibg=NONE guisp=NONE gui=NONE ctermfg=7 ctermbg=NONE cterm=NONE
hi Number guifg=#bbc1c3 guibg=NONE guisp=NONE gui=NONE ctermfg=7 ctermbg=NONE cterm=NONE
hi Boolean guifg=#bbc1c3 guibg=NONE guisp=NONE gui=NONE ctermfg=7 ctermbg=NONE cterm=NONE
hi Operator guifg=#d6ab00 guibg=NONE guisp=NONE gui=bold ctermfg=178 ctermbg=NONE cterm=bold
hi CursorLine guifg=NONE guibg=#222E30 guisp=#222E30 gui=NONE ctermfg=NONE ctermbg=236 cterm=NONE
hi TabLineFill guifg=#2b3b3e guibg=#5E6C70 guisp=#5E6C70 gui=bold ctermfg=237 ctermbg=66 cterm=bold
hi WarningMsg guifg=#bbc1c3 guibg=#912C00 guisp=#912C00 gui=NONE ctermfg=7 ctermbg=88 cterm=NONE
hi VisualNOS guifg=#2b3b3e guibg=#F9F9FF guisp=#F9F9FF gui=underline ctermfg=237 ctermbg=189 cterm=underline
hi DiffDelete guifg=NONE guibg=#192224 guisp=#192224 gui=NONE ctermfg=NONE ctermbg=235 cterm=NONE
hi ModeMsg guifg=#e6e6e6 guibg=#192224 guisp=#192224 gui=bold ctermfg=254 ctermbg=235 cterm=bold
hi CursorColumn guifg=NONE guibg=#222E30 guisp=#222E30 gui=NONE ctermfg=NONE ctermbg=236 cterm=NONE
hi Define guifg=#d6ab00 guibg=NONE guisp=NONE gui=NONE ctermfg=178 ctermbg=NONE cterm=NONE
hi Function guifg=#637dad guibg=NONE guisp=NONE gui=bold ctermfg=67 ctermbg=NONE cterm=bold
hi FoldColumn guifg=#2b3b3e guibg=#A1A6A8 guisp=#A1A6A8 gui=italic ctermfg=237 ctermbg=248 cterm=NONE
hi PreProc guifg=#d6ab00 guibg=NONE guisp=NONE gui=NONE ctermfg=178 ctermbg=NONE cterm=NONE
hi Visual guifg=#2b3b3e guibg=#F9F9FF guisp=#F9F9FF gui=NONE ctermfg=237 ctermbg=189 cterm=NONE
hi MoreMsg guifg=#d6ab00 guibg=NONE guisp=NONE gui=bold ctermfg=178 ctermbg=NONE cterm=bold
hi SpellCap guifg=#e1e1e6 guibg=#192224 guisp=#192224 gui=underline ctermfg=254 ctermbg=235 cterm=underline
hi VertSplit guifg=#2b3b3e guibg=#5E6C70 guisp=#5E6C70 gui=bold ctermfg=237 ctermbg=66 cterm=bold
hi Exception guifg=#d6ab00 guibg=NONE guisp=NONE gui=bold ctermfg=178 ctermbg=NONE cterm=bold
hi Keyword guifg=#d6ab00 guibg=NONE guisp=NONE gui=bold ctermfg=178 ctermbg=NONE cterm=bold
hi Type guifg=#637dad guibg=NONE guisp=NONE gui=bold ctermfg=67 ctermbg=NONE cterm=bold
hi DiffChange guifg=NONE guibg=#492224 guisp=#492224 gui=NONE ctermfg=NONE ctermbg=52 cterm=NONE
hi Cursor guifg=#2b3b3e guibg=#F9F9F9 guisp=#F9F9F9 gui=NONE ctermfg=237 ctermbg=15 cterm=NONE
hi SpellLocal guifg=#e1e1e6 guibg=#192224 guisp=#192224 gui=underline ctermfg=254 ctermbg=235 cterm=underline
hi Error guifg=#bbc1c3 guibg=#912C00 guisp=#912C00 gui=NONE ctermfg=7 ctermbg=88 cterm=NONE
hi PMenu guifg=#2b3b3e guibg=#5E6C70 guisp=#5E6C70 gui=NONE ctermfg=237 ctermbg=66 cterm=NONE
hi SpecialKey guifg=#76878c guibg=NONE guisp=NONE gui=italic ctermfg=66 ctermbg=NONE cterm=NONE
hi Constant guifg=#bbc1c3 guibg=NONE guisp=NONE gui=NONE ctermfg=7 ctermbg=NONE cterm=NONE
hi Tag guifg=#d6ab00 guibg=NONE guisp=NONE gui=NONE ctermfg=178 ctermbg=NONE cterm=NONE
hi String guifg=#bbc1c3 guibg=NONE guisp=NONE gui=NONE ctermfg=7 ctermbg=NONE cterm=NONE
hi PMenuThumb guifg=NONE guibg=#a4a6a8 guisp=#a4a6a8 gui=NONE ctermfg=NONE ctermbg=248 cterm=NONE
hi MatchParen guifg=#d6ab00 guibg=NONE guisp=NONE gui=bold ctermfg=178 ctermbg=NONE cterm=bold
hi Repeat guifg=#d6ab00 guibg=NONE guisp=NONE gui=bold ctermfg=178 ctermbg=NONE cterm=bold
hi SpellBad guifg=#e1e1e6 guibg=#192224 guisp=#192224 gui=underline ctermfg=254 ctermbg=235 cterm=underline
hi Directory guifg=#637dad guibg=NONE guisp=NONE gui=bold ctermfg=67 ctermbg=NONE cterm=bold
hi Structure guifg=#637dad guibg=NONE guisp=NONE gui=bold ctermfg=67 ctermbg=NONE cterm=bold
hi Macro guifg=#d6ab00 guibg=NONE guisp=NONE gui=NONE ctermfg=178 ctermbg=NONE cterm=NONE
hi Underlined guifg=#e1e1e6 guibg=#192224 guisp=#192224 gui=underline ctermfg=254 ctermbg=235 cterm=underline
hi DiffAdd guifg=NONE guibg=#193224 guisp=#193224 gui=NONE ctermfg=NONE ctermbg=236 cterm=NONE
hi TabLine guifg=#2b3b3e guibg=#5E6C70 guisp=#5E6C70 gui=bold ctermfg=237 ctermbg=66 cterm=bold
hi cursorim guifg=#2b3b3e guibg=#536991 guisp=#536991 gui=NONE ctermfg=237 ctermbg=60 cterm=NONE
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


