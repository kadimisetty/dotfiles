-- NVIM CONFIGURATION: {{{1
-- vim: foldmethod=marker:foldlevel=0:nofoldenable:
-- Sri Kadimisetty

-- TODO:
-- - Ensure all keymaps have `desc`.
-- - Convert vim fucntions into lua functions.
-- - Convert vim autocmd commands into lua commands as much as possible.
-- - Places to occasionally purge:
--     - `undodir` for sake of `mundo.vim`,
--     - `viewdir` for clearing out old saved views.
-- - Remove `clear=true` from all groups? because the default is true, isn't it?
-- - Ensure all autocmds (and mappings) have
-- 		a description field. Consider leaving out the
-- 		comment for those, to avoid duplication.
-- - `<cmd>` does not get `echo`ed, so `<silent>` is redundant; make a note
--     	somewhere and remove the `<silent>`s.
-- - Remove the default `gs` (the sleep thing)
-- - Use lua for all functions
-- - Whitespace removal:
--     - Changed lines only
-- - Command with more options e.g. entire-file/changed-lines/tabs>spaces etc.
-- - something akin to `airline_mode_map`, which allows changing the symbols
-- for mode indicators. Refer to my shortcuts in my vimrc.

-- NOTE:
-- Keymap Grammar:
--  +------------------+----------------------+
--  | LEADERS          | SCOPE 				  |
--  +------------------+----------------------+
--  |                  |                 	  |
--  | `<leader>x`      | Global actions  	  |
--  | `<localleader>x` | Buffer actions  	  |
--  | `gx`             | Auxiliary actions    |
--  |                  |                 	  |
--  | `<space>x` 	   | Search(Telescope)    |
--  |                  |                 	  |
--  | `<c-w>x`         | Windows      		  |
--  | `<c-w>X`         | Tabs         		  |
--  |                  |                 	  |
--  | `<m-x>`/`<m-X>`  | Overlays             |
--  | `<c-x>` 		   | Actions              |
--  |                  |                 	  |
--  | `lx` 			   | LSP?    			  |
--  | `<c-m-x>`        | LSP?            	  |
--  |                  |                 	  |
--  | `yox`            | Toggle x        	  |
--  | `]ox`            | Enable x        	  |
--  | `[ox`            | Disable x       	  |
--  | `]x`             | Do/go-to next x 	  |
--  | `[x`             | Do/go-to previous x  |
--  |                  |                 	  |
--  +------------------+----------------------+

-- GENERAL PREFERENCES {{{1
-- LEADERS {{{2
vim.g.mapleader = [[\]]
vim.g.maplocalleader = [[\\]]

-- ENCODING {{{2
-- NOTE: Skip setting encoding as nvim utf-8 defaults are satisfactory.
-- set encoding=utf-8
-- scriptencoding  utf-8

-- SEARCH {{{2
-- Infer case matching while doing keyword completions
vim.opt.infercase = true

-- Enable case insensitive Search
vim.opt.ignorecase = true

-- Perform case-detection slightly more sensibly
vim.opt.smartcase = true

-- Highlight search patterns
vim.opt.hlsearch = true

-- Wrap search scan around the file
vim.opt.wrapscan = true

-- Update highlight on search pattern matches as pattern is being typed
vim.opt.incsearch = true

-- DIFFS {{{2
-- Open diff in vertical splits
vim.opt.diffopt:append("vertical")

-- FORMATTING {{{2
-- TODO: Add a check for par binary existing?
vim.opt.formatprg = "par -w79"

-- MODELINE {{{2
-- Vim checks first few lines for "modelines"(user specified `set` commands).
vim.opt.modeline = true

-- Number of lines to look for modeline in.
-- Default is 5 but that's more than I like.
vim.opt.modelines = 3

-- COMPLETION {{{2
-- COMMAND LINE COMPLETION {{{3
-- Character that trigger's completion according to `wildmode`.
-- vim.o.wildchar = '<Tab>' -- `<Tab>` is default.

-- Completion mode for the character specified with in 'wildchar'.
vim.opt.wildmode = {
  -- Also starts wildmenu if it's enabled.
  -- ""		    : Complete only first match.
  -- "longest"	: Complete till longest common string or next part.
  -- "list"		: When more than one match, list all matches.
  -- "lastused"	: When completing buffers with 1+ matches, sort by MRU.
  "full", -- Complete next full match using original string.
}

-- Perform things like menu completion with wildchar(often tab) etc.
-- Enhance command line completion
-- TODO:
--   Find more relatable key keymaps in this mode.  Read `help 'wildmenu'`
vim.opt.wildmenu = true

-- INSERT MODE COMPLETION {{{3
-- TODO: Consider `popup`
vim.opt.completeopt:append({
  "menu", --        show popup menu for completions
  "menuone", --     show even for only one available completion
  "preview", --     show extra meta info in preview window
  "noinsert", --    TODO: don't insert any text unless user selects one
})

-- Completion sources to scan, default: ".,w,b,u,t", read `:help 'complete'`
-- TODO: `i` is default in vim but not in nvim. Investigate reason?
vim.opt.complete:append({
  "i", -- scan current file and included files.
})

-- FOLDS {{{2
-- FOLD SPECIFICS {{{3
-- Disable Folds by deafult
vim.opt.foldenable = false

-- How to detect folds by default
vim.opt.foldmethod = "syntax"

-- Fold level at vim open,
--  0  All folds closed
--  1  Some folds closed
-- 99  No folds closed
vim.opt.foldlevelstart = 1

-- Commands(like movements) that open closed folds
vim.opt.foldopen = {
  "block", --     blockwise movements `(`, `{`, `[[`, `[{`, etc.
  "insert", --    insert mode commands
  "jump", --      far jumps like `G`, `gg` etc.
  "mark", --      jumping to marks etc. like `'m`, via `CTRL-O` etc.
  "percent", --   `%`
  "quickfix", --  `:cn`, `:crew`, `:make`, etc.
  "search", --    triggering search patterns
  "tag", --       tag jumps like `:ta`, `CTRL-T` etc.
  "undo", --      undo or redo
  "hor", --       horizontal movement like `l`,`w`, `fx` etc.
  -- `all` --     everything
}

-- CUSTOM FOLD TITLE {{{3
-- FIXME:
-- 1. Use lua
-- 2. Show depth level like the default fold text does.
-- vim.cmd([[
--     function! NeatFoldText()
--         let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
--         let lines_count = v:foldend - v:foldstart + 1
--         let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' '
--         let foldchar = matchstr(&fillchars, 'fold:\zs.')
--         let foldtextstart = strpart('' . line, 0, (winwidth(0)*2)/3)
--         let foldtextend = lines_count_text . repeat(' ', 8)
--         let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
--         return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
--     endfunction
--     set foldtext=NeatFoldText()
-- ]])

-- INDENTS {{{2
-- Use same indentation of current line when creating new line
vim.opt.autoindent = true

-- Use C's indenting rules
vim.opt.cindent = true

-- Insert blanks according to listed shiftwidth/tabstop/softtabstop
vim.opt.smarttab = true

-- Use appropriate number of spaces to insert a tab with autodindent on
vim.opt.expandtab = true

-- BACKUP {{{2
-- Make a backup before writing the file
vim.opt.backup = true

-- Make a backup and then overwrite orginal file
vim.opt.backupcopy = "yes"

-- Do not make backups for these file patterns
-- TODO: Use lua
-- vim.opt.backupskip=/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*
vim.cmd([[ set backupskip=/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/* ]])

-- Use this directory to store backups
-- NOTE: The `backupdir` will have to be created.
-- TODO: Use a nvim specific backup dir.
-- TODO: Use lua
vim.cmd([[ set backupdir=~/.vim/backup ]])

-- List of directory names to create the swp files in
-- TODO: Use lua
vim.cmd([[ set directory=/tmp/ ]])

-- WILDIGNORE {{{2
-- File patterns to ignore.  Used throughout in situations like expansions,
-- completions, 3rd party plugins like NERDTree, CtrlP etc.
-- READ `:help 'wildignore'`

-- TODO: Update this list
vim.opt.wildignore:append({
  -- Usual culprits
  "*.o",
  "*.obj",
  "*.exe",
  "*.so",
  "*.dll",
  "*.lock",
  ".DS_Store",
  -- Git
  ".git",
  ".git/*",
  -- CSS Preprocessors
  ".sass-cache",
  "*.class",
  "*.scssc",
  "*.cssc",
  -- Elixir/Mix.Phoenix etc.
  "*/_build/*",
  "*/cover/*",
  "*/deps/*",
  "*/.fetch/*",
  "erl_crash.dump",
  "mix.lock",
  "*.ez",
  "*.beam",
  "*/config/*.secret.exs",
  ".elixir_ls/*",
  -- Python
  "*.pyc",
  ".ropeproject",
  "__pycache__",
  "*.egg-info",
  -- Haskell
  ".stack-work",
  ".stackwork/*",
  -- TODO: JS/Node
  -- TODO: Rust
  -- TODO: Go
  -- TODO: Elm
  -- TODO: etc.
})

-- UI {{{2
-- TITLE {{{3
-- Set terminal window title to value of `titlestring`
vim.opt.title = true
-- Window title to use after vim is exiting but unable to restore the replaced
-- previous title
vim.opt.titleold = "Terminal"

-- String to use to set terminal window title
-- TODO: Convert to lua.
-- WARN: Do not use special characters, it's risky.
-- NOTE: Fields used are from `statusline`.
vim.cmd([[
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
]])

-- MISC UI {{{3
-- Enable TUI gui colors
vim.opt.termguicolors = true
-- Always display a status line, even with only 1 window
vim.opt.laststatus = 2

-- Auto-wrap text at this width. (Long lines are broken at whitespace)
vim.opt.textwidth = 78

-- Show partial command in the last line at the bottom
vim.opt.showcmd = true

-- Allow cursor to go to invalid places only in visually selected blocks
vim.opt.virtualedit = "block"

-- Always report when any lines are changed (`0`)
vim.opt.report = 0

-- Do not shift cursor back to line beginning while scrolling
vim.opt.startofline = false

-- Display line numbers
vim.opt.number = true

-- Display line number and cursor position
vim.opt.ruler = true

-- Hide mouse pointer while typing
vim.opt.mousehide = true

-- Use a dark background for dark colorschemes
vim.opt.background = "dark"

-- Command line height(1 is default)
vim.opt.cmdheight = 2

-- Redraw screen while executing macros, registers, untyped commands etc.
vim.opt.lazyredraw = false

-- When cursor is on bracket, briefly jump to coupled bracket
vim.opt.showmatch = true

-- Spend this much time switching the cursor to the coupled bracket
vim.opt.matchtime = 5

-- Don't show visual bell (enabled when audio bell is turned off)
vim.opt.visualbell = false

-- Set vertical window sepertor to pipelike symbol │ with no vertical gaps
vim.opt.fillchars:append({ vert = [[│]] })

-- Stop all error bellsof
vim.opt.belloff = "all"

-- Show error messages and throw exceptions that are otherwise omitted
-- NOTE: DISABLED
-- DEFAULT: ""
-- vim.opt.debug = "msg,throw"

-- For performance, only do syntax highlight upto these columns
vim.opt.synmaxcol = 2048

-- Highlight the screen line and column of cursor
vim.opt.cursorline = false
vim.opt.cursorcolumn = false

-- Position newly split windows to below
vim.opt.splitbelow = true

-- Position newly split windows to right
vim.opt.splitright = true

-- Show ellipsis on a soft break
vim.opt.showbreak = [[…]]

-- Jump to the last known valid cursor position {{{2
local jump_to_last_known_cursor_position_augroup =
  vim.api.nvim_create_augroup(
    "jump_to_last_known_cursor_position",
    { clear = true }
  )

-- On opening file, jump to last known cursor position from last opened
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
  desc = "Jump to last known cursor position",
  group = jump_to_last_known_cursor_position_augroup,
  pattern = { "*" },
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local line_count = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= line_count then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- WHITESPACE {{{3
-- TODO: `listchars'` to show fancy tabs?

-- Keep cursor these many lines above bottom of screen
vim.opt.scrolloff = 1

-- This option changes how text is displayed.
-- It doesn't change the text in the buffer, see 'textwidth' for that.
-- TODO: Shirten description.
vim.opt.wrap = false

-- Number of spaces `<Tab>` i the file counts for.
vim.opt.tabstop = 4

-- Number of spaces `<Tab>` counts for while editing.
-- Example: Inserting `<Tab>` or using `<BS>`
vim.opt.softtabstop = 4

-- Number of spaces to use for each step of (auto)indent.
-- (When zero the 'ts' value will be used.)
vim.opt.shiftwidth = 4

-- Round indent to multiples of 'shiftwidth'
vim.opt.shiftround = true

-- Make backspace behave more like the popular usage
-- `2`: `indent,eol,start` (default)
vim.opt.backspace = { "indent", "eol", "start" }

-- FILE SPECIFIC WHITESPACES {{{4
-- NOTE:
--   `softtabstop` set to 0 disables it.
--   `shiftwidth` set to 0 makes it use `tabstop` value.
local whitespace_preferences_group =
  vim.api.nvim_create_augroup("whitespace_preferences", { clear = true })
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = whitespace_preferences_group,
  pattern = { "make" },
  command = [[ setlocal tabstop=4 softtabstop=0 shiftwidth=0 noexpandtab ]],
})
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = whitespace_preferences_group,
  pattern = { "yaml" },
  command = [[ setlocal tabstop=2 softtabstop=2 shiftwidth=0 expandtab ]],
})
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = whitespace_preferences_group,
  pattern = { "html", "css", "javascript", "haskell" },
  command = [[ setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab ]],
})

-- MISC PREFERENCES {{{2

-- Turn on syntax highlighting
-- NOTE:
--  `syntax enable`  Will turn on syntax highlighting.
--  `syntax on`      Will turn on syntax highlighting like `syntax enable` but
--      allow vim to overrule syntax color settings with default highlights.
vim.cmd([[ syntax enable ]])
-- vim.cmd([[ syntax on ]]) -- DISABLED

-- Unsaved bufers are allowed to move to the background
vim.opt.hidden = true

-- Don't print mode changes upon entering a new mode e.g. --INSERT--
vim.opt.showmode = false

-- Sync loaded file to changes on disk
vim.opt.autoread = true

-- Enable mouse support in all modes (`a`).
vim.opt.mouse = "a"

-- Limit command line history to 500 items
vim.opt.history = 500

-- Seek confirmation before destructive operations
-- e.g. quitting unsaved buffers.
vim.opt.confirm = true

-- Milliseconds to wait for next key to complete current key sequence
vim.opt.timeoutlen = 350

-- Characters to treat as keywords
vim.opt.iskeyword:append({ "_", "$", "@", "%", "#", "-" })

-- Print-friendly configuration
-- FIXME: Try to use tables for this; failed using variations of this so far:
--   `vim.opt.printoptions = { header = 0, duplex = 'long', paper = 'A4' }`
vim.o.printoptions = "header:0,duplex:long,paper:A4"

-- Toggle paste mode
-- NOTE: nvim 0.9 deprecated `paste`/`pastetoggle` as bracketed paste mode is
-- the default.
-- vim.opt.pastetoggle = '<F12>' -- TODO: Find a better key than `F12`

-- Provide auto-formatting support
-- `n`: Numbered lists, official example:
--      1. the first item
--         wraps.
--      2. the second item
vim.opt.formatoptions:append({ n = true })

-- LANGUAGE-SPECIFIC GENERIC PREFERENCES {{{1
-- FILETYPE {{{2
-- Enable filetype detection
vim.cmd([[ filetype on ]])
-- Activate builtin filetypes' plugins
vim.cmd([[ filetype plugin on ]])
-- Activate builtin and computed indentations
vim.cmd([[ filetype indent on ]])

-- SKELETONS {{{2
local skeleton_files_augroup =
  vim.api.nvim_create_augroup("skeleton_files_augroup", { clear = true })

-- Initialise new files with corresponding skeleton templates
-- TODO: Use nvim specific skeleton files storage location
-- FIXME: Unlike in vim, errors if filetype doesn't have a skeleton. Use a
--        separate function to not panic when a skeleton is not present.
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = skeleton_files_augroup,
  pattern = { "html" },
  command = [[ 0r ~/.vim/skeletons/skeleton.%:e ]],
  desc = "Initialise new files with corresponding skeleton templates",
})

-- QUICKFIX {{{2
local quickfix_augroup =
  vim.api.nvim_create_augroup("quickfix_augroup", { clear = true })

-- Close quickfix if it is the last window left in tab
-- SEE: https://vim.fandom.com/wiki/Automatically_quit_Vim_if_quickfix_window_is_the_last
vim.cmd([[
    function! CloseQuickfixIfItIsLastOpenWinLeftInTab()
        if (&buftype=="quickfix" && winnr('$') < 2)
            quit
        endif
    endfunction
]])
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  group = quickfix_augroup,
  pattern = { "*" },
  callback = "g:CloseQuickfixIfItIsLastOpenWinLeftInTab",
  desc = "Close quickfix if it is the last window left in tab",
})

-- HELP {{{2
local help_augroup =
  vim.api.nvim_create_augroup("help_augroup", { clear = true })

-- Limit help pages text width
-- TODO: Check if I meant this for 3rd part help pages, because internal help
--       is generally < 80, no
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = help_augroup,
  pattern = { "help" },
  command = "setlocal textwidth=78",
  desc = "Limit help pages text width",
})

-- Move help to a new tab
-- NOTE: `BufWinEnter` uses `*.txt` patterns and we detect if `help` later.
vim.cmd([[
    function! MoveHelpToNewTab ()
        if &buftype ==# 'help' | wincmd T | endif
    endfunction
]])
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  group = help_augroup,
  pattern = { "*.txt" },
  callback = "g:MoveHelpToNewTab",
  desc = "Move help to a new tab",
})

-- VIMSCRIPT {{{2
local vimscript_augroup =
  vim.api.nvim_create_augroup("vimscript_augroup", { clear = true })

-- Set foldmethod as marker in vimscript
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = vimscript_augroup,
  pattern = { "vim" },
  command = [[ setlocal foldmethod=marker ]],
  desc = "Set foldmethod as marker in vimscript",
})

-- ELM {{{2
local elm_augroup =
  vim.api.nvim_create_augroup("elm_augroup", { clear = true })

-- Abbreviates `::` into `:` as it is a common typo in elm.
-- TODO: Replace `<buffer>` with lua equivalent`
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = elm_augroup,
  pattern = { "elm" },
  command = [[ abbreviate <buffer> :: : ]],
  desc = "Abbreviates `::` into `:` as it is a common typo in elm.",
})

-- Insert module header when creating new elm file
vim.cmd([[
    function! InsertElmModuleHeader()
        execute "normal! Imodule " . expand("%:t:r") . " exposing (..)\<cr>\<cr>\<esc>"
    endfunction
]])
vim.api.nvim_create_autocmd({ "BufNewFile" }, {
  group = elm_augroup,
  pattern = { "*.elm" },
  callback = "g:InsertElmModuleHeader",
  desc = "Insert module header when creating new elm file",
})

-- HASKELL {{{2
-- COMMON HASKELL {{{3
local haskell_augroup =
  vim.api.nvim_create_augroup("haskell_augroup", { clear = true })

-- Set `hindent` as `formatprg`
-- NOTE: Requires `hindent` in `$PATH`
-- TODO: Check if `hindent` in `$PATH`
-- TODO: Call via `stack` (like `ALE` does for `hlint`)
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = haskell_augroup,
  pattern = { "haskell" },
  command = [[ setlocal formatprg=hindent ]],
  desc = "Set `hindent` as `formatprg`",
})

-- Insert module header when creating new haskell file
vim.cmd([[
    function! InsertHaskellModuleHeader()
        execute "normal! Imodule " . expand("%:t:r") . " where\<cr>\<cr>\<esc>"
    endfunction
]])
vim.api.nvim_create_autocmd({ "BufNewFile" }, {
  group = haskell_augroup,
  pattern = { "*.hs" },
  callback = "g:InsertHaskellModuleHeader",
  desc = "Insert module header when creating new haskell file",
})

-- Append prime character to curent word
-- TODO: Use a function to allow adding and removing trailing `'`
-- TODO: Make this a toggle to remove the prime character if present already.
-- TODO: Achieve this without polluting registers (here `z`)
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = haskell_augroup,
  pattern = { "haskell" },
  command = [[ nnoremap <silent> <localleader>'  mzea'<esc>`zh ]],
  desc = "Append prime character to curent word",
})

-- TODO: Fill in `undefined` as implementation for function whose type
-- signature is on current line
vim.cmd([[
    function HaskellAddUndefinedImplForFuntionTypeSignOnCurrentLine()
        " TODO:
        " 1. Match indentation.
        " 2. Do not use up registers being used here to
        "       record position and function name.
        execute "normal! mn^yiwo\<esc>pA = undefined\<esc>`n"
    endfunction
]])
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = haskell_augroup,
  pattern = { "haskell" },
  command = [[ nnoremap <silent> <localleader>u <cmd>call HaskellAddUndefinedImplForFuntionTypeSignOnCurrentLine()<cr> ]],
  desc = "Fill in `undefined` as implementation for function"
    .. " whose type signature is on current line",
})

-- HASKELL STACK {{{3
-- TODO
vim.cmd([[
]])

-- HASKELL HELPERS {{{3

-- RUST {{{2
-- TODO:
local rust_augroup =
  vim.api.nvim_create_augroup("rust_augroup", { clear = true })

-- Set `formatprg` to `rustfmt`
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = rust_augroup,
  pattern = { "rust" },
  command = [[ setlocal formatprg=rustfmt ]],
  desc = "Set `formatprg` to `rustfmt`",
})

-- ELIXIR/PHOENIX {{{2
local elixir_augroup =
  vim.api.nvim_create_augroup("elixir_augroup", { clear = true })

-- Set syntax and filetype for heex and eex filetypes
-- TODO: Is it really `eelixir` with 2 ees?
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  group = elixir_augroup,
  pattern = { "*.html.heex" },
  command = "set filetype=heex",
  desc = "",
})
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  group = elixir_augroup,
  pattern = { "*.html.eex" },
  command = "set filetype=eex",
  desc = "",
})
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  group = elixir_augroup,
  pattern = { "*.html.heex" },
  command = "set syntax=eelixir",
  desc = "",
})
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  group = elixir_augroup,
  pattern = { "*.html.eex" },
  command = "set syntax=eelixir",
  desc = "",
})

-- TOGGLES {{{1
-- Toggle small features.
-- NOTE:
--  Preferably use unimpaired style, i.e.
--  - `yox` to toggle `x`
--  - `]ox` to enable `x`
--  - `[ox` to disalbe `x`

-- ELIXIR TOGGLES {{{2
local elixir_toggles_augroup =
  vim.api.nvim_create_augroup("elixir_toggles_augroup", { clear = true })

-- Toggle trailing comma on current line
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = elixir_toggles_augroup,
  pattern = { "elixir" },
  command = [[ nnoremap <buffer><silent> <localleader>, <cmd>call ToggleTrailingStringOnLine(",", line("."))<cr> ]],
  desc = "Toggle trailing colon on current line",
})

-- Toggle leading `_` on current word
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = elixir_toggles_augroup,
  pattern = { "elixir" },
  command = [[ nnoremap <buffer><silent> <localleader>_ <cmd>call ToggleLeadingUnderscoreOnWordUnderCursor()<cr> ]],
  desc = "Toggle leading `_` on current word",
})

-- PYTHON TOGGLES {{{2
local python_toggles_augroup =
  vim.api.nvim_create_augroup("python_toggles_augroup", { clear = true })

-- Toggle trailing colon on current line
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = python_toggles_augroup,
  pattern = { "python" },
  command = [[ nnoremap <buffer><silent> <localleader>: <cmd>call ToggleTrailingStringOnLine(":", line("."))<cr> ]],
  desc = "Toggle trailing colon on current line",
})

-- Toggle trailing comma on current line
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = python_toggles_augroup,
  pattern = { "python" },
  command = [[ nnoremap <buffer><silent> <localleader>, <cmd>call ToggleTrailingStringOnLine(",", line("."))<cr> ]],
  desc = "Toggle trailing comma on current line",
})

-- Toggle leading `async`/`await` keywords on current line
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = python_toggles_augroup,
  pattern = { "python" },
  command = [[ nnoremap <buffer><silent> <localleader>a <cmd>call ToggleAsyncOrAwaitKeywordPython(".")<cr>]],
  desc = "Toggle leading `async`/`await` keywords on current line",
})

-- Toggle `pass` keyword on current line
-- nnoremap <silent> <localleader>p  <cmd>call TogglePassKeywordPython(".")<cr>
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = python_toggles_augroup,
  pattern = { "python" },
  command = [[ nnoremap <buffer><silent> <localleader>p <cmd>call TogglePassKeywordPython(".")<cr> ]],
  desc = "Toggle `pass` keyword on current line",
})

-- Toggle `pass` keyword on current line, replacing any existing content
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = python_toggles_augroup,
  pattern = { "python" },
  command = [[ nnoremap <silent> <localleader>P <cmd>call TogglePassKeywordReplacingContentPython(".")<cr> ]],
  desc = "Toggle `pass` keyword on current line, replacing any existing content",
})

-- Toggle trailing pyright ignore label ` # type: ignore` on current line
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = python_toggles_augroup,
  pattern = { "python" },
  command = [[ nnoremap <silent> <localleader>i <cmd>call ToggleTrailingStringOnLine(" # type: ignore", line("."))<cr> ]],
  desc = "Toggle trailing pyright ignore label ` # type: ignore` on current line",
})

-- RUST TOGGLES {{{2
local rust_toggles_augroup =
  vim.api.nvim_create_augroup("rust_toggles_augroup", { clear = true })

-- Toggle trailing semicolon on current line
vim.api.nvim_create_autocmd({ "FileType" }, {
  desc = "Toggle trailing semicolon on current line",
  group = rust_toggles_augroup,
  pattern = { "rust" },
  command = [[ nnoremap <buffer><silent> <localleader>; <cmd>call ToggleTrailingStringOnLine(";", line("."))<cr> ]],
})

-- Toggle trailing comma on current line
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = rust_toggles_augroup,
  pattern = { "rust" },
  command = [[ nnoremap <buffer><silent> <localleader>, <cmd>call ToggleTrailingStringOnLine(",", line("."))<cr> ]],
  desc = "Toggle trailing comma on current line",
})

-- Toggle leading `let` keyword on current line
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = rust_toggles_augroup,
  pattern = { "rust" },
  command = [[ nnoremap <buffer><silent> <localleader>l  <cmd>call ToggleLetKeyword(".", 0, 1)<cr> ]],
  desc = "Toggle leading `let` keyword on current line",
})

-- Toggle leading `let mut` keyword(s) on current line
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = rust_toggles_augroup,
  pattern = { "rust" },
  command = [[ nnoremap <buffer><silent> <localleader>lm <cmd>call ToggleLetKeyword(".", 1, 0)<cr> ]],
  desc = "Toggle leading `let mut` keyword(s) on current line",
})

-- Toggle leading `pub` keyword on current line
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = rust_toggles_augroup,
  pattern = { "rust" },
  command = [[ nnoremap <buffer><silent> <localleader>p  <cmd>call TogglePubKeyword(".")<cr> ]],
  desc = "Toggle leading `pub` keyword on current line",
})

-- Toggle trailing `into()` on content of current line
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = rust_toggles_augroup,
  pattern = { "rust" },
  command = [[ nnoremap <buffer><silent> <localleader>i  <cmd>call ToggleTrailingInto(".")<cr> ]],
  desc = "Toggle trailing `into()` on content of current line",
})

-- Toggle leading `async` keyword on current line
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = rust_toggles_augroup,
  pattern = { "rust" },
  command = [[ nnoremap <buffer><silent> <localleader>a  <cmd>call ToggleAsyncKeywordRust(".")<cr> ]],
  desc = "Toggle leading `async` keyword on current line",
})

-- Toggle trailing `await` on content of current line
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = rust_toggles_augroup,
  pattern = { "rust" },
  command = [[ nnoremap <buffer><silent> <localleader>A  <cmd>call ToggleTrailingAwaitKeyword(".")<cr> ]],
  desc = "Toggle trailing `await` on content of current line",
})

-- Toggle trailing question mark on current line
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = rust_toggles_augroup,
  pattern = { "rust" },
  command = [[ nnoremap <buffer><silent> <localleader>? <cmd>call ToggleTrailingQuestionMark(".")<cr> ]],
  desc = "Toggle trailing question mark on current line",
})

-- Toggle wrapping `Ok()` on current line
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = rust_toggles_augroup,
  pattern = { "rust" },
  command = [[ nnoremap <buffer><silent> <localleader>o  <cmd>call ToggleWrappingTagOnCurrentLine("Ok")<cr> ]],
  desc = "Toggle wrapping `Ok()` on current line",
})

-- Toggle wrapping `Err()` on current line
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = rust_toggles_augroup,
  pattern = { "rust" },
  command = [[ nnoremap <buffer><silent> <localleader>e <cmd>call ToggleWrappingTagOnCurrentLine("Err")<cr> ]],
  desc = "Toggle wrapping `Err()` on current line",
})

-- Toggle leading `_` on current word
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = rust_toggles_augroup,
  pattern = { "rust" },
  command = [[ nnoremap <buffer><silent> <localleader>_ <cmd>call ToggleLeadingUnderscoreOnWordUnderCursor()<cr> ]],
  desc = "Toggle leading `_` on current word",
})

-- TODO: Toggle attribute `[allow(dead_code)]` on current line
-- vim.api.nvim_create_autocmd(
--     {'FileType'},
--     { group = rust_toggles_augroup,
--     pattern = { "rust" },
--     command = [[ nnoremap <buffer><silent> <localleader>d  <cmd>call ToggleAttributeOnLine("[allow(dead_code)]" , ".")<cr> ]],
--     desc = "Toggle attribute `[allow(dead_code)]` on current line"
--     })

-- COMMON TOGGLES {{{2
-- TODO: Get common toggles and put them here

-- TOGGLES HELPERS {{{2
-- NOTE: Do not edit these helper functions here, but in vimrc; at least until
--          they're all reqritten properly here in lua.
-- TODO: Use lua
-- TODO: Separate into sections
-- TODO: Extract common functions
vim.cmd([[
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
function! ToggleAttributeOnLine(string, line_number)
    " TODO:
    "   - Multiple attributes?
    "   - Preserve indentation
    "   - Attributes acting on a statement can be stacked on multiple lines,
    "   so check for that.
    "   - Sometimes one of the stacked attributes can span multiple lines with
    "   a comma in between and so the check for multiple attributes would have
    "   to take that into account.
    "
    " GIVEN ATTRIBUTE ON ABOVE LINE? YES
    "   REMOVE GIVEN ATTRIBUTE LINE ABOVE CURRENT LINE
    " GIVEN ATTRIBUTE ON ABOVE LINE? NO
    "   DIFFERENT ATTRIBUTE ON ABOVE LINE? YES
    "       GIVEN ATTRIBUTE ON ANY STACKED ATTRIBUTES ABOVE LINE? YES
    "           REMOVE THE GIVEN ATTRIBUTE LINE
    "       GIVEN ATTRIBUTE ON ANY STACKED ATTRIBUTES ABOVE LINE? NO
    "           ADD GIVEN ATTRIBUTE IN LINE ABOVE CURRENT LINE
    "   DIFFERENT ATTRIBUTE ON ABOVE LINE? NO
    "       ADD GIVEN ATTRIBUTE IN LINE ABOVE CURRENT LINE
endfunction
function! ToggleTrailingAwaitKeyword(line_number)
    " Toggles trailing `await` keyword on line of provided line number
    "
    let trimmed_line_content = getline(a:line_number)->trim()
    "
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
    "
    " Get current word
    let word_under_cursor = expand("<cword>")
    "
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
    "
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
    " TODO: Adapt to use `ToggleTrailingStringOnLine`
    " LOGIC:
    "   1. Ensure non-empty trimmed line
    "   2. Check if there is a trailing `?`
    "       YES: Remove trailing `?`
    "       NO:  Check if there is a trailing `;`
    "               NO:  Add trailing `?`
    "               YES: Check if there is `?` behind trailing `;`
    "                       YES: Remove that `?` before trailing `;`
    "                       NO:  Add `?` before trailing `;`
    "
    let line_content = getline(a:line_number)
    let trimmed_line_content = trim(line_content)
    "
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
    "
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
function! ToggleTrailingStringOnLine(string, line_number)
    " Toggles trailing given string on line at given line number
    "
    " TODO: Check which builtin string length function to use from:
    "       len/strlen/strdisplaywidth/strwidth erc.
    "
    let line_content = getline(a:line_number)
    let string_length= strwidth(a:string)
    "
    " TODO: Also check if line length is > than given string_length?
    " Ensure line is not empty
    if strwidth(line_content) > 0
        if (line_content[-(string_length):] == a:string)
            " Append given string if not present at end of line
            call setline(a:line_number, line_content[:-(string_length+1)])
        else
            " Remove trailing given string if present at end of line
            call setline(a:line_number, line_content . a:string)
        endif
    endif
endfunction
function! ToggleLetKeyword (line_number, toggle_let_mut, toggle_let)
    "TODO: While this function accepts a line_number, the helpe fucntions within
    " only act upon the current line to accomodate the current way of restoring
    " the cursor position. Rewrite them to accept an arbitrary line number.
    "
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
        "
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
        "
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
        "
        " Run logic
        if a:toggle_let_mut && has_let_mut
            call RemoveLetMut()
        elseif a:toggle_let_mut && has_let
            call RemoveLet()
            call PrependLetMut()
        elseif a:toggle_let_mut && (!has_let_mut && !has_let)
            call PrependLetMut()
        "
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
]])

-- TERMINAL {{{1
-- TODO:
-- 1. Consider setting shell to `fish` or let it remain default `bash`
-- 2. After terminal  window is done, it is deleted with any key in it,
--    consider changing that to closing done_terminal_window with regular
--    window closing commands only like `zz`?
--
local terminal_augroup =
  vim.api.nvim_create_augroup("terminal_augroup", { clear = true })

-- Open `fish` terminal in a window within current tab
vim.keymap.set(
  "n",
  "<m-t>",
  "<cmd>split term://fish<cr>",
  { silent = true }
)

-- Open `fish` terminal in a new tab
-- TODO: Remove hard coded `fish` shell reference
vim.keymap.set(
  "n",
  "<m-T>",
  "<cmd>tabnew term://fish<cr>",
  { silent = true }
)

-- Keep the terminal UI basic
vim.api.nvim_create_autocmd({ "TermOpen" }, {
  group = terminal_augroup,
  command = [[ setlocal listchars= nonumber norelativenumber ]],
  desc = "Keep the terminal UI basic",
})

-- Show cursorline in terminal insert mode
vim.api.nvim_create_autocmd({ "TermOpen" }, {
  group = terminal_augroup,
  command = [[ setlocal cursorline ]],
  desc = "Keep the terminal UI basic",
})

-- Start terminal in insert mode
vim.api.nvim_create_autocmd({ "TermOpen" }, {
  group = terminal_augroup,
  command = [[ startinsert ]],
  desc = "Start terminal in insert mode",
})

-- WINDOWS AND TABS {{{1
-- NOTES: When possible, Window keymaps use lower case and tabs use upper case.

-- CREATING/DUPLICATING {{{2
-- Opening new tab pages
-- Using `<c-w>N` as it matches with vim's `<c-w>n` (new window)
vim.keymap.set("n", "<c-w>N", "<cmd>tabnew<cr>", { silent = true })

-- Duplicate current buffer in new window
vim.keymap.set("n", "<c-w>d", "<cmd>vsplit<cr>", { silent = true })

-- Duplicate current buffer in new tab
vim.keymap.set("n", "<c-w>D", "<cmd>tab split<cr>", { silent = true })

-- OPEN ALL BUFFERS IN TABS {{{2
-- TODO: Open all buffers in windows
-- Open all buffers in tabs
vim.keymap.set("n", "<c-w>B", "<cmd>tab sball<cr>", { silent = true })

-- MOVING {{{2
-- Jump to last accessed tab page
vim.keymap.set("n", "<c-w><c-w>", "<cmd>tabnext #<cr>", { silent = true })

-- Jump to first tab using `1` ala my xmonad configuration
vim.keymap.set("n", "<c-w>`", "<cmd>tabfirst<cr>", { silent = true })

-- Jump to last tab using `0` ala my xmonad configuration
vim.keymap.set("n", "<c-w>0", "<cmd>tablast<cr>", { silent = true })

-- Jump to next tab
vim.keymap.set("n", "<tab>", "<cmd>tabnext<cr>", { silent = true })

-- Jump to previous tab
vim.keymap.set("n", "<s-tab>", "<cmd>tabprevious<cr>", { silent = true })

-- Jump to tabs at positions `1-9`
-- TODO: Make it so when a position isn't present, jump to largest tab position
--          i.e. if only `1-4` positions are present, on say `7` go to `4`
vim.keymap.set("n", "<c-w>1", "<cmd>tabfirst<cr>", { silent = true })
vim.keymap.set(
  "n",
  "<c-w>2",
  '<cmd>execute "normal! 2gt"<cr>',
  { silent = true }
)
vim.keymap.set(
  "n",
  "<c-w>3",
  '<cmd>execute "normal! 3gt"<cr>',
  { silent = true }
)
vim.keymap.set(
  "n",
  "<c-w>4",
  '<cmd>execute "normal! 4gt"<cr>',
  { silent = true }
)
vim.keymap.set(
  "n",
  "<c-w>5",
  '<cmd>execute "normal! 5gt"<cr>',
  { silent = true }
)
vim.keymap.set(
  "n",
  "<c-w>6",
  '<cmd>execute "normal! 6gt"<cr>',
  { silent = true }
)
vim.keymap.set(
  "n",
  "<c-w>7",
  '<cmd>execute "normal! 7gt"<cr>',
  { silent = true }
)
vim.keymap.set(
  "n",
  "<c-w>8",
  '<cmd>execute "normal! 8gt"<cr>',
  { silent = true }
)
vim.keymap.set(
  "n",
  "<c-w>9",
  '<cmd>execute "normal! 9gt"<cr>',
  { silent = true }
)

-- RENAMING {{{2
-- Rename current tab
-- TODO: Use lua
-- NOTE: Requires the `gcmt/taboo.vim` plugin.
-- TODO: Refactor to remove `gcmt/taboo.vim` plugin
vim.cmd([[
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
]])
vim.keymap.set(
  "n",
  "<c-w>,",
  "<cmd>call RenameTabpageWithTaboo(0)<cr>",
  { silent = true }
)

-- SPLITTING {{{2
--  TODO: Find better split keymaps
--  NOTE: These are deliberately identical to my tmux pane keymaps
--  NOTE: Regretfully `<c-w>-` just doesn't fit into my vim mapping system..
--        So temporarily relying on good ol' `<c-w>v` and `<c-w>s` for the splits.
--        and freeing up `<c-w>-`. `vim-vinegar` can use it in the meantime.
--  HORIZONTAL SPLIT
--  nnoremap <silent> <c-w>-        :split<CR>
--  VERTICAL SPLIT
--  nnoremap <silent> <c-w>\|       :vsplit<CR>

-- SIZING {{{2
-- Equal size windows
vim.keymap.set("n", "<c-w>=", "<cmd>wincmd =<cr>", { silent = true })

-- MOVING {{{2
-- Move focus to window to the left
vim.keymap.set("n", "<c-h>", "<cmd>wincmd h<cr>", { silent = true })

-- Move focus to window to the bottom
vim.keymap.set("n", "<c-j>", "<cmd>wincmd j<cr>", { silent = true })

-- Move focus to window to the top
vim.keymap.set("n", "<c-k>", "<cmd>wincmd k<cr>", { silent = true })

-- Move focus to window to the right
vim.keymap.set("n", "<c-l>", "<cmd>wincmd l<cr>", { silent = true })

-- Move focus to previously focussed window
-- NOTE: Disabled because I don't tend to use this AND don't particularly feel
-- like this shortcut `<c-w>p` fits in with the rest
-- vim.keymap.set("n", "<c-w>p", "<cmd>wincmd p<cr>", { silent = true })

-- Move tab forwards/backwards (with wrapping)
-- NOTE:
--  - Wrapping is when the tab is at the end, continue moving to the other end in a loop.
--  - Currently disabling wrapping.
--  - To use wrapping, while calling `TabMoveBy1`, use `1` to enable, `0` to disable.
vim.keymap.set(
  "n",
  "<c-w><s-right>",
  '<cmd>call TabMoveBy1("right", 0)<cr>',
  { silent = true }
)
vim.keymap.set(
  "n",
  "<c-w><s-left>",
  '<cmd>call TabMoveBy1("left", 0)<cr>',
  { silent = true }
)
-- Move tab forwards/backwards, with no concept of wrapping or error reporting
-- vim.keymap.set('n' , '<c-w><s-right>', '<cmd>tabmove +1<cr>', {silent = true})
-- vim.keymap.set('n' , '<c-w><s-left>', '<cmd>tabmove -1<cr>', {silent = true})

-- Move tab to the first/last position
-- NOTE: `:tabmove 0` moves to the first position and `:tabmove` to the last
-- NOTE: Doing both gx and xg variations, because I forget otherwise.
vim.keymap.set(
  "n",
  "<c-w>g<s-right>",
  "<cmd>tabmove<cr>",
  { silent = true }
)
vim.keymap.set(
  "n",
  "g<c-w><s-right>",
  "<cmd>tabmove<cr>",
  { silent = true }
)
vim.keymap.set(
  "n",
  "<c-w>g<s-left>",
  "<cmd>tabmove 0<cr>",
  { silent = true }
)
vim.keymap.set(
  "n",
  "g<c-w><s-left>",
  "<cmd>tabmove 0<cr>",
  { silent = true }
)

-- MOVING HELPERS {{{3
-- TODO: Use lua
vim.cmd([[
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
]])

-- CLOSING {{{2
-- Close all other windows in current tab
vim.keymap.set("n", "<c-w>o", "<cmd>only<cr>", { silent = true })

-- Close all other tabs
vim.keymap.set("n", "<c-w>O", "<cmd>tabonly<cr>", { silent = true })

-- Closing current tab
-- TODO: (Summer 2023) I don't use this a lot, so keep it around a bit to
-- consider removing it entirely.
vim.keymap.set("n", "<c-w>X", "<cmd>tabclose<cr>", { silent = true })

-- VIEWS AND SESSIONS {{{1
-- NOTE:
--  1. I want to use `<c-w>` as prefix key to gel with the rest of my window/tab
--     page keymaps and since views act on windows and sessions can be
--     considered to include tabpages.
--  2. The perfect mapping set for views/sessions would have been `<c-w>s/S` for
--     saving and `<c-w>l/L` for loading view/sessions. However `<c-w>l` is used
--     to navigate split views and is too important to sacrifice, hence the
--     current keymaps.

-- VIEWS {{{2
--  +-----------+---------------+-------------------------------------------------+
--  | `<c-w>m`  | `:mkview`     | Save view                                       |
--  | `<c-w>v`  | `:loadview`   | Load view saved with `mkview`                   |
--  +-----------+---------------+-------------------------------------------------+
--  | `<c-w>m1` | `:mkview 1`   | Save *view no. 1*                               |
--  | `<c-w>v1` | `:loadview 1` | Load view saved with `mkview 1` i.e *view no.1* |
--  |                                                                             |
--  | ... applies for view numbers 1..9                                           |
--  +-----------+---------------+-------------------------------------------------+
--  NOTE:
--  1. Using the overwriting variant `mkview!` isn't necssary because AFAICT
--     it only applies to manually named view files.
--  2. Unlike sessions, views created via `:mkview` (with no filename as
--     argument) aren't saved in the local direcinry but in vim's `viewdir`.
--  TODO:
--  2. Use a function here that can report save/overwrite information like their
--     session counterparts do.
-- Make and load views:
vim.keymap.set("n", "<c-w>m", "<cmd>mkview<cr>", { silent = true })
vim.keymap.set("n", "<c-w>v", "<cmd>loadview<cr>", { silent = true })

-- Make views:
vim.keymap.set("n", "<c-w>m1", "<cmd>mkview 1<cr>", { silent = true })
vim.keymap.set("n", "<c-w>m2", "<cmd>mkview 2<cr>", { silent = true })
vim.keymap.set("n", "<c-w>m3", "<cmd>mkview 3<cr>", { silent = true })
vim.keymap.set("n", "<c-w>m4", "<cmd>mkview 4<cr>", { silent = true })
vim.keymap.set("n", "<c-w>m5", "<cmd>mkview 5<cr>", { silent = true })
vim.keymap.set("n", "<c-w>m6", "<cmd>mkview 6<cr>", { silent = true })
vim.keymap.set("n", "<c-w>m7", "<cmd>mkview 7<cr>", { silent = true })
vim.keymap.set("n", "<c-w>m8", "<cmd>mkview 8<cr>", { silent = true })
vim.keymap.set("n", "<c-w>m9", "<cmd>mkview 9<cr>", { silent = true })

-- Load views:
vim.keymap.set("n", "<c-w>v1", "<cmd>loadview 1<cr>", { silent = true })
vim.keymap.set("n", "<c-w>v2", "<cmd>loadview 2<cr>", { silent = true })
vim.keymap.set("n", "<c-w>v3", "<cmd>loadview 3<cr>", { silent = true })
vim.keymap.set("n", "<c-w>v4", "<cmd>loadview 4<cr>", { silent = true })
vim.keymap.set("n", "<c-w>v5", "<cmd>loadview 5<cr>", { silent = true })
vim.keymap.set("n", "<c-w>v6", "<cmd>loadview 6<cr>", { silent = true })
vim.keymap.set("n", "<c-w>v7", "<cmd>loadview 7<cr>", { silent = true })
vim.keymap.set("n", "<c-w>v8", "<cmd>loadview 8<cr>", { silent = true })
vim.keymap.set("n", "<c-w>v9", "<cmd>loadview 9<cr>", { silent = true })

-- SESSIONS {{{2
-- +---------+----------------------------------------------------+
-- |`g<c-w>M` | Save/overwrite `Session.vim` to current directory |
-- |`g<c-w>S` | Load `Session.vim` in current directory           |
-- +---------+----------------------------------------------------+
-- |`<c-w>M`  | Save/overwrite `Session.vim` to global directory  |
-- |`<c-w>S`  | Load `Session.vim` in global directory            |
-- +---------+----------------------------------------------------+
-- NOTE:
-- 1. *Global directory* in this section refers to the directory vim was
--    launched from and which can be considered to be the *project root
--    directory*. Working on this global directory comes especially handy when
--    working with sessions with one *rogue* tabpage that used `:tcd` to a
--    different working directory.
-- 2. By default I want to save/load `Session.vim` to/frpm global directory,
--    but also allow using a current directory with the `g*` prefix.
-- 3. Preferring overwrite variants (i.e. `mksession!`) because if I have only
--    mapping to spend for this, the overwriting one seems more useful.

-- Make/source `Session.vim` from global directory
vim.keymap.set(
  "n",
  "<c-w>M",
  "<cmd>call MakeSessionInGlobalDirectoryOverwriteIfNeeded()<cr>",
  { silent = true, desc = "Make `Session.vim` in global directory" }
)
vim.keymap.set(
  "n",
  "<c-w>S",
  "<cmd>call SourceSessionFileInGlobalDirectory()<cr>",
  { silent = true, desc = "Source `Session.vim` from global directory" }
)

-- Make/source `Session.vim` from current directory
vim.keymap.set(
  "n",
  "g<c-w>M",
  "<cmd>call MakeSessionInCurrentDirectoryOverwriteIfNeeded()<cr>",
  { silent = true, desc = "Make `Session.vim` in current directory" }
)
vim.keymap.set(
  "n",
  "g<c-w>S",
  "<cmd>call SourceSessionFileInCurrentDirectory()<cr>",
  { silent = true, desc = "Source `Session.vim` from current directory" }
)

-- SESSION HELPERS {{{3
vim.cmd([[
    function! SourceSessionFileInCurrentDirectory()
        try
            execute 'source Session.vim'
        catch /E484/ "Can't open `Session.vim``because it likely doesn't exist
            echoerr "ERROR E484: A `Session.vim` cannot be opened from current directory."
            return
        endtry
        echo "Sourced `Session.vim` from current directory."
    endfunction
    function! SourceSessionFileInGlobalDirectory()
        let path_separator = execute('version') =~# 'Windows' ? '\' : '/'
        try
            execute 'source' fnameescape(getcwd(-1) . path_separator . "Session.vim")
        catch /E484/ "Can't open `Session.vim``because it likely doesn't exist
            echoerr "ERROR E484: A `Session.vim` cannot be opened from global directory."
            return
        endtry
        echo "Sourced `Session.vim` from global directory."
    endfunction
    function! MakeSessionInGlobalDirectory()
        " TODO: DATED 11MAY23: This function is not being called anymore. Keep for a
        "   while just in case and then remove it.
        "
        let path_separator = execute('version') =~# 'Windows' ? '\' : '/'
        try
            execute 'mksession' fnameescape(getcwd(-1) . path_separator . "Session.vim")
        catch /E189/ "Session already exists
            echoerr "ERROR E189: A `Session.vim` file already exists at this location."
            return
        endtry
        echo "Session.vim saved in global directory."
    endfunction
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
    function! MakeSessionInCurrentDirectoryOverwriteIfNeeded()
        try
            execute 'mksession Session.vim'
        catch /E189/ "Session already exists
            execute 'mksession! Session.vim'
            echo "Session.vim overwritten in current directory."
            return
        endtry
        echo "Session.vim saved in current directory."
    endfunction
]])

-- SESSION OPTIONS {{{3
--   VIM:
--    `blank,buffers,curdir,folds,help,options,tabpages,winsize,terminal`
--   NVIM:
--     `blank,buffers,curdir,folds,help,tabpages,winsize,terminal` (No `options`)
--   DESIRED:
--      `blank,buffers,curdir,folds,help,tabpages,winsize,globals`
vim.opt.sessionoptions:remove({ "terminal" })
vim.opt.sessionoptions:append({ "tabpages", "globals" })

-- UTILITIES {{{1
-- IN COMMAND LINE USE `UP`/`DOWN` LIKE `C-N`/C-P` (DURING AUTOCOMPLETE) {{{2
-- TODO: Check if this still works with `*cmp*` still on
vim.keymap.set("c", "<up>", function()
  if vim.fn.pumvisible() == 1 then
    return "<c-p>"
  else
    return "<up>"
  end
end, {
  expr = true,
  desc = "Go up(`<c-p>`) when in command mode completion popup",
})
vim.keymap.set("c", "<down>", function()
  if vim.fn.pumvisible() == 1 then
    return "<c-n>"
  else
    return "<down>"
  end
end, {
  expr = true,
  desc = "Go down(`<c-n>`) when in command mode completion popup",
})
-- WRITE(ALL) AND QUIT(ALL) {{{2
-- `W`:  Write all changed buffers to disk: `W`
-- `W!`: Write all changed buffers to disk, even read-only ones
vim.api.nvim_create_user_command("W", "wall<bang>", {
  bang = true,
  desc = "Write all changed buffers to disk,"
    .. " use `!` to write read-only buffers also",
})
-- `Q`:  Close all windows and exit but confirm if any buffers have unsaved changes
-- `Q!`: Close all windows and exit, ignoring changed buffer
vim.api.nvim_create_user_command("Q", "qall<bang>", {
  bang = true,
  desc = "Close all windows and exit, use `!` to ignore unsaved changes",
})
vim.keymap.set("n", "<leader>Q", "<cmd>qall<cr>", { silent = true })
vim.keymap.set("n", "<leader>Q!", "<cmd>qall!<cr>", { silent = true })

-- RETAIN VISUAL SELECTION AFTER AN INDENTATION SHIFT. {{{2
vim.keymap.set("v", "<", "<gv", { silent = true })
vim.keymap.set("v", ">", ">gv", { silent = true })

-- YANK TO END OF LINE `Y` LIKE `C` OR `D` {{{2
vim.keymap.set("n", "Y", "y$", { silent = true })

-- RETAIN CURSOR POSITION AFTER JOINING TWO LINES WITH `J` {{{2
-- TODO: Achieve this without polluting registers (here `z`)
vim.keymap.set("n", "J", "mzJ`z", { silent = true })

-- HIGHLIGHT YANKED TEXT {{{2
local highlight_yanked_text_augroup = vim.api.nvim_create_augroup(
  "highlight_yanked_text_augroup",
  { clear = true }
)

-- Highlight yank
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Briefly highlight yanked text",
  group = highlight_yanked_text_augroup,
  callback = function() vim.highlight.on_yank() end,
})

-- SOFT WRAPS {{{2
-- Add command `Wrap` to set settings required for soft wrap:
-- TODO: Move to user commands
-- TODO: Use lua
vim.cmd([[ command! -nargs=* Wrap set wrap linebreak nolist ]])

-- WRITE MODE {{{2
-- TODO: enable automatically in certain filetypes like markdown, commits etc.
-- Create Write-friendly environment
-- NOTE: This is very basic, for more use a plugin like goyo.vim
-- FIXME: Make this a toggle
vim.cmd([[
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
    endfunction
]])
-- FIXME: This is too broken
vim.api.nvim_create_user_command(
  "WriteMode",
  "call WriteMode()",
  { bang = false, desc = "Make environment writing friendly" }
)
vim.keymap.set(
  "n",
  "<localleader>w",
  "<cmd>call WriteMode()<cr>",
  { silent = true }
)

-- HEADER DIVIDER LINES {{{2
-- Make heading divider lines above/below current line using characters:
--  `-`/`_`/`=`
-- TODO: Add surround heading mode that will put the lines above/below line.
-- TODO: Make current line into a heading (provide mapping/command).
-- TODO: Make line span length of current line or specific length e.g. 80.
-- TODO: Put a space after the comment indicator e.g. `# -----` etc.
vim.cmd([[
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
]])
vim.keymap.set(
  "n",
  "[-",
  "<cmd>call DrawHeadingLineWithCharacter('-', 'above')<cr>",
  { silent = true }
)
vim.keymap.set(
  "n",
  "]-",
  "<cmd>call DrawHeadingLineWithCharacter('-', 'below')<cr>",
  { silent = true }
)
vim.keymap.set(
  "n",
  "[_",
  "<cmd>call DrawHeadingLineWithCharacter('_', 'above')<cr>",
  { silent = true }
)
vim.keymap.set(
  "n",
  "]_",
  "<cmd>call DrawHeadingLineWithCharacter('_', 'below')<cr>",
  { silent = true }
)
vim.keymap.set(
  "n",
  "[=",
  "<cmd>call DrawHeadingLineWithCharacter('=', 'above')<cr>",
  { silent = true }
)
vim.keymap.set(
  "n",
  "]=",
  "<cmd>call DrawHeadingLineWithCharacter('=', 'below')<cr>",
  { silent = true }
)

-- CLOSE HELPER WINDOWS (quickfix/location list etc.) {{{2
-- Close/Toggle helper windows (quickfix/location list etc.)
-- TODO:
-- - Use lua for functions
-- - There is no apparent vim's `popup_clear()` in neovim. Look into it and
--   use a function that clears all "floating windows" (equivalent of vim's popup
--   windows in nvim?).
--   SEE: https://github.com/wookayin/dotfiles/commit/96d935515486f44ec361db3df8ab9ebb41ea7e40
vim.cmd([[
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
    function! CloseAllHelperWindows()
        pclose
        lclose
        cclose
        " call popup_clear() " Find a nvim equivalent to do this.
    endfunction
    function! CloseAllHelperWindowsInAllTabsAndReturnToPreviousPosition()
        let current_tab = tabpagenr()
        tabdo windo execute 'call CloseAllHelperWindows()'
        execute 'tabnext' current_tab
    endfunction
]])
-- Close all helper windows
vim.keymap.set(
  "n",
  "<leader>z",
  "<cmd>call CloseAllHelperWindows()<cr>",
  { silent = true }
)

-- Close all helper windows in all tabs
-- TODO: This is interfering with terminal. the tab close `ZZ` should not be
-- called when I'm using the terminal. See if terminal is included in helper
-- windows list too?
vim.keymap.set(
  "n",
  "<leader>Z",
  "<cmd>call CloseAllHelperWindowsInAllTabsAndReturnToPreviousPosition()<cr>",
  { silent = true }
)

-- Toggle quickfix window
vim.keymap.set(
  "n",
  "<leader>q",
  "<cmd>call ToggleQuickFix()<cr>",
  { silent = true }
)

-- Toggle location list window
vim.keymap.set(
  "n",
  "<leader>ll",
  "<cmd>call ToggleLocationList()<cr>",
  { silent = true }
)

-- DUPLICATE WORD IN LINE ABOVE CURSOR {{{2
-- Autocomplete word from line above cursor
-- TODO:
-- - Do word in below line as well.
-- - Move into a function/plugin. (and do things like choose target anywhere else)
-- - edge case: letter immediately above is empty
-- - Add space after pasting the word
-- - ISSUE: first word will pase fine, words after when going up with k move
--   into space and copy that space along with word. If i use a h to just go
--   back one letter, them the entire mapping fails beause there is no h on the
--   first word.
--   FIXME: Move into a function and handle this case.
--   FIXME: `<esc>` moves the cursor back on when entering normal mode, so
--   the following `k` part will also see cursor going back one char in the
--   above line and then when `ye` happens we get one character already
--   present from the current line. Handling these cases will be easier in a
--   proper function.
vim.keymap.set(
  "i",
  "<c-y><tab>",
  "<esc>kyejpa<space>",
  { silent = true, desc = "Complete word in line above cursor" }
)
vim.keymap.set(
  "i",
  "<c-e><tab>",
  "<esc>jyekpa<space>",
  { silent = true, desc = "Complete word in line below cursor" }
)

-- GET HIGLIGHT GROUP NAME UNDER CURSOR {{{2
-- SOURCE: https://stackoverflow.com/a/58244921/225903
vim.cmd([[ 
    function! SynStack()
        for i1 in synstack(line("."), col("."))
            let i2 = synIDtrans(i1)
            let n1 = synIDattr(i1, "name")
            let n2 = synIDattr(i2, "name")
            echo n1 "->" n2
        endfor
    endfunction

    nnoremap gh <cmd>call SynStack()<cr>
]])
vim.keymap.set(
  "n",
  "<leader>h",
  "<cmd>call SynStack()<cr>",
  { silent = true, desc = "Show highlight group heirachy under cursor" }
)

-- JUMP LIST {{{2
--  TODO: Move to backward-most/forward-most position in jump list
--  nnoremap <silent> [J ???
--  nnoremap <silent> ]J ???
--
-- ISSUE: By default `<c-o>` and `<c-i>` move backward and forward in jumplist.
--    but `<c-i>` is generally the same code as `Tab` which I use in tab page
--    navigation keymaps, hence `<c-i>/Tab` is not available for this use.
-- TEMP_FIX: Use unimpaired-style keymaps `[j` and `]j` to navigate the jump list.
--  Move backward/forward through jump list by 1 step
-- nnoremap <silent> [j :<c-u>execute "normal! \<c-o>"<CR>
-- nnoremap <silent> ]j :<c-u>execute "normal! 1\<c-i>"<CR>
-- FIXME: Specify control sequence in the command sting properly
-- vim.keymap.set('n' , '[j', "<cmd>execute 'normal! \<c-o>'<cr>", {silent = true})
-- vim.keymap.set('n' , '[j', "<cmd>execute 'normal! 1\<c-i>'<cr>", {silent = true})

-- KILL BUFFER IN CURRENT WINDOW {{{2
-- Delete buffer in current window
vim.keymap.set("n", "<leader>bd", "<cmd>bd<cr>", { silent = true })
-- TODO: Add a variant that keeps the window open

-- TOGGLE MODIFIABLE {{{2
-- Toggle modifiable current buffer
-- NOTE: Mapping `yom` is in the style of `tpope/vim-unimpaired`
-- TODO: Use lua
-- Turn on modifiable on current buffer
vim.keymap.set(
  "n",
  "]om",
  -- "<cmd>setlocal modifiable<cr>",
  function() vim.bo.modifiable = true end,
  { silent = true }
)
-- Turn off modifiable on current buffer
vim.keymap.set(
  "n",
  "[om",
  -- "<cmd>setlocal nomodifiable<cr>",
  function() vim.bo.modifiable = false end,
  { silent = true }
)
-- Toggle modifiable on current buffer
vim.keymap.set(
  "n",
  "yom",
  function() vim.bo.modifiable = not vim.bo.modifiable end,
  { silent = true }
)

-- LINE MOVING UTILITIES {{{2
-- LEGEND:
--  Push: Move line (over above/below line etc.)
--  Smush: Merge line (into above/below line etc., in trailing/leading)
--
-- TODO:
--  1. Visual block smushes
--      a. Merge first line of visual block(trailing) into line above visual block(leading)
--      b. Merge bottom line of visual block(leading) with line below visual block(trailing)
--      c. Merge(smush) into itself.
--  2. Move selection with `{` and `}` actions etc.
--  3. Choose which end(leading/trailing) of target line to smush into.
--  4. IDEA: `Copy` out of chosen selection.
--      e.g. a variant of `<m-down>`: `g<m-down>` will copy current line downwards
--      have these variants for all them, I'm not sure of the leading `g` yet.
-- LINE SMUSHES {{{3
vim.keymap.set(
  "n",
  "<m-s-up>",
  "kJ",
  { desc = "Merge line(trailing) into above line(leading)" }
)
vim.keymap.set(
  "n",
  "<m-s-down>",
  "J",
  { desc = "Merge line(leading) with below line(trailing)" }
)

-- LINE SPLIT PUSHES {{{3
-- SPLIT RIGHT AT CURSOR {{{4
vim.keymap.set("n", "<m-s-right><m-up>", "mzDO<esc>pV=`z", {
  desc = "Split line at cursor and move right(trailing) content to a new line above",
})
vim.keymap.set("n", "<m-s-right><m-down>", "mzDo<esc>pV=`z", {
  desc = "Split line at cursor and move right(trailing) content to a new line below",
})
vim.keymap.set("n", "<m-s-left><m-up>", "mzd^O<esc>pV=`z", {
  desc = "Split line at cursor and move left(leading) content to a new line above",
})
vim.keymap.set("n", "<m-s-left><m-down>", "mzd^o<esc>pV=`z", {
  desc = "Split line at cursor and move left(leading) content to a new line below",
})

-- SPLIT RIGHT AFTER CURSOR {{{4
vim.keymap.set("n", "<m-right><m-up>", "mzlDO<esc>pV=`z", {
  desc = "Split line at cursor and move right(trailing) content to a new line above",
})
vim.keymap.set("n", "<m-right><m-down>", "mzlDo<esc>pV=`z", {
  desc = "Split line at cursor and move right(trailing) content to a new line below",
})
vim.keymap.set("n", "<m-left><m-up>", "mzld^O<esc>pV=`z", {
  desc = "Split line at cursor and move left(leading) content to a new line above",
})
vim.keymap.set("n", "<m-left><m-down>", "mzld^o<esc>pV=`z", {
  desc = "Split line at cursor and move left(leading) content to a new line below",
})

-- LINE SPLIT SMUSHES {{{3
-- TODO: Allow choice to smush leading/trailing
-- SPLIT RIGHT AT CURSOR {{{4
vim.keymap.set("n", "<m-s-right><m-s-up>", "mzDO<esc>pkJV=`z", {
  desc = "Split line at cursor and merge right(trailing) content into above line(leading)",
})
vim.keymap.set("n", "<m-s-right><m-s-down>", "mzDo<esc>pJV=`z", {
  desc = "Split line at cursor and merge right(trailing) content with below line(trailing)",
})
vim.keymap.set("n", "<m-s-left><m-s-up>", "mzld^O<esc>pkJV=`z", {
  desc = "Split line at cursor and merge left(leading) content into above line(leading)",
})
vim.keymap.set("n", "<m-s-left><m-s-down>", "mzld^o<esc>pJV=`z", {
  desc = "Split line at cursor and merge left(leading) content with below line(trailing)",
})

-- SPLIT RIGHT AFTER CURSOR {{{4
vim.keymap.set("n", "<m-right><m-s-up>", "mzlDO<esc>pkJV=`z", {
  desc = "Split line at cursor and move right(trailing) content to a new line above",
})
vim.keymap.set("n", "<m-right><m-s-down>", "mzlDo<esc>pJV=`z", {
  desc = "Split line at cursor and move right(trailing) content to a new line below",
})
vim.keymap.set("n", "<m-left><m-s-up>", "mzd^O<esc>pkJV=`z", {
  desc = "Split line at cursor and move left(leading) content to a new line above",
})
vim.keymap.set("n", "<m-left><m-s-down>", "mzd^o<esc>pJV=`z", {
  desc = "Split line at cursor and move left(leading) content to a new line below",
})

-- TOGGLE GUTTER (SIGN COLUMN)  {{{2
-- Toggle gutter (sign column)
-- NOTE: keymaps set in tandem with unimpaired plugi
-- NOTE: Using `g` instead of `s` as mnemonic for keymap because:
--  1. `s` is being used by `spell`
--  2. `g` for `gutter`
--  3. I seem to remember it more as gutter than signcolumn anyway.
vim.cmd([[
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
]])
-- Toggle gutter (sign column)
vim.keymap.set(
  "n",
  "yog",
  "<cmd>call ToggleSignColumn()<cr>",
  { silent = true }
)
-- Turn on gutter (sign column)
vim.keymap.set(
  "n",
  "]og",
  "<cmd>setlocal signcolumn=yes<cr>",
  { silent = true }
)
-- Turn off gutter (sign column)
vim.keymap.set(
  "n",
  "[og",
  "<cmd>setlocal signcolumn=no<cr>",
  { silent = true }
)
-- Set gutter (sign column) to turn on/off automatically
-- TODO: Consider disabling this, as it's too unweildy
-- NOTE: This is in the style of `tpope/vim-unimpaired` and since the about
--       mapping/function does not cover `auto` this does;
--       the mnemonic `]oga` is for `turn on the gutter=auto`
vim.keymap.set(
  "n",
  "]oga",
  "<cmd>setlocal signcolumn=auto<cr>",
  { silent = true }
)

-- TOGGLE CURSOR LINES {{{2
-- TODO
-- Consider using `-` and `|` so like  `yo-` and `yo|`?

-- VIMRC UTILITIES {{{2
-- " Load `vimrc` quickly
-- TODO: Switch this to `init.lua`
-- TODO: Set `nomodifiable` on loaded vimrc? or provided a read-only variant
-- nnoremap <silent> <leader>v :edit $MYVIMRC<CR>
vim.keymap.set(
  "n",
  "<leader>v",
  "<cmd>edit $MYVIMRC<cr>",
  { silent = true }
)
-- SAVE SHORTCUTS {{{2
-- Save with `<c-s>`
-- NOTE:
--  Terminals consider `<c-s>` a legacy flow character which can be
--  disabled with the following to use `<c-s>`
-- bashrc/zshrc:"
--      # Enable <c-s> and <c-q> in zsh with  ~/.zshrc:
--     stty start undef
--     stty stop undef
--     setopt noflowcontrol
-- Enable <c-s> and <c-q> in bash with ~/.bash_profile or ~/.bashrc:
--    stty -ixon
-- TODO: Check if equivalent fix is needed in fish shell.
-- NOTE: To Vim both `<c-s>` and `<c-S>` are the same, because it cannot
--       differentiate case within control character paired combos.
vim.keymap.set("n", "<c-s>", "<cmd>update<cr>", { silent = true })
vim.keymap.set("v", "<c-s>", "<c-c>:<c-u>update<cr>", { silent = true })
-- TODO: The visual selection is lost. Return it back like you'd think `gv` would.
vim.keymap.set("i", "<c-s>", "<c-o>:<c-u>update<cr>", { silent = true })

-- GENERAL LSP SETTINGS {{{1
-- Common lsp keymaps using given buffer number{{{2
-- local function lsp_keymaps_using_buffer_number(buffernumber)
-- XXX
local set_common_lsp_keymaps_with_buffer_number = function(buffer_number)
  local buffer_opts =
    { noremap = true, silent = true, buffer = buffer_number }

  local function opts_with_desc(opts, desc)
    opts["desc"] = desc
    return opts
  end

  -- COMMON LSP MAPPINGS THAT ARE JUST FOR THE BUFFER
  vim.keymap.set(
    "n",
    "lD",
    vim.lsp.buf.declaration,
    opts_with_desc(buffer_opts, "Jump to symbol declaration")
  )
  vim.keymap.set(
    "n",
    "ld",
    vim.lsp.buf.definition,
    opts_with_desc(buffer_opts, "Jump to symbol definition")
  )
  vim.keymap.set(
    "n",
    "lk",
    vim.lsp.buf.hover,
    opts_with_desc(
      buffer_opts,
      "Display symbol hover information in floating window"
    )
  )
  vim.keymap.set(
    "n",
    "li",
    vim.lsp.buf.implementation,
    opts_with_desc(
      buffer_opts,
      "List symbol implementations in quickfix window"
    )
  )
  vim.keymap.set(
    "n",
    "lk",
    vim.lsp.buf.signature_help,
    opts_with_desc(
      buffer_opts,
      "Display symbol signature information in floating winodw"
    )
  )
  vim.keymap.set(
    "n",
    "lwa",
    vim.lsp.buf.add_workspace_folder,
    opts_with_desc(buffer_opts, "Add folder at path to workspace folders")
  )
  vim.keymap.set(
    "n",
    "lwr",
    vim.lsp.buf.remove_workspace_folder,
    opts_with_desc(
      buffer_opts,
      "Remove folder at path from workspace folders"
    )
  )
  vim.keymap.set(
    "n",
    "lwl",
    function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
    opts_with_desc(buffer_opts, "List workspace folders.")
  )
  vim.keymap.set(
    "n",
    -- "lD",
    "lt",
    vim.lsp.buf.type_definition,
    opts_with_desc(buffer_opts, "Jump to type of symbol definition")
  )
  vim.keymap.set(
    "n",
    "lr",
    vim.lsp.buf.rename,
    opts_with_desc(buffer_opts, "Rename all symbol references")
  )
  vim.keymap.set(
    { "n", "v" },
    "la",
    vim.lsp.buf.code_action,
    opts_with_desc(
      buffer_opts,
      "Select code action available at cursor position"
    )
  )
  vim.keymap.set(
    "n",
    "lrf",
    vim.lsp.buf.references,
    opts_with_desc(
      buffer_opts,
      "List all symbol references in the quickfix window"
    )
  )
  vim.keymap.set(
    "n",
    "lf",
    function() vim.lsp.buf.format({ async = true }) end,
    opts_with_desc(buffer_opts, "Format with LSP client")
  )

  -- COMMON LSP MAPPINGS THAT ARE NOT FOR THE BUFFER
  vim.keymap.set(
    "n",
    "le", -- TODO: Find better keyword
    vim.diagnostic.open_float,
    { desc = "Show diagnostics in a floating window." }
  )
  vim.keymap.set(
    "n",
    "[l",
    vim.diagnostic.goto_prev,
    { desc = "Move to previous diagnostic" }
  )
  vim.keymap.set(
    "n",
    "]l",
    vim.diagnostic.goto_next,
    { desc = "Move to the next diagnostic." }
  )
  vim.keymap.set(
    "n",
    "[L",
    function()
      vim.diagnostic.goto_next({
        severity = vim.diagnostic.severity.ERROR,
      })
    end,
    { desc = "Move to the previous `ERROR` diagnostic" }
  )
  vim.keymap.set(
    "n",
    "]L",
    function()
      vim.diagnostic.goto_prev({
        severity = vim.diagnostic.severity.ERROR,
      })
    end,
    { desc = "Move to the next `ERROR` diagnostic" }
  )
  vim.keymap.set(
    "n",
    "lq",
    vim.diagnostic.setloclist,
    { desc = "Add diagnostics to quickfix list" }
  )
  vim.keymap.set(
    "n",
    "lc",
    vim.diagnostic.setloclist,
    { desc = "Add buffer diagnostics to location list" }
  )
end

local DELTE_ME = set_common_lsp_keymaps_with_buffer_number -- TODO: Delte me
-- SET LSP SIGN SYMBOLS {{{2
vim.fn.sign_define(
  "DiagnosticSignError",
  { text = "󰬌 ", texthl = "DiagnosticSignError" }
)
vim.fn.sign_define(
  "DiagnosticSignWarn",
  { text = "󰬞 ", texthl = "DiagnosticSignWarn" }
)
vim.fn.sign_define(
  "DiagnosticSignInfo",
  { text = "󰬐 ", texthl = "DiagnosticSignInfo" }
)
vim.fn.sign_define(
  "DiagnosticSignHint",
  { text = " ", texthl = "DiagnosticSignHint" }
)

-- LAZY PLUGIN MANAGER {{{1
-- LAZY INIT {{{2
-- NOTE: `lazy.nvim` requires `<leader>` and `<localleader>` to be configured.
-- INSTALL LAZY IF NOT PRESENT:
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
local lazy_opts = {
  ui = {
    border = "rounded",
    custom_keys = {
      -- OPEN LAZY UI:
      -- vim.keymap.set("n", "<m-l>", "<cmd>Lazy<cr>", { silent = true })
      ["<m-l>"] = "<cmd>Lazy<cr>", --XXX
    },
  },
}

require("lazy").setup(
  {
    -- PLUGINS {{{2
    -- Popup with possible keybindings of command you started typing
    {
      "folke/which-key.nvim", -- {{{3
      event = "VeryLazy",
      init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
      end,
      opts = {
        icons = {
          separator = "",
        },
        popup_mappings = {
          scroll_up = "<up>",
          scroll_down = "<down>",
        },
        window = {
          position = "bottom",
          padding = { 1, 1, 1, 1 },
          winblend = 10,
        },
        plugins = {
          spelling = { enabled = true, suggestions = 12 },
        },
      },
    },

    -- Surrounds text objects
    {
      "tpope/vim-surround", -- {{{3
      event = "VeryLazy",
      init = function()
        -- NOTE: Do'nt use vim.keymap.set for this one.
        vim.cmd([[ vmap s S ]])
      end,
    },

    -- Work with several variants of a word at once and fix all case typos
    {
      "tpope/tpope-vim-abolish", -- {{{3
      event = "VeryLazy",
      config = function()
        -- TODO: If specifying these here works out well, remove
        -- dependency on external abolish file, see `:help abolish`.
        vim.cmd([[
                Abolish impoty import
                Abolish impory import
                Abolish improt import
                Abolish impotr import
            ]])

        -- the
        vim.cmd([[
                Abolish teh the
            ]])

        -- django
        vim.cmd([[
                Abolish djano  django
                Abolish dajgno django
                Abolish djagno django
                Abolish djnago django
                Abolish djangp django
            ]])
      end,
    },

    -- Helps "end" certain structures like `do`/`end` blocks automatically
    {
      "tpope/vim-endwise", -- {{{3
      event = "VeryLazy",
    },

    -- Helpers for UNIX
    {
      "tpope/vim-eunuch", -- {{{3
      event = "VeryLazy",
    },

    -- Git wrapper
    {
      "tpope/vim-fugitive", -- {{{3
      event = "VeryLazy",
    },

    -- Vim Liquid runtime files with Jekyll enhancements
    {
      "tpope/vim-liquid", -- {{{3
      event = "VeryLazy",
    },

    -- Enable repeating supported plugin maps with "."
    {
      "tpope/vim-repeat", -- {{{3
      event = "VeryLazy",
    },

    -- Readline style insertion keymaps
    {
      "tpope/vim-rsi", -- {{{3
      event = "VeryLazy",
    },

    -- Netrw enhancer
    {
      "tpope/vim-vinegar", -- {{{3
      event = "VeryLazy",
    },

    -- Pairs of handy bracket keymaps
    -- TODO: replace this with the nvim version which allows chosing
    -- keymaps
    {
      "tpope/vim-unimpaired", -- {{{3
      -- lazy = false, -- Load during startup if main colorscheme
      event = "VeryLazy",
      keys = {
        -- LINES:
        -- NOTE: Remaining related utilities in line utlities section
        -- TODO: Refactor lines out of unimpaired section
        { "<m-up>", "[e", remap = true, desc = "Move line downwards" },
        { "<m-down>", "]e", remap = true, desc = "Move line upwards" },
        -- VISUAL SELECTION
        -- TODO: Refactor visual selectionout of unimpaired section
        {
          mode = "v",
          "<m-up>",
          "[egv=gv",
          remap = true,
          desc = "Move visual selection upwards",
        },
        {
          mode = "v",
          "<m-down>",
          "]egv=gv",
          remap = true,
          desc = "Move visual selection downwards",
        },
        -- Cursorline
        -- (default: `c`, duplicated to: `_`)
        { "yo-", "yoc", remap = true, desc = "Toggle cursorline" },
        { "[o-", "[oc", remap = true, desc = "Enable cursorline" },
        { "]o-", "]oc", remap = true, desc = "Disable cursorline" },

        -- Cursorcolumn
        -- (default: `u`, duplicated to: `|`)
        { "yo|", "you", remap = true, desc = "Toggle cursorcolumn" },
        { "[o|", "[ou", remap = true, desc = "Enable cursorcolumn" },
        { "]o|", "]ou", remap = true, desc = "Disable cursorcolumn" },

        -- SPELL
        -- default: `s`, duplicated to: `z`
        { "yoz", "yos", remap = true, desc = "Toggle spell" },
        { "[oz", "[os", remap = true, desc = "Enable spell" },
        { "]oz", "]os", remap = true, desc = "Disable spell" },
      },
    },

    -- Aligning
    -- TODO: Add trigger with cmd/keys
    -- TODO: Try to get "junegunn/vim-easy-align" to work
    -- NOTE: Ignore 'echasnovski/mini.align', not good for me

    -- -- Refactoring
    -- -- NOTE: Disabled for LSP
    -- -- TODO: Add keymaps
    -- -- TODO: Add telescope extension
    -- {
    --   "ThePrimeagen/refactoring.nvim", -- {{{3
    --   event = "VeryLazy",
    --   dependencies = {
    --     { "nvim-lua/plenary.nvim" },
    --     { "nvim-treesitter/nvim-treesitter" },
    --   },
    -- },

    -- Colors
    -- FIXME: Very buggy for me
    -- {
    --   "norcalli/nvim-colorizer.lua", -- {{{3
    --   event = "VeryLazy",
    --   opts = {
    --     mode = "background", -- set foreground/background text color
    --   },
    -- },

    -- Indent Guides
    {
      "lukas-reineke/indent-blankline.nvim", -- {{{3
      event = "BufEnter",
      -- init = function()
      --  TODO: Less intense color
      -- end,
      opts = {
        show_current_context = false,
      },
    },

    -- Dim inactive window
    -- FIXME: tint.nvim flat out does not work
    -- {
    --   "levouh/tint.nvim",
    --   lazy = false,
    --   -- opts = {
    --   --   tint = -45, -- Darken colors, use a positive value to brighten
    --   --   saturation = 0.6, -- Saturation to preserve
    --   --   transforms = require("tint").transforms.SATURATE_TINT, -- Showing default behavior, but value here can be predefined set of transforms
    --   --   tint_background_colors = true, -- Tint background portions of highlight groups
    --   --   highlight_ignore_patterns = { "WinSeparator", "Status.*" }, -- Highlight group patterns to ignore, see `string.find`
    --   --   window_ignore_function = function(winid)
    --   --     local bufid = vim.api.nvim_win_get_buf(winid)
    --   --     local buftype = vim.api.nvim_buf_get_option(bufid, "buftype")
    --   --     local floating = vim.api.nvim_win_get_config(winid).relative
    --   --       ~= ""
    --   --
    --   --     -- Do not tint `terminal` or floating windows, tint everything else
    --   --     return buftype == "terminal" or floating
    --   --   end,
    --   -- },
    -- },

    -- FIXME: After using Neotree, active window is still dimmed
    -- FIXME: Last visible line of all inactive windows is not dimmed
    -- {
    --   "sunjon/shade.nvim", -- {{{3
    --   lazy = false,
    --   priority = 700,
    --   opts = {},
    -- },

    -- Expand emmet abbreviations
    {
      "mattn/emmet-vim", -- {{{3
      event = "VeryLazy",
    },

    -- Animate movements
    {
      "echasnovski/mini.animate", -- {{{3
      event = "VeryLazy",
      opts = function()
        -- don't use animate when scrolling with the mouse
        local mouse_scrolled = false
        for _, scroll in ipairs({ "Up", "Down" }) do
          local key = "<ScrollWheel" .. scroll .. ">"
          vim.keymap.set({ "", "i" }, key, function()
            mouse_scrolled = true
            return key
          end, { expr = true })
        end

        local animate = require("mini.animate")
        return {
          cursor = { enable = false },
          window = { enable = false },
          resize = {
            -- TODO: tune the timing function
            timing = animate.gen_timing.quadratic({
              duration = 100,
              unit = "total",
            }),
          },
          scroll = {
            timing = animate.gen_timing.quadratic({
              duration = 100,
              unit = "total",
            }),
            subscroll = animate.gen_subscroll.equal({
              predicate = function(total_scroll)
                if mouse_scrolled then
                  mouse_scrolled = false
                  return false
                end
                return total_scroll > 1
              end,
            }),
          },
        }
      end,
    },

    -- Mini map
    {
      "echasnovski/mini.map", -- {{{3
      lazy = false,
      keys = {
        {
          "<cr>",
          "<cmd>lua MiniMap.toggle()<cr>",
          desc = "toggle mini map",
        },
        {
          "<s-cr>",
          "<cmd>lua MiniMap.toggle_side()<cr>",
          desc = "toggle mini map side",
        },
      },
      init = function()
        vim.api.nvim_set_hl(
          0,
          "MiniMapNormal", -- regular content
          { link = "Comment", blend = 20 }
        )
        vim.api.nvim_set_hl(
          0,
          "MiniMapSymbolView", -- scrollback line background
          { link = "LineNr", blend = 30 }
        )
        -- vim.api.nvim_set_hl(
        --   0,
        --   "MiniMapSymbolLine", -- scrollbar handle (default: Title)
        --   { link = "Title", blend = 30 }
        -- )
      end,
      opts = function()
        local minimap = require("mini.map")
        return {
          window = {
            -- focusable = true, -- when on, click transports but focus stays
            winblend = 20,
            show_integration_count = false,
            width = 5, -- set width = 0 for just the scrollbar
          },
          integrations = {
            minimap.gen_integration.builtin_search(),
            minimap.gen_integration.diagnostic({
              error = "DiagnosticFloatingError",
              warn = "DiagnosticFloatingWarn",
              info = "DiagnosticFloatingInfo",
              hint = "DiagnosticFloatingHint",
            }),
            minimap.gen_integration.gitsigns({
              add = "GitSignsAdd",
              change = "GitSignsChange",
              delete = "GitSignsDelete",
            }),
          },
          symbols = {
            encode = minimap.gen_encode_symbols.dot("4x2"),
            -- set both scroll values the same; distinguish by color
            scroll_line = "│",
            scroll_view = "│",
          },
        }
      end,
      dependencies = {
        "lewis6991/gitsigns.nvim",
      },
    },

    -- Commenting
    {
      "numToStr/Comment.nvim", -- {{{3
      event = "VeryLazy",
      opts = {
        toggler = {
          -- line = "gcc",
          block = "gbb", -- default `gbc`
        },
      },
    },

    -- Distraction free writing
    -- FIXME: zen-mode not working, find alternative
    -- {
    --   "folke/zen-mode.nvim", -- {{{3
    --   opts = {
    --     window = {
    --       backdrop = 0.80, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
    --       -- height and width can be:
    --       -- * an absolute number of cells when > 1
    --       -- * a percentage of the width / height of the editor when <= 1
    --       -- * a function that returns the width or the height
    --       width = 90, -- width of the Zen window
    --       height = 1, -- height of the Zen window
    --       -- by default, no options are changed for the Zen window
    --       -- uncomment any of the options below, or add other vim.wo options you want to apply
    --       options = {
    --         -- signcolumn = "no", -- disable signcolumn
    --         -- number = false, -- disable number column
    --         -- relativenumber = false, -- disable relative numbers
    --         -- cursorline = false, -- disable cursorline
    --         -- cursorcolumn = false, -- disable cursor column
    --         -- foldcolumn = "0", -- disable fold column
    --         -- list = false, -- disable whitespace characters
    --       },
    --     },
    --     plugins = {
    --       -- disable some global vim options (vim.o...)
    --       -- comment the lines to not apply the options
    --       options = {
    --         enabled = true,
    --         ruler = false, -- disables the ruler text in the cmd line area
    --         showcmd = false, -- disables the command in the last line of the screen
    --       },
    --       twilight = { enabled = true }, -- enable to start Twilight when zen mode opens
    --       gitsigns = { enabled = false }, -- disables git signs
    --       tmux = { enabled = false }, -- disables the tmux statusline
    --       -- this will change the font size on kitty when in zen mode
    --       -- to make this work, you need to set the following kitty options:
    --       -- - allow_remote_control socket-only
    --       -- - listen_on unix:/tmp/kitty
    --       kitty = {
    --         enabled = false,
    --         font = "+4", -- font size increment
    --       },
    --       -- this will change the font size on alacritty when in zen mode
    --       -- requires  Alacritty Version 0.10.0 or higher
    --       -- uses `alacritty msg` subcommand to change font size
    --       alacritty = {
    --         enabled = false,
    --         font = "14", -- font size
    --       },
    --       -- this will change the font size on wezterm when in zen mode
    --       -- See alse also the Plugins/Wezterm section in this projects README
    --       wezterm = {
    --         enabled = false,
    --         -- can be either an absolute font size or the number of incremental steps
    --         font = "+4", -- (10% increase per step)
    --       },
    --     },
    --     -- callback where you can add custom code when the Zen window opens
    --     on_open = function(win) end,
    --     -- callback where you can add custom code when the Zen window closes
    --     on_close = function() end,
    --   },
    -- },
    --

    -- Color columns
    {
      "m4xshen/smartcolumn.nvim", -- {{{3
      opts = {
        -- disabled_filetypes = { "help", "text", "markdown" }  -- default
      },
      colorcolumn = { "80", "100" }, -- default: "80"
      -- "file" (default) / "window": visible part of current window / "line": current line
      scope = "window",
      -- custom_colorcolumn = { python = "80", haskell = { "80", "120"} } -- {} (default)
    },

    -- inverse toggle e.g. true/false
    {
      "nguyenvukhang/nvim-toggler",
      opts = {
        remove_default_keybinds = true,
        -- remove_default_inverses = false,
        inverses = {
          ["enable"] = "disable",
          ["start"] = "stop",
        },
      },
      keys = {
        {
          "<localleader>t", -- TODO: Find another, might have interference
          function() require("nvim-toggler").toggle() end,
          mode = { "n", "v" },
          desc = "Invert word under cursor",
        },
      },
    },

    -- Colorscheme
    {
      "folke/tokyonight.nvim", -- {{{3
      lazy = false, -- Load during startup if main colorscheme
      priority = 1000, -- Load before all other start plugins
      init = function() vim.cmd.colorscheme("tokyonight") end,
      opts = {
        style = "moon", -- @type `storm` | `moon`| `night`(darkest) | `day` (light)
        terminal_colors = true,
        styles = {
          sidebars = "dark", -- backgrounds: @type: "dark" | "transparent" | "normal"
          floats = "dark", -- backgrounds: @type: "dark" | "transparent" | "normal"
          -- Style(syntax groups) = Value(attr-list value in `:help nvim_set_hl`)
          comments = { italic = true, bold = true },
          variables = { bold = true },
          keywords = { italic = true },
          functions = { italic = true, bold = true },
        },
        sidebars = { "qf", "help" }, --example: `["qf", "terminal", "packer"]`
        hide_inactive_statusline = true, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
        -- dim_inactive = false, -- do not dim, use alternate dimmer like `shade.nvim`
        dim_inactive = true, -- do not dim, use alternate dimmer like `shade.nvim`
        lualine_bold = true, -- Lualine section headers will be bold
      },
    },

    -- Status line
    {
      "nvim-lualine/lualine.nvim", -- {{{3
      lazy = false, -- Load during startup if main colorscheme
      opts = {
        options = {
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          ignore_focus = {},
          always_divide_middle = true,
          -- Show only one statusline for all windows
          globalstatus = true,
        },
        -- NOTE: Available values:
        -- `branch` , `buffers` , `diagnostics` , `diff` , `encoding` ,
        -- `fileformat` , `filename` , `filesize` , `filetype` ,
        -- `hostname` , `location` , `mode` , `progress` , `searchcount` ,
        -- `selectioncount` , `tabs`
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { "filename" },
          lualine_x = { "searchcount", "selectioncount", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = { "filename" },
          lualine_c = {},
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
        extensions = {
          -- "aerial",
          "fugitive", -- git
          -- "fzf", -- fuzzy search
          "lazy", -- plugin manager
          "man", -- manual
          -- "mundo", -- undo tree
          "neo-tree",
          -- "nvim-dap-ui", -- UI for dap(debug adapter protocol)
          -- "nvim-tree", -- file tree
          -- "overseer", -- taskrunner
          "quickfix",
          -- "symbols-outline", -- symbols tree
          "trouble", -- error list accumulator
        },
      },
      dependencies = { "nvim-tree/nvim-web-devicons" },
    },

    -- Tab bar
    {
      "gcmt/taboo.vim", -- {{{3
      init = function()
        vim.g.taboo_tab_format = [[ %d %f %m ]]
        vim.g.taboo_renamed_tab_format = [[ %d %l %m ]]
      end,
      dependencies = { "ryanoasis/vim-devicons" },
    },

    -- Undo
    {
      "simnalamburt/vim-mundo", -- {{{3
      event = "VeryLazy",
      init = function()
        -- NOTE: Vim saves/restores undo history to/from an undo file in
        -- directory specified in `undodir` whose nvim default is:
        -- undodir = ~/.local/state/nvim/undo//
        -- Enable saving the undo history to file in `undodir`
        vim.opt.undofile = true
      end,
      cmd = "MundoToggle",
      keys = {
        {
          "<m-u>",
          "<cmd>MundoToggle<cr>",
          desc = "Toggle Mundo undo-tree",
        },
      },
    },

    -- Auto pairs
    {
      "windwp/nvim-autopairs", -- {{{3
      event = "VeryLazy",
      init = function()
        local Rule = require("nvim-autopairs.rule")
        local npairs = require("nvim-autopairs")

        -- TODO: Add more language pairings
        -- <x>
        npairs.add_rule(Rule("<", ">", "rust"))
        -- |x|
        npairs.add_rule(Rule("|", "|", "rust"))
        -- __x__
        npairs.add_rule(Rule("__", "__", "python"))
        -- {%x%}
        npairs.add_rule(Rule("{%", "%}", "htmldjango"))
        -- <%x%>
        npairs.add_rule(Rule("<%", "%>", "heex"))
        npairs.add_rule(Rule("<%", "%>", "eelixir"))
        -- <%=x%>
        -- FIXME: This is doing both `<%` and `<%=`
        npairs.add_rule(Rule("<%=", "%>", "heex"))
        npairs.add_rule(Rule("<%=", "%>", "eelixir"))
      end,
      opts = {
        -- REMOVE UNCHANGED DEFAULT VARS
        disable_filetype = { "TelescopePrompt", "spectre_panel" },
        disable_in_macro = false, -- disable when recording or executing a macro
        disable_in_visualblock = false, -- disable when insert after visual block mode
        disable_in_replace_mode = true,
        ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=],
        enable_moveright = true,
        enable_afterquote = true, -- add bracket pairs after quote
        enable_check_bracket_line = true, --- check bracket in same line
        enable_bracket_in_quote = true,
        enable_abbr = false, -- trigger abbreviation
        break_undo = true, -- switch for basic rule break undo sequence
        check_ts = false,
        map_cr = true,
        map_bs = true, -- map the <BS> key
        map_c_h = false, -- Map the <C-h> key to delete a pair
        map_c_w = false, -- map <c-w> to delete a pair if possible
      },
    },

    -- File explorer
    {
      "nvim-neo-tree/neo-tree.nvim", -- {{{3
      branch = "v2.x",
      -- event = "VeryLazy",
      lazy = false,
      priority = 600,
      -- cmd = "NeoTree",
      init = function()
        -- Disable deprecated commands e.g. `:NeoTreeReveal`
        vim.g.neo_tree_remove_legacy_commands = 1
      end,
      keys = {
        -- Filesystem w/ current file selected
        {
          "<m-n>",
          "<cmd>Neotree action=focus source=filesystem position=left toggle=true reveal=true<cr>",
          desc = "Toggle NeoTree",
        },
        -- Git status?
        {
          "<m-N>",
          "<cmd>Neotree action=focus source=git_status position=left toggle=true reveal=true<cr>",
          desc = "Toggle NeoTree",
        },
      },
      dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "nvim-tree/nvim-web-devicons",
      },
    },

    -- Welcome page
    {
      "goolord/alpha-nvim", -- {{{3
      event = "VimEnter",
      config = function()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")

        -- set "dashboard" theme section contents
        dashboard.section.header.val = {
          [[                                                    ]],
          [[                                                    ]],
          [[ █▀▄▀█ █▀▀ █▀▄▀█ █▀▀ █▄░█ ▀█▀ █▀█   █▀▄▀█ █▀█ █▀█ █ ]],
          [[ █░▀░█ ██▄ █░▀░█ ██▄ █░▀█ ░█░ █▄█   █░▀░█ █▄█ █▀▄ █ ]],
          [[                                                    ]],
        }
        dashboard.section.buttons.val = {
          dashboard.button(
            "e",
            "" .. "  " .. "EDIT",
            ":ene <BAR> startinsert <CR>"
          ),
          dashboard.button(
            "s",
            -- "" .. " Source `./Session.vim",
            ""
              .. "  "
              .. "SOURCE `./Session.vim`",
            "<cmd>source ./Session.vim<cr>"
          ),
          dashboard.button(
            "c",
            "" .. "  " .. "EDIT `~/.config/nvim/init.lua`",
            "<cmd>edit $MYVIMRC<cr>"
          ),
          dashboard.button("q", "󰅗" .. "  " .. "QUIT", ":qa<cr>"),
        }
        local function footer()
          -- return [[“do not sleep, my starling, do not sleep”]]
          return [[AS LONG AS THERE IS LIFE, THERE IS HOPE]]
        end
        dashboard.section.footer.val = footer()

        -- set dashboard theme highlights
        -- dashboard.section.header.opts.hl = "Include"
        -- dashboard.section.buttons.opts.hl = "Keyword"
        -- dashboard.section.footer.opts.hl = "Type"
        dashboard.section.header.opts.hl = "Ccmment"
        dashboard.section.buttons.opts.hl = "Title"
        dashboard.section.footer.opts.hl = "Comment"

        -- turn off autocmds. TODO: why?
        dashboard.config.opts.noautocmd = false

        -- apply customized "dashboard" theme
        alpha.setup(dashboard.opts)
      end,
      dependencies = { "nvim-tree/nvim-web-devicons" },
    },

    -- Git
    {
      "lewis6991/gitsigns.nvim", -- {{{3
      event = { "BufReadPre", "BufNewFile" },
      opts = {
        signs = {
          add = { text = "▎" },
          change = { text = "▎" },
          delete = { text = "" },
          topdelete = { text = "" },
          changedelete = { text = "▎" },
          untracked = { text = "▎" },
        },
        on_attach = function(buffer)
          local gs = package.loaded.gitsigns

          -- TODO: Add git buffer mappings on git load
          local function map(mode, l, r, desc)
            vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
          end
          -- -- stylua: ignore start
          map("n", "]h", gs.next_hunk, "Next Hunk")
          map("n", "[h", gs.prev_hunk, "Prev Hunk")
          -- TODO: `[H`/`]H` for first/last hunk

          -- TODO: Uncomment and adapt
          -- map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
          -- map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
          -- map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
          -- map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
          -- map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
          -- map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
          -- map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
          -- map("n", "<leader>ghd", gs.diffthis, "Diff This")
          -- map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
          -- map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
        end,
      },
    },

    -- Fuzzy finder
    {
      "nvim-telescope/telescope.nvim", -- {{{3
      lazy = false,
      event = "VeryLazy",
      tag = "0.1.1",
      keys = {
        -- File pickers
        {
          "<space>a",
          "<cmd>Telescope<cr>",
          desc = "Search all of telescope",
        },
        {
          "<space>k",
          "<cmd>Telescope keymaps<cr>",
          desc = "Search keymaps",
        },
        {
          "<space><space>",
          "<cmd>Telescope find_files<cr>",
          desc = "Search files",
        },
        {
          "<space>g",
          "<cmd>Telescope git_files<cr>",
          desc = "Search git files",
        },
        {
          "<space>r",
          "<cmd>Telescope live_grep<cr>",
          desc = "Search inside files in dir (ripgrep)",
        },
        -- Vim
        {
          "<space>c",
          "<cmd>Telescope commands<cr>",
          desc = "Search commands",
        },
        {
          "<space>b",
          "<cmd>Telescope buffers<cr>",
          desc = "Search buffers",
        },
        {
          "<space>f",
          "<cmd>Telescope current_buffer_fuzzy_find<cr>",
          desc = "Search live in current buffer",
        },
        {
          "<space>t",
          "<cmd>Telescope current_buffer_tags<cr>",
          desc = "Search tags",
        },
      },
      opts = {
        defaults = {
          layout_strategy = "bottom_pane",
          layout_config = {
            bottom_pane = {
              height = 10,
              preview_cutoff = 120,
              prompt_position = "bottom",
            },
          },
          prompt_prefix = " ",
          selection_caret = " ",
          multi_icon = "+ ",
          border = true,
          results_title = false, -- hide `Results` title
          color_devicons = true,
          mappings = {
            i = {
              -- TODO: See if tabs can be used for copying and
              -- something else for multi-selection.

              -- Browse results with `<c-j/k>` like in `fzf.vim`
              ["<c-j>"] = "move_selection_next",
              ["<c-k>"] = "move_selection_previous",
              -- Browse history
              ["<c-down>"] = "cycle_history_next",
              ["<c-up>"] = "cycle_history_prev",
            },
          },
        },
        extensions = {},
      },
      dependencies = {
        -- "stevearc/aerial.nvim", -- TODO
        "nvim-lua/plenary.nvim",
        { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
      },
    },

    -- Narrow Region
    -- TODO: Create keymaps
    {
      "chrisbra/NrrwRgn", -- {{{3
      event = "VeryLazy",
    },

    -- Breadcrumb bar
    -- NOTE: Wanted 'Bekaboo/dropbar.nvim' but too many errors now. Try later.
    -- NOTE: Load after colorscheme!
    -- TODO: Disable barbeque on unfocussed windows
    -- TODO: Add mapping to toggle barbeque by window
    {
      "utilyre/barbecue.nvim", -- {{{3
      name = "barbecue",
      version = "*",
      opts = {
        theme = "tokyonight",
        -- Replace file icon with modified symbol when buffer is modified
        show_modified = true,
        -- Context text should follow its icon's color?
        context_follow_icon_color = false, -- TODO: try true
        symbols = {
          -- EXAMPLE RIGHT CHEVRONS:
          --        󰁔 󰅂 󰍟 󰮺         󰁕 󰄾 󰶻 󰨃 
          separator = "", -- default: ""
          -- TODO: use vim's modified file character here?
          -- modified = "●",
        },
      },
      dependencies = {
        "folke/tokyonight.nvim", -- for the theme
        "SmiteshP/nvim-navic",
        "nvim-tree/nvim-web-devicons",
      },
    },

    -- Search enhancer

    {
      "ggandor/flit.nvim", -- {{{3
      event = "VeryLazy",
      opts = {
        multiline = true,
      },
      dependencies = {
        "ggandor/leap.nvim",
        "tpope/vim-repeat",
      },
    },

    -- Pragmas (todo/fixme/note etc.)
    -- NOTE: `p` for pragma, like xcode pragma
    -- TODO: Toggle display in gutter
    -- TODO: Make this into a separate plugin
    {
      "folke/todo-comments.nvim", -- {{{3
      enable = true,
      event = { "BufReadPost", "BufNewFile" },
      cmd = { "TodoTelescope" },
      opts = {
        -- Hide pragma signs in gutter, until a toggling option via `yop` is
        -- available
        signs = false,
        -- Sign priority
        sign_priority = 8,
        gui_style = {
          fg = "NONE", -- The gui style to use for the fg highlight group.
          bg = "BOLD", -- The gui style to use for the bg highlight group.
        },
        -- highlighting of the line containing the todo comment
        -- * before: highlights before the keyword (typically comment characters)
        -- * keyword: highlights of the keyword
        -- * after: highlights after the keyword (todo text)
        highlight = {
          multiline = true, -- enable multine todo comments
          multiline_pattern = "^.", -- lua pattern to match the next multiline from the start of the matched keyword
          multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
          keyword = "wide_bg", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
          after = "", -- "fg" or "bg" or empty
          pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting (vim regex)
          comments_only = true, -- uses treesitter to match keywords in comments only
          max_line_len = 400, -- ignore lines longer than this
          exclude = {}, -- list of file types to exclude highlighting
        },
      },
      keys = {
        {
          "]p",
          function() require("todo-comments").jump_next() end,
          desc = "Jump to next pragma",
        },
        {
          "[p",
          function() require("todo-comments").jump_prev() end,
          desc = "Jump to previous pragma",
        },
        {
          "<space>p",
          -- default keywords
          "<cmd>TodoTelescope<cr>",
          desc = "Pragma(Todo) Telescope",
        },
        {
          "<space>P",
          -- given keywords
          "<cmd>TodoTelescope keywords=TODO,FIXME,NOTE<cr>",
          desc = "Todo/Fix/Fixme",
        },
      },
      dependencies = {
        "nvim-telescope/telescope.nvim",
      },
    },

    -- Custom text objects
    {
      "kana/vim-textobj-user", -- {{{3
      event = "VeryLazy",
    },

    -- Entire file as a text object
    -- `e`
    {
      "kana/vim-textobj-entire", -- {{{3
      event = "VeryLazy",
      dependencies = "kana/vim-textobj-user",
    },

    -- Indents as text objects
    -- `i`
    {
      "kana/vim-textobj-indent", -- {{{3
      event = "VeryLazy",
      dependencies = "kana/vim-textobj-user",
    },

    -- Parameters as text objects
    -- `,`
    {
      "sgur/vim-textobj-parameter", -- {{{3
      event = "VeryLazy",
      dependencies = "kana/vim-textobj-user",
    },

    -- Method chain members as text objects
    -- `m`
    {
      "D4KU/vim-textobj-chainmember", -- {{{3
      event = "VeryLazy",
      dependencies = "kana/vim-textobj-user",
    },

    -- Python functions/classes as text objects
    -- `f`/`c`
    {
      "bps/vim-textobj-python", -- {{{3
      ft = "python",
      dependencies = "kana/vim-textobj-user",
    },

    -- Haskell top level bindings as text objects
    -- `h`
    {
      "gilligan/vim-textobj-haskell", -- {{{3
      ft = "haskell",
      dependencies = "kana/vim-textobj-user",
    },

    -- Lua blocks as text objects
    -- `l`
    -- {"spacewander/vim-textobj-lua", -- {{{3
    --     ft = "lua",
    --     dependencies = "kana/vim-textobj-user",
    -- },

    -- Comments as text objects
    -- `c` FIXME: Collision with `bps/vim-textobj-python`'s `c`
    {
      "glts/vim-textobj-comment", -- {{{3
      event = "VeryLazy",
      dependencies = "kana/vim-textobj-user",
    },

    -- Fold areas as text objects
    -- `z`
    {
      "kana/vim-textobj-fold", -- {{{3
      event = "VeryLazy",
      dependencies = "kana/vim-textobj-user",
    },

    -- URLs as text objects
    -- `u`
    {
      "kana/vim-textobj-fold", -- {{{3
      event = "VeryLazy",
      dependencies = "kana/vim-textobj-user",
    },

    -- Elixir blocks as text objects
    -- `e` FIXME: Collision with "entire", Change to `x`?
    -- {"andyl/vim-textobj-elixir", -- {{{3
    --      ft = "elixir",
    --      dependencies = "kana/vim-textobj-user",
    -- },

    -- Disable search highlight on moving after searching
    {
      "romainl/vim-cool", -- {{{3
      event = "VeryLazy",
    },

    -- Colorful window border
    {
      "nvim-zh/colorful-winsep.nvim", -- {{{3
      config = true,
      event = { "WinNew" },
      opts = {
        -- disable for single window + NeoTree
        create_event = function()
          local win_numbers =
            require("colorful-winsep.utils").calculate_number_windows()
          if win_numbers == 2 then
            local win_id = vim.fn.win_getid(vim.fn.winnr("h"))
            local filetype = vim.api.nvim_buf_get_option(
              vim.api.nvim_win_get_buf(win_id),
              "filetype"
            )
            if filetype == "neo-tree" then
              require("colorful-winsep").NvimSeparatorDel()
            end
          end
        end,
      },
    },

    -- FIXME: Place after any vim-unimpaired preferences because I'm
    -- overriding the default `r` for `relativenumber` using in
    -- vim-unimpaired. Finda better solution to this predicament as this won't
    -- work if I'm loading "lazily".
    {
      "junegunn/rainbow_parentheses.vim", -- {{{3
      event = "VeryLazy",
      init = function()
        vim.cmd(
          "let g:rainbow#pairs = [['(', ')'], ['[', ']'], [ '{', '}'], ['<', '>']]"
        )
      end,
      keys = {
        -- Toggle rainbow parenthesis
        {
          "yor",
          "<cmd>RainbowParentheses!!<cr>",
          desc = "Toggle rainbow parenthesis",
        },
        -- Activate rainbow parenthesis
        {
          "[or",
          "<cmd>RainbowParentheses<cr>",
          desc = "Activate rainbow parenthesis",
        },
        -- Deactivate rainbow parenthesis
        {
          "]or",
          "<cmd>RainbowParentheses!<cr>",
          desc = "Deactivate rainbow parenthesis",
        },
      },
    },

    -- Find cursor
    {
      "rainbowhxch/beacon.nvim", -- {{{3
      opts = {
        enable = true,
        size = 6,
        fade = true,
        minimal_jump = 5,
        show_jumps = true,
        focus_gained = false, -- TODO: Consider enabling.
        shrink = true,
        timeout = 200,
        -- ignore_buffers = {},
        ignore_filetypes = {
          "NvimTree",
          "fugitive",
          "TelescopePrompt",
          "TelescopeResult",
        },
      },
    },

    -- Strip trailing whitespace on changed lines only
    -- FIXME: TOO MANY ERRORS> FIND REPLACEMENT QUICK.
    -- NOTE: Provides command `StripTrailingWhitespace` to remove trailing whitespace
    -- in entire file as well (not just changed lines).
    -- {
    --   "axelf4/vim-strip-trailing-whitespace", -- {{{3
    --   lazy = false,
    --   -- NOTE: Plugin is sometimes not loaded when needed, so setting high priority
    --   priority = 900,
    -- },

    -- Sort lines
    -- `gs`
    -- TODO: Make a plugin `gs` that ignores comments
    {
      "christoomey/vim-sort-motion", -- {{{3
      event = "VeryLazy",
    },

    -- Title case
    -- `gz`
    {
      "christoomey/vim-titlecase", -- {{{3
      event = "VeryLazy",
    },

    -- formatters
    -- lua
    {
      "ckipp01/stylua-nvim", -- {{{3
      event = "VeryLazy",
      ft = "lua",
      -- TODO: If no local stylua present, look for a global one
      -- config = function()
      --   require("stylua-nvim").setup({ config_file = "stylua.toml" })
      -- end,
      init = function()
        local stylua_augroup =
          vim.api.nvim_create_augroup("stylua_augroup", { clear = true })

        vim.api.nvim_create_autocmd({ "BufWritePre" }, {
          desc = "Format buffer on save",
          group = stylua_augroup,
          pattern = { "*.lua" },
          callback = function() require("stylua-nvim").format_file() end,
        })

        -- Format buffer on `<localleader>f`
        vim.api.nvim_create_autocmd({ "FileType" }, {
          desc = "Format buffer on `<localleader>f`",
          group = stylua_augroup,
          pattern = { "lua" },
          command = [[ nnoremap <buffer> <localleader>f <cmd>:lua require("stylua-nvim").format_file()<cr> ]],
        })
      end,
    },

    -- Rust
    {
      "simrat39/rust-tools.nvim", -- {{{3
      opts = {
        tools = {
          inlay_hints = {
            auto = false, --default: true
            only_current_line = false,
            show_parameter_hints = false,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
          },
          hover_actions = {},
        },
        -- ---
        server = {
          standalone = false,
          on_attach = function(_, buffer_number)
            set_common_lsp_keymaps_with_buffer_number(buffer_number)

            vim.keymap.set(
              "n",
              "<c-space>",
              function()
                require("rust-tools").hover_actions.hover_actions()
              end,
              { buffer = buffer_number }
            )
            -- TODO: Keep `rust-tools` hover or my common LSP's?
            -- vim.keymap.set(
            --   "n",
            --   "gla",
            --   function()
            --     require("rust-tools").code_action_group.code_action_group()
            --   end,
            --   { buffer = buffer_number }
            -- )
          end,

          settings = {
            ["rust-analyzer"] = {
              imports = {
                granularity = {
                  group = "module",
                },
                prefix = "self",
              },
              cargo = {
                buildScripts = {
                  enable = true,
                },
              },
              procMacro = {
                enable = true,
              },
              checkOnSave = {
                command = "clippy",
              },
            },
          },
        },
      },

      dependencies = {
        "neovim/nvim-lspconfig",
        "nvim-lua/plenary.nvim",
      },
    },

    -- {
    -- TODO: Adapt the custom cargo mappings and delete this if rust-tools
    -- works fun.
    --   "rust-lang/rust.vim", -- {{{3
    --   enable = false, -- XXX
    --   event = "VeryLazy",
    --   ft = "rust",
    --   init = function()
    --     local rustlang_rustvim_augroup = vim.api.nvim_create_augroup(
    --       "rustlang_rustvim_augroup",
    --       { clear = true }
    --     )
    --     -- Leave this to LSP integration
    --     vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    --       desc = "Format buffer on save",
    --       group = rustlang_rustvim_augroup,
    --       pattern = { "*.rs" },
    --       command = [[ RustFmt ]],
    --     })
    --     -- `cargo run` (`<leader>r`)
    --     vim.api.nvim_create_autocmd({ "FileType" }, {
    --       desc = "`cargo run`",
    --       group = rustlang_rustvim_augroup,
    --       pattern = { "rust" },
    --       command = [[ nnoremap <leader>r <cmd>Crun<cr> ]],
    --     })
    --     -- `cargo run` (`<leader>cr`)
    --     vim.api.nvim_create_autocmd({ "FileType" }, {
    --       desc = "`cargo run`",
    --       group = rustlang_rustvim_augroup,
    --       pattern = { "rust" },
    --       command = [[ nnoremap <leader>cr <cmd>Crun<cr> ]],
    --     })
    --     -- `cargo build`
    --     vim.api.nvim_create_autocmd({ "FileType" }, {
    --       desc = "`cargo build`",
    --       group = rustlang_rustvim_augroup,
    --       pattern = { "rust" },
    --       command = [[ nnoremap <leader>cb <cmd>Cbuild<cr> ]],
    --     })
    --     -- `cargo test`
    --     vim.api.nvim_create_autocmd({ "FileType" }, {
    --       desc = "`cargo test`",
    --       group = rustlang_rustvim_augroup,
    --       pattern = { "rust" },
    --       command = [[ nnoremap <leader>ct <cmd>Ctest<cr> ]],
    --     })
    --     --  `cargo check`
    --     vim.api.nvim_create_autocmd({ "FileType" }, {
    --       desc = "`cargo check`",
    --       group = rustlang_rustvim_augroup,
    --       pattern = { "rust" },
    --       command = [[ nnoremap <leader>cc <cmd>Ccheck<cr> ]],
    --     })
    --   end,
    -- },

    -- Go
    -- {
    --   "ray-x/go.nvim", -- {{{3
    --   event = { "CmdlineEnter" },
    --   ft = { "go", "gomod" },
    --   build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
    --   config = function() require("go").setup() end,
    --   dependencies = { -- optional packages
    --     "ray-x/guihua.lua",
    --     "neovim/nvim-lspconfig",
    --     "nvim-treesitter/nvim-treesitter",
    --   },
    -- },
    -- {
    --   "fatih/vim-go", ---{{{3
    --   event = "VeryLazy",
    --   ft = "go",
    -- },

    -- Treesitter
    {
      "nvim-treesitter/nvim-treesitter", -- {{{3
      build = function()
        require("nvim-treesitter.install").update({ with_sync = true })
      end,
      opts = {
        -- A list of parser names, or "all" (the five listed parsers should always be installed)
        ensure_installed = {
          "lua",
          "vim",
          "vimdoc",
          "query",
          "rust",
          "go",
        },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        highlight = {
          -- Enable highlights
          enable = true,

          -- Disable for filetypes
          -- disable = { "c", "rust" },

          -- Disable if file size > 100KB
          -- disable = function(lang, buf)
          -- 	local max_filesize = 100 * 1024 -- 100 KB
          -- 	local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          -- 	if ok and stats and stats.size > max_filesize then
          -- 		return true
          -- 	end
          -- end,

          -- NOTE: Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        },
      },
    },

    -- LSP `highlight-args`
    {
      "m-demare/hlargs.nvim", -- {{{3
      opts = {},
      dependencies = {
        "nvim-treesitter/nvim-treesitter",
      },
    },

    -- Same word highlights (LSP/treesitter/regex)
    {
      "RRethy/vim-illuminate", -- {{{3
      event = { "BufReadPost", "BufNewFile" },
      cofig = function()
        require("illuminate").configure({
          -- ordered by priority:
          providers = {
            "treesitter",
            "lsp",
            -- "regex",
          },
          filetypes_denylist = {
            "dirvish",
            "fugitive",
            "alpha",
            "NvimTree",
            "packer",
            "neogitstatus",
            "Trouble",
            "lir",
            "Outline",
            "spectre_panel",
            "toggleterm",
            "DressingSelect",
            "TelescopePrompt",
          },
        })
      end,
      cmd = {
        "IlluminatePause",
        "IlluminateResume",
        "IlluminateToggle",
        "IlluminatePauseBuf",
        "IlluminateResumeBuf",
        "IlluminateToggleBuf",
      },
      keys = {},
      dependencies = {
        "nvim-treesitter/nvim-treesitter",
      },
    },

    -- LSP renamer
    -- FIXME: renamer.nvim Does not work, find alternate
    -- {
    --   "filipdutescu/renamer.nvim", -- {{{3
    --   lazy = false,
    --   branch = "master",
    --   dependencies = { { "nvim-lua/plenary.nvim" } },
    --   keys = {
    --     {
    --       "lR",
    --       '<cmd>lua require("renamer").rename()<cr>',
    --       mode = { "n", "v" },
    --       noremap = true,
    --       desc = "Do LSP rename in popup",
    --     },
    --   },
    -- },

    -- LSP loading indicator
    {
      "j-hui/fidget.nvim", -- {{{3
      lazy = false,
      config = function()
        require("fidget").setup({
          text = {
            spinner = "dots_snake", -- animation shown when tasks are ongoing
            done = "", -- character shown when all tasks are complete
            commenced = "START", -- message shown when task starts
            completed = "DONE", -- message shown when task completes
          },
          window = {
            -- anchor point: win(default)/editor
            relative = "editor",
            blend = 30, -- &winblend, ideal: 0-30
            border = "none",
          },
          fmt = {
            max_width = 60,
            task = function(task_name, message, percentage)
              return string.format(
                "%s%s:%s",
                message,
                percentage and string.format(" %s%%", percentage) or "",
                task_name
              )
            end,
          },
        })
      end,
    },

    -- LSP Code Action Menu
    -- TODO: Run within lsp-config
    -- TODO: Only activate if lsp active
    {
      "weilbith/nvim-code-action-menu", -- {{{3
      cmd = "CodeActionMenu",
      keys = {
        {
          "lA",
          "<cmd>CodeActionMenu<cr>",
          mode = { "n", "v" },
          desc = "Activate `CodeActionMenu`",
        },
      },
    },

    -- LSP reporting UI
    -- TODO: clean keymap desc
    {
      "folke/trouble.nvim", -- {{{3
      cmd = { "TroubleToggle", "Trouble" },
      opts = { use_diagnostic_signs = true },
      keys = {
        {
          "<m-x>",
          "<cmd>TroubleToggle document_diagnostics<cr>",
          desc = "Document Diagnostics (Trouble)",
        },
        {
          "<m-X>",
          "<cmd>TroubleToggle workspace_diagnostics<cr>",
          desc = "Workspace Diagnostics (Trouble)",
        },
        {
          "<m-x>l",
          "<cmd>TroubleToggle loclist<cr>",
          desc = "Location List (Trouble)",
        },
        {
          "<m-x>r",
          "<cmd>TroubleRefresh<cr>",
          desc = "Manually refresh trouble active list",
        },
        {
          "<m-x>q",
          "<cmd>TroubleToggle quickfix<cr>",
          desc = "Quickfix List (Trouble)",
        },
        {
          "[q",
          function()
            if require("trouble").is_open() then
              require("trouble").previous({
                skip_groups = true,
                jump = true,
              })
            else
              vim.cmd.cprev()
            end
          end,
          desc = "Previous trouble/quickfix item",
        },
        {
          "]q",
          function()
            if require("trouble").is_open() then
              require("trouble").next({ skip_groups = true, jump = true })
            else
              vim.cmd.cnext()
            end
          end,
          desc = "Next trouble/quickfix item",
        },
      },
    },

    -- LSP incremental renaming
    -- FIXME: Not working
    -- {
    --   "smjonas/inc-rename.nvim", -- {{{3
    --   cmd = "IncRename",
    --   keys = {
    --     {
    --       "lR",
    --       function() return ":IncRename " .. vim.fn.expand("<cword>") end,
    --       desc = "Do LSP incremental rename",
    --       expr = true,
    --     },
    --   },
    -- },

    -- LSP symbol outline listing
    -- NOTE: Choosing this over "simrat39/symbols-outline.nvim" because this
    -- is much simpler and easier on the eyes.
    {
      "stevearc/aerial.nvim", -- {{{3
      opts = {},
      keys = {
        {
          "lO",
          "<cmd>AerialToggle!<cr>",
          desc = "Toggle LSP symbol outline (aerial)",
        },
      },
      dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
      },
    },

    -- LSP Configuration
    {
      "neovim/nvim-lspconfig", -- {{{3
      event = "VeryLazy",
      init = function()
        local on_attach = function(_, bufnr) -- ignoring arg: `lsp_client`
          set_common_lsp_keymaps_with_buffer_number(bufnr)
        end

        local capabilities = require("cmp_nvim_lsp").default_capabilities(
          vim.lsp.protocol.make_client_capabilities()
        )

        -- GO:
        require("lspconfig").gopls.setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })

        -- RUST:
        -- NOTE: Using `rust-tools to handle LSP features

        -- LUA:
        require("lspconfig").lua_ls.setup({
          on_attach = on_attach,
          capabilities = capabilities,
          settings = {
            runtime = {
              -- Tell the language server we are using Neovim's Lua version
              version = "LuaJIT",
            },
            diagnostics = {
              -- Get language server to recognize the `vim` and `jit` globals
              globals = { "vim", "jit" },
            },
            workspace = {
              -- Make server aware of Neovim runtime files
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            -- Do not send telemetry data
            telemetry = {
              enable = false,
            },
            completion = {
              -- TODO: Write descriptive comment
              callSnippet = "Replace",
            },
          },
        })

        -- PYTHON:
        require("lspconfig").pyright.setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end,
    },

    -- Snippets
    {
      "L3MON4D3/LuaSnip", -- {{{3
      version = "1.*",
      -- NOTE: install jsregexp (optional!, okay to fail apparently).
      build = (not jit.os:find("Windows"))
          and "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build'; make install_jsregexp"
        or nil,
      opts = {
        history = true,
        delete_check_events = "TextChanged",
      },
      keys = {
        {
          "<tab>",
          function()
            return require("luasnip").jumpable(1)
                and "<Plug>luasnip-jump-next"
              or "<tab>"
          end,
          expr = true,
          silent = true,
          mode = "i",
        },
        {
          "<tab>",
          function() require("luasnip").jump(1) end,
          mode = "s",
        },
        {
          "<s-tab>",
          function() require("luasnip").jump(-1) end,
          mode = { "i", "s" },
        },
      },
      dependencies = {
        "rafamadriz/friendly-snippets",
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
        end,
      },
    },

    -- Completions
    {
      "hrsh7th/nvim-cmp", -- {{{3
      event = "InsertEnter",
      opts = function()
        local cmp = require("cmp")

        local common_mappings = {
          -- NOTE: Not using tabs for interference reasons

          -- Invoke completion
          ["<c-space>"] = cmp.mapping.complete(),

          -- Close completion
          -- TODO: Look for something better than `<esc>`
          ["<esc>"] = cmp.mapping.abort(),

          -- Traverse without inserting
          ["<c-j>"] = cmp.mapping.select_next_item({
            behavior = cmp.SelectBehavior.Select,
          }),
          ["<c-k>"] = cmp.mapping.select_prev_item({
            behavior = cmp.SelectBehavior.Select,
          }),

          -- Traverse docs
          ["<c-b>"] = cmp.mapping.scroll_docs(-2),
          ["<c-f>"] = cmp.mapping.scroll_docs(2),

          -- Insert selection
          -- NOTE: Set `select` to `false` to only confirm explicitly selected items.
          ["<cr>"] = cmp.mapping.confirm({
            select = true,
            behavior = cmp.ConfirmBehavior.Insert,
          }),

          --  Insert currentl selection, replacing current word.
          ["<s-cr>"] = cmp.mapping.confirm({
            select = true,
            behavior = cmp.ConfirmBehavior.Replace,
          }),
        }

        -- Command line search mode(`/`) completion
        cmp.setup.cmdline("/", {
          mapping = cmp.mapping.preset.cmdline(common_mappings),
          sources = { { name = "buffer" } },
        })
        -- Command line insert mode(`:`) completion
        cmp.setup.cmdline(":", {
          mapping = cmp.mapping.preset.cmdline(common_mappings),
          sources = cmp.config.sources({
            { name = "path", group_index = 1 },
            {
              name = "cmdline",
              group_index = 2,
              option = {
                -- Ignore manual + shell command filters
                ignore_cmds = { "Man", "!" },
              },
            },
          }),
        })

        -- General opts +
        -- Insert mode completion
        return {
          mapping = cmp.mapping.preset.insert(common_mappings),
          completion = {
            completeopt = "menu,menuone,noinsert",
          },

          snippet = {
            expand = function(args)
              require("luasnip").lsp_expand(args.body)
            end,
          },

          -- NOTE: Order assigns implicit priority
          -- TODO: Explitly Assign priority to the source
          sources = cmp.config.sources({
            {
              name = "nvim_lsp",
              group_index = 1,
            },
            {
              name = "buffer",
              keyword_length = 4,
              group_index = 2,
              max_item_count = 3,
            },
            { name = "luasnip", priority = 10 },
            { name = "cmdline" },
            { name = "nvim_lua", max_item_count = 3 }, -- Automatically in lua ft only
            { name = "path" },
          }),

          -- formatting = {
          --   format = function(_, item)
          --     local icons = require("lazyvim.config").icons.kinds
          --     if icons[item.kind] then
          --       item.kind = icons[item.kind] .. item.kind
          --     end
          --     return item
          --   end,
          -- },

          formatting = {
            format = require("lspkind").cmp_format({
              -- mode: 'text', 'text_symbol', 'symbol_text', 'symbol'
              mode = "symbol_text",
              -- max character length
              maxwidth = 50,
            }),
          },

          experimental = {
            ghost_text = {
              hl_group = "LspCodeLens",
            },
          },
        }
      end,

      dependencies = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-path",
        "saadparwaiz1/cmp_luasnip",
        "onsails/lspkind.nvim",
      },
    },
  },
  -- END LAZY {{{2
  lazy_opts
)
