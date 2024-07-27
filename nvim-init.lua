-- NVIM CONFIGURATION: {{{1
-- vim: foldmethod=marker:foldlevel=0:nofoldenable:
-- Sri Kadimisetty

-- TODO:
-- - Check if common plugin dependency `plenary` can be removed in nvim +0.10.
-- - Ensure All Keymaps Have `Desc`.
-- - Convert Vim Fucntions Into Lua Functions.
-- - Places to Occasionally Purge:
--     - `Undodir` for Sake of `Mundo.Vim`,
--     - `Viewdir` for Clearing Out Old Saved Views.
-- - Ensure All Autocmds (and Mappings) Have
-- 		a Description Field. Consider Leaving Out The
-- 		Comment for Those, to Avoid Duplication.
-- - Remove the Default `Gs` (the Sleep Thing)
-- - Use lua for all functions
-- - Whitespace removal:
--     - Changed lines only
-- - Command with more options e.g. entire-file/changed-lines/tabs>spaces etc.
-- - something akin to `airline_mode_map`, which allows changing the symbols
-- for mode indicators. Refer to my shortcuts in my vimrc.
-- During unimpaired style movements, for e.g. `]s` to go to next spelling
-- mistake, it would not work if `spell`(`yos`) was disabled. However, make it
-- automatically turn `spell` on and jump to next/previous spelling mistake.
-- Extrapolate that to other similar unimpaired-style mappings

-- NOTE:
-- Keymap Grammar:
--  +------------------+--------------------------------+
--  | LEADERS          | SCOPE                          |
--  +------------------+--------------------------------+
--  |                  |                                |
--  | `<leader>x`      | Global actions                 |
--  | `<localleader>x` | Buffer actions                 |
--  | `gx`             | Auxiliary actions              |
--  |                  |                                |
--  | `<space>x`       | Search(Telescope)              |
--  |                  |                                |
--  | `<c-w>x`         | Windows                        |
--  | `<c-w>X`         | Tabs                           |
--  |                  |                                |
--  | `<m-x>`/`<m-X>`  | Overlays                       |
--  | `<c-x>`          | Actions                        |
--  |                  |                                |
--  | `,x`             | LSP?                           |
--  | `lx`             | LSP?                           |
--  | `<c-m-x>`        | LSP?                           |
--  |                  |                                |
--  | `dx`/`yod`/`[d`  | Diagnostics?                   |
--  |                  |                                |
--  | `<c-m-x>`        | jump to keyboard `x` position? |
--  |                  |                                |
--  | `yox`            | Toggle x                       |
--  | `]ox`            | Enable x                       |
--  | `[ox`            | Disable x                      |
--  | `]x`             | Do/go-to next x                |
--  | `[x`             | Do/go-to previous x            |
--  |                  |                                |
--  +------------------+--------------------------------+

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
  "menu", -- show popup menu for completions
  "menuone", -- show even for only one available completion
  "preview", -- show extra meta info in preview window
  "noinsert", -- TODO: don't insert any text unless user selects one
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
  "block", -- blockwise movements `(`, `{`, `[[`, `[{`, etc.
  "insert", -- insert mode commands
  "mark", -- jumping to marks etc. like `'m`, via `CTRL-O` etc.
  "percent", -- `%`
  "quickfix", -- :cn`, `:crew`, `:make`, etc.
  "search", -- triggering search patterns
  "tag", -- tag jumps like `:ta`, `CTRL-T` etc.
  "undo", -- undo or redo
  "hor", -- horizontal movement like `l`,`w`, `fx` etc.
  -- "jump", -- far jumps like `G`, `gg` etc.
  -- `all`    -- everything
}

-- INDENTS {{{2
-- Use same indentation of current line when creating new line
vim.opt.autoindent = true

-- Use C's indenting rules
vim.opt.cindent = true

-- Insert blanks according to listed shiftwidth/tabstop/softtabstop
vim.opt.smarttab = true

-- Use appropriate number of spaces to insert a tab with autodindent on
vim.opt.expandtab = true

-- FILETYPE {{{2
-- Enable filetype detection
vim.cmd([[ filetype on ]])
-- Activate builtin filetypes' plugins
vim.cmd([[ filetype plugin on ]])
-- Activate builtin and computed indentations
vim.cmd([[ filetype indent on ]])

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
vim.opt.textwidth = 79

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
-- vim.opt.cmdheight = 1

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
vim.opt.cursorline = true
vim.opt.cursorcolumn = false

-- Position newly split windows to below
vim.opt.splitbelow = true

-- Position newly split windows to right
vim.opt.splitright = true

-- Show ellipsis on a soft break
vim.opt.showbreak = [[…]]

-- Jump to the last known valid cursor position {{{2
local jump_to_last_known_cursor_position_augroup =
  vim.api.nvim_create_augroup("jump_to_last_known_cursor_position", {})

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
vim.opt.tabstop = 2

-- Number of spaces `<Tab>` counts for while editing.
-- Example: Inserting `<Tab>` or using `<BS>`
vim.opt.softtabstop = 2

-- Number of spaces to use for each step of (auto)indent.
-- (When zero the 'ts' value will be used.)
vim.opt.shiftwidth = 2

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
  vim.api.nvim_create_augroup("whitespace_preferences", {})
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
-- NOTE:: `printoptions` are now obsolete in neovim
-- vim.o.printoptions = "header:0,duplex:long,paper:A4"

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
-- MARKDOWN {{{2
-- Enable fiolding in markdown
-- local markdown_augroup =
--     vim.api.nvim_create_augroup("markdown_augroup", {  })
--
-- vim.api.nvim_create_autocmd({ "FileType" }, {
--   group   = markdown_augroup,
--   pattern = { "markdown" },
--   command = [[let g:markdown_folding = 1]],
--   desc    = "Enable markdown folding",
-- })

-- XML {{{2
-- TODO: Convert to lua api.
-- FIXME: Remove hardcoded `ttx`
-- NOTE: Most of these are to do with helping with folding in XML
-- NOTE: vim provides built-in support for xml folding, see `:help xml-folding`
vim.cmd([[
  augroup XML
      autocmd!
      autocmd FileType xml,ttx let g:xml_syntax_folding=1
      autocmd FileType xml,ttx setlocal foldmethod=syntax
      autocmd FileType xml,ttx :syntax on
      autocmd FileType xml,ttx :%foldopen!
  augroup END
]])

-- ELM {{{2
local elm_augroup = vim.api.nvim_create_augroup("elm_augroup", {})

-- Abbreviates `::` into `:` as it is a common typo in elm.
-- TODO: Replace `<buffer>` with lua equivalent`
vim.api.nvim_create_autocmd({ "FileType" }, {
  desc = "Abbreviates `::` into `:` as it is a common typo in elm.",
  group = elm_augroup,
  pattern = { "elm" },
  command = [[ abbreviate <buffer> :: : ]],
})

-- Insert module header when creating new elm file
vim.api.nvim_create_autocmd({ "BufNewFile" }, {
  desc = "Insert module header when creating new elm file",
  group = elm_augroup,
  pattern = { "*.elm" },
  callback = function()
    local content
    local module_name = vim.fn.expand("%:t:r")
    if module_name == "Main" then
      content = {
        "module Main exposing (main)",
        "",
        "import Browser",
        "import Html exposing (..)",
        "",
        "",
        "",
        "--MAIN",
      }
    else
      content = {
        "module " .. module_name .. " exposing (..)",
        "",
        "",
      }
    end
    -- NOTE: using last_line_index as 0 sets cursor at end of added lines
    -- which is where I want the cursor to be.
    vim.api.nvim_buf_set_lines(0, 0, 0, false, content)
  end,
})

-- HASKELL {{{2
-- COMMON HASKELL {{{3
local haskell_augroup = vim.api.nvim_create_augroup("haskell_augroup", {})

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
vim.api.nvim_create_autocmd({ "BufNewFile" }, {
  desc = "Insert module header when creating new haskell file",
  group = haskell_augroup,
  pattern = { "*.hs" },
  callback = function()
    local content
    local module_name = vim.fn.expand("%:t:r")
    if module_name == "Main" then
      content = {
        "module Main (main) where",
        "",
        "",
      }
    else
      content = {
        "module " .. module_name .. " exposing (..)",
        "",
        "",
      }
    end
    -- NOTE: using last_line_index as 0 sets cursor at end of added lines
    -- which is where I want the cursor to be.
    vim.api.nvim_buf_set_lines(0, 0, 0, false, content)
  end,
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

-- Add `undefined` stub to function with type signature under cursor
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = haskell_augroup,
  pattern = { "haskell" },
  callback = function()
    vim.keymap.set("n", "<localleader>u", function()
      -- Do nothing if current line is blank
      local function_name = vim.fn.split(vim.api.nvim_get_current_line())[1]
      if function_name ~= nil then
        -- Grab the function name and
        -- add an undefined stub on a new following line
        local current_line_number = vim.fn.line(".")
        local save_indentation = vim.fn.indent(current_line_number)
        local indentation_spaces = string.rep(" ", save_indentation)
        local content = indentation_spaces .. function_name .. " = undefined"
        vim.api.nvim_buf_set_lines(
          0,
          current_line_number,
          current_line_number,
          false,
          { content }
        )
      end
    end, {
      buffer = true,
      desc = "Add `undefined` stub to function with type signature under cursor",
    })
  end,
})

-- HASKELL STACK {{{3
-- TODO
vim.cmd([[
]])

-- HASKELL HELPERS {{{3

-- RUST {{{2
local rust_augroup = vim.api.nvim_create_augroup("rust_augroup", {})

-- Set `formatprg` to `rustfmt`
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = rust_augroup,
  pattern = { "rust" },
  command = [[ setlocal formatprg=rustfmt ]],
  desc = "Set `formatprg` to `rustfmt`",
})

-- GITCONFIG {{{2
local gitconfig_augroup = vim.api.nvim_create_augroup("gitconfig_augroup", {})

-- Set `gitconfig` specific settings
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  group = gitconfig_augroup,
  pattern = { "gitconfig" },
  callback = function()
    vim.opt_local.filetype = "gitconfig"
    vim.opt_local.commentstring = "# %s"
    vim.opt_local.expandtab = false
    vim.opt_local.tabstop = 4
    -- NOTE: Set `softtabstop` and `shiftwidth` to `0` to use `tabstop`'s value
    vim.opt_local.softtabstop = 0
    vim.opt_local.shiftwidth = 0
  end,
  desc = "Set gitconfig specific settings",
})

-- ELIXIR/PHOENIX {{{2
local elixir_augroup = vim.api.nvim_create_augroup("elixir_augroup", {})

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
  vim.api.nvim_create_augroup("elixir_toggles_augroup", {})

-- Toggle trailing comma on current line
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = elixir_toggles_augroup,
  pattern = { "elixir" },
  command = [[ nnoremap <buffer> <localleader>, <cmd>call ToggleTrailingStringOnLine(",", line("."))<cr> ]],
  desc = "Toggle trailing colon on current line",
})

-- Toggle leading `_` on current word
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = elixir_toggles_augroup,
  pattern = { "elixir" },
  command = [[ nnoremap <buffer> <localleader>_ <cmd>call ToggleLeadingUnderscoreOnWordUnderCursor()<cr> ]],
  desc = "Toggle leading `_` on current word",
})

-- PYTHON TOGGLES {{{2
local python_toggles_augroup =
  vim.api.nvim_create_augroup("python_toggles_augroup", {})

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
  vim.api.nvim_create_augroup("rust_toggles_augroup", {})

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
local terminal_augroup = vim.api.nvim_create_augroup("terminal_augroup", {})

-- Open `fish` terminal in a window within current tab
vim.keymap.set("n", "<m-t>", "<cmd>split term://fish<cr>", { silent = true })

-- Open `fish` terminal in a new tab
-- TODO: Remove hard coded `fish` shell reference
vim.keymap.set("n", "<m-T>", "<cmd>tabnew term://fish<cr>", { silent = true })

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
-- TODO: Refactor to remove `gcmt/taboo.vim` plugin!
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
vim.keymap.set("n", "<c-w>g<s-right>", "<cmd>tabmove<cr>", { silent = true })
vim.keymap.set("n", "g<c-w><s-right>", "<cmd>tabmove<cr>", { silent = true })
vim.keymap.set("n", "<c-w>g<s-left>", "<cmd>tabmove 0<cr>", { silent = true })
vim.keymap.set("n", "g<c-w><s-left>", "<cmd>tabmove 0<cr>", { silent = true })

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
local utilities_augroup = vim.api.nvim_create_augroup("utilities_augroup", {})

-- XCODE SHORTCUTS PARITY {{{2
-- FORMATTING {{{3
-- NOTE: This is a custom Xcode shortcut
vim.keymap.set("n", "<c-m-d-f>", function()
  vim.lsp.buf.format({ async = false })
end, { desc = "LSP format (XCode shortcut)" })

-- COMMENTING {{{3
-- TODO: Commenting based on treesitter nodes
-- NOTE: `gc` not working unless used with `normal`
vim.keymap.set("n", "<d-/>", "<cmd>normal gcc<cr>", {
  desc = "Comment current line (XCode shortcut)",
})
-- NOTE: `normal` not working in `<cmd>` for visual mode but fine with `:<c-u>`
vim.keymap.set("v", "<d-/>", [[:<c-u>'<,'>normal gcc<cr>]], {
  desc = "Comment selection (XCode shortcut)",
})

-- IN COMMAND LINE AUTOCMOPLETE USE `UP`/`DOWN` LIKE `<c-n>`/`<c-p>` {{{2
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

-- RETAIN VISUAL SELECTION AFTER AN INDENTATION SHIFT {{{2
vim.keymap.set("v", "<", "<gv", {
  silent = true,
  desc = "Shift leftwards retaining visual selection",
})
vim.keymap.set("v", ">", ">gv", {
  silent = true,
  desc = "Shift rightwards retaining visual selection",
})

-- OPEN GITHUB REPO URL UNDER CURSOR (i.e. `USERNAME/REPO`) EXTENDING `gx` {{{2
do -- KEEP: do block to localise local functions and variables
  -- NOTE:
  -- Derives heavily from neovim's builtin implementation.
  -- Read at  `MYVIMRUNTIME/lua/vim/_defaults.lua` (nvim v0.10.0)
  local common_gx_open = function(cfile)
    local main_cmd, main_err = vim.ui.open(cfile)
    local main_retval = main_cmd and main_cmd:wait(1000) or nil
    if main_cmd and main_retval and main_retval.code ~= 0 then
      main_err = ("vim.ui.open: command %s (%d): %s"):format(
        (main_retval.code == 124 and "timeout" or "failed"),
        main_retval.code,
        vim.inspect(main_cmd.cmd)
      )
    end

    -- On failure with regular `gx`, attempt github username/reponame url
    if main_err then
      -- 1. Attempt github username/reponame url
      -- Validate github username/reponame format
      local username_repo_combo = cfile:match("[%a%d%-%.%_]*%/[%a%d%-%.%_]*")
      if username_repo_combo then
        local github_repo_url = "https://github.com/" .. username_repo_combo
        local cmd, err = vim.ui.open(github_repo_url)
        local retval = cmd and cmd:wait(1000) or nil

        -- 2. On failed open, display previous main error
        if cmd and retval and retval.code ~= 0 then
          vim.notify(main_err, vim.log.levels.ERROR)
        end
      else
        -- 2. On failed validation, display previous main error
        vim.notify(main_err, vim.log.levels.ERROR)
      end
    end
  end

  local common_gx_desc =
    "Opens filepath/URI/github-user-repo under cursor with system handler (file explorer, web browser, …)"

  vim.keymap.set("n", "gx", function()
    common_gx_open(vim.fn.expand("<cfile>"))
  end, { desc = common_gx_desc })

  vim.keymap.set({ "x" }, "gx", function()
    -- get supposed cfile split across multiple lines
    local lines = vim.fn.getregion(
      vim.fn.getpos("."),
      vim.fn.getpos("v"),
      { type = vim.fn.mode() }
    )
    -- Trim whitespace on each line and concatenate.
    local cfile_without_whitespace =
      table.concat(vim.iter(lines):map(vim.trim):totable())
    common_gx_open(cfile_without_whitespace)
  end, { desc = common_gx_desc })
end

-- YANK TO END OF LINE `Y` LIKE `C` OR `D` {{{2
vim.keymap.set("n", "Y", "y$", {
  silent = true,
  desc = "Yank to end of line",
})

-- RETURN CURSOR POSITION AFTER JOINING TWO LINES WITH `J` {{{2
-- TODO: Achieve this without polluting registers (here `z`)
vim.keymap.set("n", "J", "mzJ`z", {
  silent = true,
  desc = "Return cursor position after joining lines",
})

-- INITIALISE NEW FILES WITH CORRESPONDING SKELETON TEMPLATES {{{2
-- TODO: Use nvim specific skeleton files storage location
-- FIXME: Unlike in vim, errors if filetype doesn't have a skeleton. Use a
--        separate function to not panic when a skeleton is not present.
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = utilities_augroup,
  pattern = { "html" },
  command = [[ 0r ~/.vim/skeletons/skeleton.%:e ]],
  desc = "Initialise new files with corresponding skeleton templates",
})

-- HIGHLIGHT YANKED TEXT {{{2
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Briefly highlight yanked text",
  group = utilities_augroup,
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- LIMIT HELP PAGES TEXT WIDTH (for plugin help files) {{{2
-- TODO: Check if I meant this for 3rd part help pages, because internal help
--       is generally < 80, no
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = utilities_augroup,
  pattern = { "help" },
  command = "setlocal textwidth=78",
  desc = "Limit help pages text width",
})

-- MOVE HELP TO A NEW TAB {{{2
-- NOTE: `BufWinEnter` uses `*.txt` patterns, so just detect `help` later.
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  group = utilities_augroup,
  pattern = { "*.txt" },
  callback = function()
    if vim.bo.buftype == "help" then
      vim.cmd("wincmd T")
    end
  end,
  desc = "Move help to a new tab",
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

-- SELECT ITEM AND CLOSE QUICKFIX/LOCLIST  {{{2
vim.api.nvim_create_autocmd("FileType", {
  desc = "Select item and close quickfix/location list",
  group = utilities_augroup,
  pattern = { "qf" }, -- acts on both quickfix and loclist windows
  -- TODO: make lua an split up `cclose` and `lclose`
  command = "nnoremap <buffer> <s-cr> <cr><cmd>cclose<cr><cmd>lclose<cr>",
})

-- CLOSE FLOATING/HELPER WINDOWS (quickfix/location list etc.) {{{2
-- TODO: Add feature: also close `help` windows

local close_floating_windows = function(opts)
  -- NOTE: nvim doesn't have Vim's `popup_clear()`, so spotting "popup
  -- windows" is not straight-froward, we accomplish this by cycling through
  -- window handle lists and finding the ones with non-empty `.relative`

  -- Assert function parameters are `{ all_tabs = true|false }`
  assert(
    opts ~= nil and opts.all_tabs ~= nil and type(opts.all_tabs) == "boolean"
  )

  local window_handles
  if opts.all_tabs == true then
    -- Get floating windows in all tabs
    window_handles = vim.api.nvim_list_wins()
  else
    -- Get floating windows in current tab only
    window_handles = vim.api.nvim_tabpage_list_wins(0)
  end
  -- Cycle through those windows and close the floating ones
  for _, window_handle in ipairs(window_handles) do
    -- Spot floating windows by checking for non-empty `.relative`
    if vim.api.nvim_win_get_config(window_handle).relative ~= "" then
      vim.api.nvim_win_close(window_handle, true)
    end
  end
end

-- Close floating windows in current tab
vim.api.nvim_create_user_command("CloseFloatingWindowsInCurrentTab", function()
  close_floating_windows({ all_tabs = false })
end, { desc = "Close floating windows in current tab" })

-- Close floating windows in all tabs
vim.api.nvim_create_user_command("CloseFloatingWindowsInAllTabs", function()
  close_floating_windows({ all_tabs = true })
end, { desc = "Close floating windows in all tabs" })

-- Close all helper windows
vim.keymap.set("n", "<leader>z", function()
  vim.cmd.pclose()
  vim.cmd.lclose()
  vim.cmd.cclose()
  close_floating_windows({ all_tabs = false })
end, {
  desc = "Close all helper windows",
})

-- Close all floating/helper windows in all tabs
vim.keymap.set("n", "<leader>Z", function()
  -- Close floating windows in all tabs
  close_floating_windows({ all_tabs = true })
  -- Close helper windows in all tabs, one by one
  local store_tab = vim.api.nvim_get_current_tabpage()
  for _, t in ipairs(vim.api.nvim_list_tabpages()) do
    -- TODO: See if you can do this without switcing to each tab
    vim.api.nvim_set_current_tabpage(t)
    vim.cmd.pclose()
    vim.cmd.lclose()
    vim.cmd.cclose()
  end
  vim.api.nvim_set_current_tabpage(store_tab)
end, { desc = "Close all floating/helper windows in all tabs" })

-- Toggle quickfix window
vim.keymap.set("n", "<m-q>", function()
  local is_quickfix_open_in_current_tab = false
  for _, w in ipairs(vim.fn.getwininfo()) do
    if w.quickfix > 0 and w.tabnr == vim.api.nvim_get_current_tabpage() then
      is_quickfix_open_in_current_tab = true
    end
  end
  if is_quickfix_open_in_current_tab then
    vim.cmd.cclose()
  else
    vim.cmd.copen()
  end
end, { desc = "Toggle quickfix window" })

-- Toggle location list window
vim.keymap.set("n", "<m-l>", function()
  local is_loclist_open_in_current_tab = false
  for _, w in ipairs(vim.fn.getwininfo()) do
    if w.loclist > 0 and w.tabnr == vim.api.nvim_get_current_tabpage() then
      is_loclist_open_in_current_tab = true
    end
  end
  if is_loclist_open_in_current_tab then
    vim.cmd.lclose()
  else
    local ok, err = pcall(vim.cmd.lopen)
    if not ok then
      vim.notify(err, vim.log.levels.ERROR)
    end
  end
end, { desc = "Toggle location list" })

-- CLOSE QUICKFIX IF IT IS THE LAST WINDOW REMAINING {{{2
vim.api.nvim_create_autocmd({ "WinEnter" }, {
  desc = "Close quickfix if it is the last window left in tab",
  group = utilities_augroup,
  -- pattern = { "*" },
  callback = function()
    -- if (vim.bo.filetype == "qf") and (vim.fn.winnr("$") < 2) then -- slower
    if vim.fn.winnr("$") == 1 and vim.fn.win_gettype() == "quickfix" then
      vim.cmd.quit()
    end
  end,
})

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

-- SOURCE CURRENT LUA/VIM BUFFER {{{2
vim.api.nvim_create_autocmd("FileType", {
  desc = "Source current (lua/ex command) buffer",
  group = utilities_augroup,
  pattern = { "lua", "vim" },
  callback = function()
    vim.keymap.set(
      "n",
      "<localleader>s",
      "<cmd>source %<cr>",
      { desc = "Source current lua/vim buffer" }
    )
  end,
})

-- USE S-TAB TO DE-INDENT IN INSERT MODE {{{2
vim.cmd([[
inoremap <s-tab> <c-d>
]])

-- CUSTOMIZE HELP OUTLINE(`gO`) {{{2
-- TODO:

-- HIDE CURSORLINE IN INSERT MODE {{{2
-- TODO: If `cursorline` was on in normal mode, turn it off temporarily in insert
-- mode and return to desired `cursorline` preferece when returning to normal
-- mode. To do this, there will have to be a way to keep track of the desired
-- `cursorline` preference prior to entering insert mode
-- vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
--   group = utilities_augroup,
--   command = "set cursorline",
-- })
-- vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
--   group = utilities_augroup,
--   command = "set nocursorline",
-- })

-- RESTORE `<c-i>` TO DISTINGUISH IT FROM `<tab>` MAPPINGS {{{2
-- NOTE: `<c-i>` and `<tab>` are same in vim but, thankfully, different in nvim
-- and so allows them to be used in different mappings, however, by default,
-- remapping `<tab>` will do the same to `<c-i>` unless it's explicitly set to
-- something else, hence the following.
vim.keymap.set("n", "<c-i>", "<c-i>", {
  silent = true,
  desc = [[restore `<c-i>` to original "go to newer jump"]],
})

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
  function()
    vim.bo.modifiable = true
  end,
  { silent = true }
)
-- Turn off modifiable on current buffer
vim.keymap.set(
  "n",
  "[om",
  -- "<cmd>setlocal nomodifiable<cr>",
  function()
    vim.bo.modifiable = false
  end,
  { silent = true }
)
-- Toggle modifiable on current buffer
vim.keymap.set("n", "yom", function()
  vim.bo.modifiable = not vim.bo.modifiable
end, { silent = true })

-- LINE MOVING UTILITIES {{{2
-- LEGEND:
--  1. Push(v): Move current line/segment over above/below line etc.
--  2. Smush(v): Merge current line/segment into above/below line etc.
--  3. Duplicate(v): Duplicate line/segment into above/below current line etc.
--  5. Deletion(v) (Send to blackhole): Delete current line/segment
--  4. Split/Segment(n): Segment of current line to left/right of cursor
--
-- TODO:
--  1. Visual block smushes
--      a. Merge first line of visual block(trailing) into line above visual block(leading)
--      b. Merge bottom line of visual block(leading) with line below visual block(trailing)
--      c. Merge(smush) into itself.
--  2. Move selection with `{` and `}` actions etc.
--  3. Choose which end(leading/trailing) of target line to smush into.
--  5. Stop using marks to store positions.
--  6. Re-consisder indenting when putting content on new lines i.e. try to not
--     use visual mode if possible, e.g. on single lines.
--  7. Choose naming preference between line splits and segments.
--  8. Add another modifier (say prepending with `g`) to pick between
--     indent/noo=indentation afterwards .e.g. on newly added lines
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

-- LINE DELETIONS/PASTES {{{3
-- NOTE: Line/segment deletion/pasting should feel like sending/getting the
-- text to/from somewhere high-above/deep-below, hence the up/down mnemonic.
-- TODO:
-- Picking an appropriate register to paste froa:
--    1. `0`/1` - Unnamed registers
--    2. `"`    - Last yank/.deleted/changed text. this is the current choice
--       because it includes deletions inside current line.
-- FULL LINE DELETION
-- TODO:
--  RE-CONSIDER: With segments, pastes can do one of the following:
--    1. Paste over the rest of the line. Currently doing this.
--    2. Insert right after cursor without removing rest of the line.
vim.keymap.set("n", "<c-s-m-up>", "dd", { desc = "Delete current line" })
-- FULL LINE PASTE
vim.keymap.set(
  "n",
  "<c-s-m-down>",
  [[<cmd>put! "<cr>==]],
  { desc = "Paste last yank (reg 0) above current line" }
)

-- LINE SEGMENT DELETIONS/PASTES {{{4
-- INCLUDING LETTER AT CURSOR {{{5
-- DELETIONS {{{6
vim.keymap.set("n", "<m-s-right><c-s-m-up>", "D", {
  desc = "Delete line segment from cursor to end of line",
})
vim.keymap.set(
  "n",
  "<m-s-left><c-s-m-up>",
  -- Attempt leaving leading whitespace(i.e. indentation) out of yank
  [[d^]],
  {
    desc = "Delete line segment from cursor to beginning of line",
  }
)
-- PASTES {{{6
vim.keymap.set("n", "<m-s-right><c-s-m-down>", [[hmzlvg_""p`zl]], {
  desc = "Paste over line segment from cursor to end of line",
})
vim.keymap.set(
  "n",
  "<m-s-left><c-s-m-down>",
  -- Attempt leaving leading whitespace(i.e. indentation) out of yank
  [[v^""p]],
  {
    desc = "Paste over line segment from cursor to beginning of line",
  }
)

-- NOT INCLUDING LETTER AT CURSOR {{{5
-- DELETION {{{6
vim.keymap.set("n", "<m-right><c-s-m-up>", "lD", {
  desc = "Delete line segment from right after cursor to end of line",
})
vim.keymap.set(
  "n",
  "<m-left><c-s-m-up>",
  [[d^]], -- leaving indentation (leading whitespace) alone
  {
    desc = "Delete line segment from right before cursor to beginning of line",
  }
)
-- PASTES {{{6
vim.keymap.set("n", "<m-right><c-s-m-down>", [[mzlvg_""p`z]], {
  desc = "Paste over line segment from right after cursor to end of line",
})
vim.keymap.set("n", "<m-left><c-s-m-down>", [[hv^""p]], {
  desc = "Paste over line segment from right before cursor to beginning of line",
})

-- LINE DUPLICATIONS {{{3
-- FULL LINE DUPLICATIONS {{{4
-- TODO:
-- 1. Allow multiple lines(esp. remember original position to get back to)
-- 3. Consider: After first duplication, continuing to hold `c-m` but
--    "retapping" direction keys should just move like with `m-`direction)?
--    or keep dpoing current behavior of duplicating another line
vim.keymap.set(
  "n",
  "<c-m-up>",
  "mzyyP`zk",
  { desc = "Duplicate current line upwards" }
)
vim.keymap.set(
  "n",
  "<c-m-down>",
  "mzyyp`zj",
  { desc = "Duplicate current line downwards" }
)
-- LINE SEGMENT DUPLICATIONS {{{4
-- INCLUDING LETTER AT CURSOR {{{5
vim.keymap.set("n", "<m-s-right><c-m-up>", "mzy$O<esc>p==`z", {
  desc = "Duplicate line segment from cursor to end of line, upwards",
})
vim.keymap.set("n", "<m-s-right><c-m-down>", "mzy$o<esc>p==`z", {
  desc = "Duplicate line segment from cursor to end of line, downwards",
})
vim.keymap.set("n", "<m-s-left><c-m-up>", "mzly0O<esc>p==`z", {
  desc = "Duplicate line segment from cursor to beginning of line, upwards",
})
vim.keymap.set("n", "<m-s-left><c-m-down>", "mzly0o<esc>p==`z", {
  desc = "Duplicate line segment from cursor to beginning of line, downwards",
})
-- NOT INCLUDING LETTER AT CURSOR {{{5
vim.keymap.set("n", "<m-right><c-m-up>", "mzly$O<esc>p==`z", {
  desc = "Duplicate line segment right after cursor to end of line, upwards",
})
vim.keymap.set("n", "<m-right><c-m-down>", "mzly$o<esc>p==`z", {
  desc = "Duplicate line segment right after cursor to end of line, downwards",
})
vim.keymap.set("n", "<m-left><c-m-up>", "mzy0O<esc>p==`z", {
  desc = "Duplicate line segment right before cursor to beginning of line, upwards",
})
vim.keymap.set("n", "<m-left><c-m-down>", "mzy0o<esc>p==`z", {
  desc = "Duplicate line segment right before cursor to beginning of line, downwards",
})

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
-- Toggle gutter (sign column)
vim.keymap.set(
  "n",
  "yog",
  -- "<cmd>call ToggleSignColumn()<cr>",
  function()
    -- TODO: When enabling `signcolumn`, this function uses `yes` instead of
    -- `auto`, use if that is acceptable. Get previous value of signcolumn or
    -- the global value and consider restoring from that instead.
    if vim.wo.signcolumn ~= "no" then
      vim.wo.signcolumn = "no"
    else
      vim.wo.signcolumn = "yes"
    end
  end,
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
vim.keymap.set("n", "[og", "<cmd>setlocal signcolumn=no<cr>", { silent = true })
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
vim.keymap.set("n", "<leader>v", "<cmd>edit $MYVIMRC<cr>", { silent = true })

-- PRINT/INSPECT HELPER {{{2
P = function(...)
  print(vim.inspect(...))
end

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

-- GENERAL LSP & DIAGNOSTICS SETTINGS {{{1
-- LSP SIGN SYMBOLS {{{2
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

-- LSP KEYMAPS (Uses buffer) {{{2
local set_common_lsp_keymaps = function(bufnr)
  do
    local desc = "Go to symbol definition"
    local f = vim.lsp.buf.definition
    vim.keymap.set("n", ",d", f, { desc = desc, buffer = bufnr })
    vim.api.nvim_buf_create_user_command(
      bufnr,
      "LSPGoToSymbolDefinition",
      f,
      { desc = desc }
    )
  end
  do
    local desc = "Go to symbol declaration"
    local f = vim.lsp.buf.declaration
    vim.keymap.set("n", ",D", f, { desc = desc, buffer = bufnr })
    vim.api.nvim_buf_create_user_command(
      bufnr,
      "LSPGoToSymbolDeclaration",
      f,
      { desc = desc }
    )
  end
  do
    local desc = "Rename symbol"
    local f = function()
      vim.lsp.buf.rename()
    end
    vim.keymap.set("n", ",r", f, { desc = desc, buffer = bufnr })
    vim.api.nvim_buf_create_user_command(
      bufnr,
      "LSPRenameSymbol",
      f,
      { desc = desc }
    )
  end
  do
    local desc = "Show symbol hover information in floating window"
    local f = vim.lsp.buf.hover
    vim.keymap.set("n", ",k", f, { desc = desc, buffer = bufnr })
    vim.api.nvim_buf_create_user_command(
      bufnr,
      "LSPShowSymbolHover",
      f,
      { desc = desc }
    )
  end
  do
    local desc = "Show symbol implementations in quickfix"
    local f = vim.lsp.buf.implementation
    vim.keymap.set("n", "g,i", f, { desc = desc, buffer = bufnr })
    vim.api.nvim_buf_create_user_command(
      bufnr,
      "LSPShowSymbolImplementaionsInQuickFix",
      f,
      { desc = desc }
    )
  end
  do
    local desc = "Show symbol incoming calls in quickfix"
    local f = vim.lsp.buf.incoming_calls
    vim.keymap.set("n", "g,c", f, { desc = desc, buffer = bufnr })
    vim.api.nvim_buf_create_user_command(
      bufnr,
      "LSPShowSymbolIncomingCallsInQuickFix",
      f,
      { desc = desc }
    )
  end
  do
    local desc = "Show symbol outgoing calls in quickfix"
    local f = vim.lsp.buf.outgoing_calls
    vim.keymap.set("n", "g,o", f, { desc = desc, buffer = bufnr })
    vim.api.nvim_buf_create_user_command(
      bufnr,
      "LSPShowSymbolOutgoingCallsInQuickFix",
      f,
      { desc = desc }
    )
  end
  do
    local desc = "Show current buffer symbols in quickfix"
    local f = vim.lsp.buf.document_symbol
    vim.keymap.set("n", "g,s", f, { desc = desc, buffer = bufnr })
    vim.api.nvim_buf_create_user_command(
      bufnr,
      "LSPShowSymbolsInCurrentBufferInQuickFix",
      f,
      { desc = desc }
    )
  end
  do
    local desc = "Show current workspace symbols in quickfix"
    local f = vim.lsp.buf.workspace_symbol
    vim.keymap.set("n", "g,S", f, { desc = desc, buffer = bufnr })
    vim.api.nvim_buf_create_user_command(
      bufnr,
      "LSPShowSymbolsInCurrentWorkspaceInQuickFix",
      f,
      { desc = desc }
    )
  end
  do
    local desc = "Go to type of symbol definition"
    local f = vim.lsp.buf.type_definition
    vim.keymap.set("n", ",t", f, { desc = desc, buffer = bufnr })
    vim.api.nvim_buf_create_user_command(
      bufnr,
      "LSPGoToTypeOfSymbolDefinition",
      f,
      { desc = desc }
    )
  end
  do
    local desc = "Select code action available at cursor position"
    local f = vim.lsp.buf.code_action
    vim.keymap.set({ "n", "v" }, ",a", f, { desc = desc, buffer = bufnr })
    vim.api.nvim_buf_create_user_command(
      bufnr,
      "LSPSelectCodeAction",
      f,
      { desc = desc }
    )
  end
  do
    local desc = "Show symbol references in the quickfix window"
    local f = vim.lsp.buf.references
    -- TODO: Change keymap
    vim.keymap.set("n", "g,r", f, { desc = desc, buffer = bufnr })
    vim.api.nvim_buf_create_user_command(
      bufnr,
      "LSPShowSymbolReferencesInQuickFix",
      f,
      { desc = desc }
    )
  end
  do -- WORKSPACE RELATED:
    vim.api.nvim_buf_create_user_command(
      bufnr,
      "LSPShowWorkspaceFolders",
      -- TODO: Print this better
      function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end,
      { desc = "Show workspace folders" }
    )
    vim.api.nvim_buf_create_user_command(
      bufnr,
      "LSPAddFolderAtPathToWorkspaceFolders",
      vim.lsp.buf.add_workspace_folder,
      { desc = "Add folder at path to workspace folders" }
    )
    vim.api.nvim_buf_create_user_command(
      bufnr,
      "LSPRemoveFolderAtPathFromWorkspaceFolders",
      vim.lsp.buf.remove_workspace_folder,
      { desc = "Remove folder at path from workspace folders" }
    )
  end
end

-- LSP TOGGLING KEYMAPS {{{2
-- TODO: Consider activating these keymaps based on events rather than from,
-- being called via this function
local set_common_lsp_toggling_keymaps = function()
  -- Add keymap and command to start/stop/toggle LSP (lspconfig)
  local toggle_lspconfig_lsp = function()
    -- TODO: Check if can receive `client`via argument from `common_on_attach`
    -- rather than getting all active clients again here
    local active_clients = vim.lsp.get_active_clients()
    if vim.tbl_isempty(active_clients) then
      vim.cmd([[LspStart]])
      print("Starting LSP (lspconfig)")
    else
      vim.cmd([[LspStop]])
      local display_message = "Stopping LSP (lspconfig)"
      for _, c in ipairs(active_clients) do
        display_message = display_message .. " : " .. c.name
      end
      print(display_message)
    end
  end
  vim.keymap.set(
    "n",
    "yo,",
    toggle_lspconfig_lsp,
    { desc = "Toggle LSP (lspconfig)" }
  )
  vim.api.nvim_create_user_command(
    "ToggleLSPConfig",
    toggle_lspconfig_lsp,
    { desc = "Toggle LSP (lspconfig)" }
  )
  vim.keymap.set("n", "[o,", function()
    vim.cmd([[LspStart]])
    print("Starting LSP (lspconfig)")
  end, { desc = "Start LSP (lspconfig)" })
  vim.api.nvim_create_user_command("StartLSPConfig", function()
    vim.cmd([[LspStart]])
    print("Starting LSP (lspconfig)")
  end, { desc = "Start LSP (lspconfig)" })
  vim.keymap.set("n", "]o,", function()
    vim.cmd([[LspStop]])
    print("Stopping LSP (lspconfig)")
  end, { desc = "Stop LSP (lspconfig)" })
  vim.api.nvim_create_user_command("StopLSPConfig", function()
    vim.cmd([[LspStop]])
    print("Stopping LSP (lspconfig)")
  end, { desc = "Stop LSP (lspconfig)" })
end

-- LSP FORMATTING {{{2
local set_common_lsp_formatting = function(opts)
  -- NOTE:
  -- 1. PREFER SYNC FORMATTING
  --  REASON: https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Formatting-on-save#async-formatting
  -- 2. RECOMMENDED KEYMAPPING CONVENTION:
  --  Lf   : sync format    (primary e.g. via lspconfig)
  --  Glf  : async format   (primary e.g. via lspconfig)
  --  LF   : sync format    (secondary e.g. null-ls)
  --  GlF  : async format   (secondary e.g. null-ls)
  --
  -- opts: {
  --  bufnr: bufnr,
  --  desired_client_name : string/nil,
  --  sync_format_keymap: string,
  --  async_format_keymap: string,
  --  sync_format_on_save: bool,
  --  async_format_on_save: bool,
  -- }
  assert(
    opts.bufnr ~= nil
      and type(opts.bufnr) == "number"
      and opts.sync_format_keymap ~= nil
      and type(opts.sync_format_keymap) == "string"
      and opts.async_format_keymap ~= nil
      and type(opts.sync_format_keymap) == "string"
      and opts.sync_format_on_save ~= nil
      and type(opts.sync_format_on_save) == "boolean"
      and opts.async_format_on_save ~= nil
      and type(opts.async_format_on_save) == "boolean"
  )
  if opts.desired_client_name ~= nil then
    assert(type(opts.desired_client_name) == "string")
  end

  local filter_function = function(client)
    -- TODO: Shorten this condition
    if opts.desired_client_name ~= nil then
      return opts.desired_client_name == client.name
    else
      return true
    end
  end

  -- SYNC FORMAT
  do
    local desc = "LSP Sync Format"
    local f = function()
      vim.lsp.buf.format({ async = false, filter = filter_function })
    end
    vim.keymap.set(
      "n",
      opts.sync_format_keymap,
      f,
      { desc = desc, buffer = opts.bufnr }
    )
    vim.api.nvim_buf_create_user_command(
      opts.bufnr,
      "LSPSyncFormat",
      f,
      { desc = desc }
    )

    if opts.sync_format_on_save then
      local lsp_sync_formatting_augroup =
        vim.api.nvim_create_augroup("lsp_sync_formatting_augroup", {})
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = lsp_sync_formatting_augroup,
        buffer = opts.bufnr,
        callback = f,
      })
    end
  end

  -- ASYNC FORMAT
  do
    local desc = "LSP Async Format"
    local f = function()
      vim.lsp.buf.format({ async = true, filter = filter_function })
    end
    vim.keymap.set(
      "n",
      opts.async_format_keymap,
      f,
      { desc = desc, buffer = opts.bufnr }
    )
    vim.api.nvim_buf_create_user_command(
      opts.bufnr,
      "LSPAsyncFormat",
      f,
      { desc = desc }
    )

    if opts.async_format_on_save then
      local lsp_async_formatting_augroup =
        vim.api.nvim_create_augroup("lsp_async_formatting_augroup", {})
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = lsp_async_formatting_augroup,
        buffer = opts.bufnr,
        callback = f,
      })
    end
  end
end

-- DIAGNOSTICS CONFIGURATION {{{3
local set_common_diagnostics_configuration = function()
  vim.diagnostic.config({
    virtual_text = false,
    float = {
      border = "rounded",
      prefix = " ",
      suffix = " ",
      severity_sort = true,
      close_events = { "CursorMoved", "InsertEnter" },
    },
  })
  do
    local desc = "Show diagnostics"
    local f = vim.diagnostic.open_float
    -- TODO: Options: `gd`, `<m-d>`, `ld`
    vim.keymap.set("n", "<m-,>", f, { desc = desc })
    vim.api.nvim_create_user_command("DiagnosticsShow", f, { desc = desc })
  end
  do
    local desc = "Go to previous diagnostic"
    local f = vim.diagnostic.goto_prev
    vim.keymap.set("n", "[,", f, { desc = desc })
    vim.api.nvim_create_user_command(
      "DiagnosticGoToPrevious",
      f,
      { desc = desc }
    )
  end
  do
    local desc = "Go to next diagnostic"
    local f = vim.diagnostic.goto_next
    vim.keymap.set("n", "],", f, { desc = desc })
    vim.api.nvim_create_user_command("DiagnosticsGoToNext", f, { desc = desc })
  end
  do
    local desc = "Go to previous `ERROR` diagnostic"
    local f = function()
      vim.diagnostic.goto_prev({
        severity = vim.diagnostic.severity.ERROR,
      })
    end
    vim.keymap.set("n", "[<", f, { desc = desc })
    vim.api.nvim_create_user_command(
      "DiagnosticsGoToPreviousERROR",
      f,
      { desc = desc }
    )
  end
  do
    local desc = "Go to next `ERROR` diagnostic"
    local f = function()
      vim.diagnostic.goto_next({
        severity = vim.diagnostic.severity.ERROR,
      })
    end
    vim.keymap.set("n", "]<", f, { desc = desc })
    vim.api.nvim_create_user_command(
      "DiagnosticsGoToNextERROR",
      f,
      { desc = desc }
    )
  end
  do
    local desc = "Show diagnostics in quickfix list"
    local f = vim.diagnostic.setqflist
    vim.keymap.set("n", "g,q", f, { desc = desc })
    vim.api.nvim_create_user_command(
      "DiagnosticsShowInQuickfix",
      f,
      { desc = desc }
    )
  end
  do
    local desc = "Show buffer diagnostics in location list"
    local f = vim.diagnostic.setloclist
    vim.keymap.set("n", "g,l", f, { desc = desc })
    vim.api.nvim_create_user_command(
      "DiagnosticsShowInLocationList",
      f,
      { desc = desc }
    )
  end
  do
    local desc = "Toggle diagnostics"
    local f = function()
      if vim.diagnostic.is_disabled() then
        vim.diagnostic.enable()
        print("Enabling diagnostics")
      else
        vim.diagnostic.disable()
        print("Disabling diagnostics")
      end
    end
    vim.keymap.set("n", "yo,", f, { desc = desc })
    vim.api.nvim_create_user_command("DiagnosticsToggle", f, { desc = desc })
  end
end

-- LSP & DIAGNOSTICS CONFIGURATION {{{2
local set_common_lsp_and_diagnostics_configuration = function(client, bufnr)
  -- TODO: Show signature help in a float in insert mode?
  set_common_lsp_keymaps(bufnr)
  set_common_diagnostics_configuration()
end

-- LAZY {{{1
-- LAZY SETUP {{{2
-- LAZY INSTALLATION {{{3
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
local run_lazy_setup = function(opts)
  assert(opts.lazy_plugins ~= nil and opts.lazy_opts ~= nil)
  require("lazy").setup(opts.lazy_plugins, opts.lazy_opts)
end
vim.keymap.set(
  "n",
  "<m-z>",
  "<cmd>Lazy<cr>",
  { desc = "Open `lazy.nvim` dashboard" }
)
-- LAZY ICONS {{{3
local lazy_icons = {
  dap = {
    Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
    Breakpoint = " ",
    BreakpointCondition = " ",
    BreakpointRejected = { " ", "DiagnosticError" },
    LogPoint = ".>",
  },
  diagnostics = {
    -- TODO: Extract these into common icon styledpreferences
    Error = " ",
    Warn = " ",
    Hint = " ",
    Info = " ",
  },
  git = {
    added = " ",
    modified = " ",
    removed = " ",
  },
  kinds = {
    Array = " ",
    Boolean = " ",
    Class = " ",
    Color = " ",
    Constant = " ",
    Constructor = " ",
    Copilot = " ",
    Enum = " ",
    EnumMember = " ",
    Event = " ",
    Field = " ",
    File = " ",
    Folder = " ",
    Function = " ",
    Interface = " ",
    Key = " ",
    Keyword = " ",
    Method = " ",
    Module = " ",
    Namespace = " ",
    Null = " ",
    Number = " ",
    Object = " ",
    Operator = " ",
    Package = " ",
    Property = " ",
    Reference = " ",
    Snippet = " ",
    String = " ",
    Struct = " ",
    Text = " ",
    TypeParameter = " ",
    Unit = " ",
    Value = " ",
    Variable = " ",
  },
}

run_lazy_setup({
  -- LAZY OPTIONS  {{{2
  lazy_opts = {
    ui = {
      border = "rounded",
      -- FIXME: Cannot get `custom_keys` to work
    },
  },

  -- LAZY PLUGINS {{{2
  lazy_plugins = {

    -- which key {{{3
    {
      "folke/which-key.nvim",
      event = "VeryLazy",
      opts = {
        -- NOTE: 4 plugins marks/registers/spelling/presents enabled by default
        plugins = {
          spelling = {
            suggestions = 10, --  reduce to 10 to only have numbers for triggers
          },
        },
        -- win = { no_overlap = true, -- don't allow popup to overlap cursor },
      },
      dependencies = "echasnovski/mini.icons",
    },

    -- surround {{{3
    {
      "tpope/vim-surround",
      event = "VeryLazy",
      init = function()
        -- NOTE: Do'nt use vim.keymap.set for this one.
        vim.cmd([[ vmap s S ]])
      end,
    },

    -- abolish {{{3
    {
      "tpope/tpope-vim-abolish",
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

    -- endwise {{{3
    {
      "tpope/vim-endwise",
      event = "VeryLazy",
    },

    -- eunuch {{{3
    {
      "tpope/vim-eunuch",
      event = "VeryLazy",
    },

    -- fugitive {{{3
    {
      "tpope/vim-fugitive",
      event = "VeryLazy",
    },

    -- liquid {{{3
    {
      "tpope/vim-liquid",
      event = "VeryLazy",
    },

    -- repeat {{{3
    {
      "tpope/vim-repeat",
      event = "VeryLazy",
    },

    -- rsi {{{3
    {
      "tpope/vim-rsi",
      event = "VeryLazy",
    },

    -- vinegar {{{3
    {
      "tpope/vim-vinegar",
      event = "VeryLazy",
    },

    -- oil {{{3
    {
      "stevearc/oil.nvim",
      cmd = "Oil",
      opts = {
        columns = {
          -- "mtime",
          -- "size",
          -- "permissions",
          "icon",
        },
        float = {
          padding = 2,
          max_width = 40,
          max_height = 0,
          border = "rounded",
          win_options = {
            winblend = 10,
          },
        },
        win_options = {
          cursorline = true,
        },
      },
      keys = {
        -- TODO: Check if `<esc>` can be mapped to exiting the oil window or
        -- if it is necessary in oil usage.
        {
          "<m-o>",
          "<cmd>Oil --float<cr>",
          mode = "n",
          desc = "Open Oil in floating window",
        },
        {
          "<m-O>",
          "<cmd>Oil<cr>",
          mode = "n",
          desc = "Open Oil in full window",
        },
      },
      dependencies = { "nvim-tree/nvim-web-devicons" },
    },

    -- unimpaired {{{3
    -- TODO: Find a replacement that allows choosing/changing keymaps
    {
      "tpope/vim-unimpaired",
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
        -- NOTE: `[z`/`]z` cannot be used for `[s`/`]s` because they are used
        -- to got to prev/next folds.
        { "yoz", "yos", remap = true, desc = "Toggle spell" },
        { "[oz", "[os", remap = true, desc = "Enable spell" },
        { "]oz", "]os", remap = true, desc = "Disable spell" },
      },
    },

    -- mini align {{{3
    {
      "echasnovski/mini.align",
      version = false, -- KEEP(version): as per docs
      event = "VeryLazy",
      lazy = false,
      opts = {
        mappings = {
          start = "ga",
          start_with_preview = "gA",
        },
      },
    },

    -- treesj {{{3
    {
      "Wansmer/treesj",
      event = "VeryLazy",
      cmd = {
        "TSJToggle",
        "TSJSplit",
        "TSJJoin",
      },
      -- TODO: Find easier keys, especially to toggle, preferably something
      -- like `c-*` to use it rapidly like in insert mode experience as well.
      keys = {
        -- TOGGLE ONLY COMBOS(i/n): `<c-t>`: toggle
        {
          "<c-t>",
          mode = "n",
          function()
            require("treesj").toggle()
          end,
          desc = "treesj toggle node under cursor between line/multi-line",
        },
        {
          -- NOTE: Insert mode toggling has issues with returning back to
          -- insert mode after completion.
          "<c-t>",
          mode = "i",
          function()
            require("treesj").toggle()
            vim.cmd([[
              stopinsert
              stopinsert
            ]])
            vim.cmd("startinsert")
          end,
          desc = "treesj toggle node under cursor between line/multi-line",
        },

        -- LOCALLEADER COMBOS(n): `\\tt`: toggle, `\\ts`: split, `\\tj`: join
        {
          "<localleader>tt",
          function()
            require("treesj").toggle()
          end,
          desc = "treesj toggle node under cursor between line/multi-line",
        },
        {
          "<localleader>ts",
          function()
            require("treesj").split()
          end,
          desc = "treesj split node under cursor",
        },
        {
          "<localleader>tj",
          function()
            require("treesj").join()
          end,
          desc = "treesj join node under cursor",
        },
      },
      config = function()
        require("treesj").setup({ use_default_keymaps = false })
      end,
      dependencies = { "nvim-treesitter/nvim-treesitter" },
    },

    -- highlight trailing whitespace {{{3
    "bitc/vim-bad-whitespace",

    -- strip trailing whitespace {{{3
    -- TODO: Strip inly in vcs(git) changed files
    -- NOTE: Strips trailwing whitespace on changed lines only. To strip
    -- trailwing whitespace on all lines in entire file, use command
    -- `:StripTrailingWhitespace`. Do not replace with a similar plugin,
    -- because the other's likely do not respect this behavior.
    "axelf4/vim-strip-trailing-whitespace",

    -- indent blankline {{{3
    {
      "lukas-reineke/indent-blankline.nvim",
      event = "BufEnter",
      main = "ibl",
      opts = {
        -- show_current_context = false,
        indent = {
          --  TODO: Less intense highlight
          char = "│",
        },
      },
    },

    -- emmet {{{3
    {
      "mattn/emmet-vim",
      event = "VeryLazy",
    },

    -- mini.animate {{{3
    {
      "echasnovski/mini.animate",
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
              easing = "in-out",
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

    -- mini.map {{{3
    {
      "echasnovski/mini.map",
      event = "VeryLazy",
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

        -- Disable minimap in quickfix and location list windows
        vim.api.nvim_create_autocmd("FileType", {
          desc = "Disable minimap in quickfix and location list windows",
          group = vim.api.nvim_create_augroup("minimap_augroup", {}),
          pattern = { "qf" }, -- acts on both quickfix and loclist windows
          callback = function()
            vim.b.minimap_disable = true
          end,
        })
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

    -- smartcolumn {{{3
    {
      "m4xshen/smartcolumn.nvim",
      opts = {
        -- default: {}
        -- example: { python = "80", haskell = { "80", "120"} }
        colorcolumn = { "80", "100" }, -- default: "80"
        --
        -- file: whole file (default)
        -- window: visible part of current window
        -- line: current line
        scope = "window",
        --
        -- exampledisabled_filetypes = default: { "help", "text", "markdown" }
      },
    },

    -- nvim toggler {{{3
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
          "<localleader>i", -- TODO: Find another, might have interference
          function()
            require("nvim-toggler").toggle()
          end,
          mode = { "n", "v" },
          desc = "Invert word under cursor",
        },
      },
    },

    -- tokyonight colorscheme {{{3
    {
      "folke/tokyonight.nvim",
      lazy = false, -- Load during startup if main colorscheme
      priority = 1000, -- Load before all other start plugins
      init = function()
        vim.cmd.colorscheme("tokyonight")
      end,
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

    -- lualine {{{3
    {
      "nvim-lualine/lualine.nvim",
      event = "VeryLazy",
      opts = function()
        return {
          options = {
            globalstatus = true, -- Show only one statusline for all windows
            theme = "auto",
            component_separators = { left = "", right = "" },
            section_separators = { left = "", right = "" },
            ignore_focus = {},
            always_divide_middle = true,
            disabled_filetypes = { statusline = { "alpha" } },
          },
          sections = {
            lualine_a = {
              {
                -- short mode
                function()
                  --  NOTE: vim mode codes (keys) are listed in `:help mode()`
                  local nvim_mode_code = vim.api.nvim_get_mode().mode
                  local nvim_mode_code_representations = {
                    ["n"] = "N",
                    ["no"] = "NO",
                    ["nov"] = "NOv",
                    ["noV"] = "NOV",
                    ["no\22"] = "NO^v",
                    ["niI"] = "N",
                    ["niR"] = "N",
                    ["niV"] = "N",
                    ["nt"] = "N",
                    ["ntT"] = "N",
                    ["v"] = "v",
                    ["vs"] = "v",
                    ["V"] = "V",
                    ["Vs"] = "V",
                    ["\22"] = "^v",
                    ["\22s"] = "^v",
                    ["s"] = "s",
                    ["S"] = "S",
                    ["\19"] = "S-BLOCK",
                    ["i"] = "I",
                    ["ic"] = "I",
                    ["ix"] = "I",
                    ["R"] = "R",
                    ["Rc"] = "R",
                    ["Rx"] = "R",
                    ["Rv"] = "VR",
                    ["Rvc"] = "VR",
                    ["Rvx"] = "VR",
                    ["c"] = "C",
                    ["cv"] = "EX",
                    ["ce"] = "EX",
                    ["r"] = "PROMPT",
                    ["rm"] = "MORE",
                    ["r?"] = "CONFIRM",
                    ["!"] = "!",
                    ["t"] = "TERM",
                  }
                  return vim.fn.get(
                    nvim_mode_code_representations, -- table
                    nvim_mode_code, -- index
                    nvim_mode_code -- default
                  )
                end,
                padding = { left = 1, right = 1 },
              },
            },
            lualine_b = {
              {
                "branch",
                -- icon = "" -- Ideally this would be my icon of choice
                -- NOTE: In order to hide the `main` branch and showing my icon
                -- of choice the following "hack" needs to be done:
                -- 1. Set `icon` to a blank string
                -- 2. Set `padding` to accomodate hardcoded icon
                -- 3. Define `fmt` with hardcoded icon  of choice
                icon = "",
                padding = { left = 0, right = 1 },
                fmt = function(branch_name)
                  if branch_name == "" then -- show "master"
                    -- case: `""` is no "git branch" available
                    -- returning: `nil` doesn't show this component
                    return nil
                  elseif branch_name == "main" then -- show "master"
                    -- case: `main` branch
                    -- returning: "" pretending it's just the icon
                    return ""
                  else
                    -- case: branch other than `main`
                    -- returning: " branch_name"
                    return " " .. branch_name
                  end
                end,
              },
            },
            lualine_c = {
              {
                -- NOTE: The `󰆧` icon is hardcoded in a "hackish" way to get
                -- that symbol to print before the `navic` component. Using
                -- `fmt` on `navic` is unsatisfactory as it's visible when
                -- `navic` is not displayed as well.
                component_separators = { left = "󰆧", right = "" },
                "filename",
                path = 1,
                symbols = {
                  modified = "󰐕", --      󰐕 
                  readonly = "",
                  unnamed = "NO NAME",
                },
              },
              {
                "navic",
              },
            },
            lualine_x = {
              {
                "diagnostics",
                symbols = {
                  -- TODO: Get icons from common source
                  error = "󰬌 ",
                  warn = "󰬞 ",
                  info = "󰬐 ",
                  hint = " ",
                },
              },
              "searchcount",
              "selectioncount",
              -- TODO: setup `dap` here like in  `lazy-distribution`
              {
                require("lazy.status").updates,
                cond = require("lazy.status").has_updates,
              },
              {
                "diff",
                symbols = {
                  added = lazy_icons.git.added,
                  modified = lazy_icons.git.modified,
                  removed = lazy_icons.git.removed,
                },
              },
              {
                "filetype",
                icon_only = true,
                colored = false,
                padding = { left = 0, right = 1 },
              },
            },
            lualine_y = {
              {
                "progress",
                padding = { left = 1, right = 1 },
              },
              {
                "location",
                padding = { left = 0, right = 1 },
              },
            },
            lualine_z = {},
          },
          inactive_sections = {
            lualine_a = { "filename" },
            lualine_b = {},
            lualine_c = {},
            lualine_x = {},
            lualine_y = { "bo:filetype" },
            lualine_z = { "location" },
          },
          extensions = {
            "fugitive",
            "lazy",
            "man",
            "neo-tree",
            "quickfix",
            "trouble",
            -- "nvim-dap-ui", -- UI for dap(debug adapter protocol)
            -- "overseer", -- taskrunner
            -- "symbols-outline", -- symbols tree
          },
        }
      end,
      dependencies = {
        "SmiteshP/nvim-navic",
        "folke/trouble.nvim",
        "nvim-neo-tree/neo-tree.nvim",
        "nvim-tree/nvim-web-devicons",
        "tpope/vim-fugitive",
      },
    },

    -- taboo {{{3
    {
      "gcmt/taboo.vim",
      init = function()
        vim.g.taboo_tab_format = [[ %d %f %m ]]
        vim.g.taboo_renamed_tab_format = [[ %d %l %m ]]
      end,
      dependencies = { "ryanoasis/vim-devicons" },
    },

    -- undotree {{{3
    {
      "jiaoshijie/undotree",
      config = true,
      keys = function()
        local undotree = require("undotree")
        local undotree_action = require("undotree.action")
        return {
          -- TODO: Add `<s-cr>` to update undo state and exit
          {
            "<m-u>",
            function()
              undotree.toggle()
              -- TODO: Hide this message on closing undotree
              print(
                "UNDOTREE: ",
                "j/k: ↑/↓, J/K: ↑/↓ + change state, ",
                "cr: change state, p: go to preview, q: quit"
              )
            end,
            desc = "Toggle undotree",
          },
        }
      end,
      dependencies = "nvim-lua/plenary.nvim",
    },

    -- autopairs {{{3
    {
      "windwp/nvim-autopairs",
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

    -- neo-tree {{{3
    {
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v2.x",
      -- event = "VeryLazy",
      lazy = false,
      priority = 600,
      init = function()
        -- Disable deprecated commands e.g. `:NeoTreeReveal`
        vim.g.neo_tree_remove_legacy_commands = 1
      end,
      keys = {
        -- Filesystem with current file selected
        {
          "-",
          "<cmd>Neotree action=focus source=filesystem position=left toggle=true reveal=true<cr>",
          desc = "Toggle NeoTree",
        },
        -- Git relevant files with current file selected
        {
          "_",
          "<cmd>Neotree action=focus source=git_status position=left toggle=true reveal=true<cr>",
          desc = "Toggle NeoTree",
        },
      },
      opts = {
        sources = {
          "filesystem", -- "buffers", "git_status",
        },
        open_files_do_not_replace_types = {
          "terminal",
          "Trouble",
          "qf",
          "Outline",
        },
        filesystem = {
          bind_to_cwd = false,
          hijack_netrw_behavior = "disabled",
          filtered_items = {
            hide_dotfiles = false,
            hide_hidden = false,
          },
        },
        window = {
          width = 22,
          mappings = {
            ["P"] = "noop", -- disable default: `toggle_preview`
            ["<m-p>"] = {
              "toggle_preview",
              config = { use_float = true },
            },
            ["<bs>"] = "noop", -- disable default: `navigate_up`
            ["<m-up>"] = "navigate_up",
            ["gh"] = "show_help", -- along with default: `?`
            ["S"] = "noop", -- disable default: `open_split`
            ["<c-x>"] = "open_split",
            ["s"] = "noop", -- disable default: `open_vsplit`
            ["<c-v>"] = "open_vsplit",
            ["t"] = "noop", -- disable default: `open_tabnew`
            ["<c-t>"] = "open_tabnew",
            ["H"] = "noop", -- disable default: `toggle_hidden`
            ["<c-h>"] = "toggle_hidden",
            -- ["<space>"] = "toggle_node", -- default
            -- ["<cr>"] = "open", -- default
            -- ["<s-cr>"] = TODO: open/select and then close neotree
            ["<c-cr>"] = "open_with_window_picker",
            -- instead of default: `open` do `toggle_node`
            ["z"] = "noop", -- disable default: `close_all_nodes`
            ["zc"] = "close_node", -- like in folds
            ["zM"] = "close_all_nodes", -- like in folds
            ["zR"] = "expand_all_nodes", -- like in folds
          },
        },
      },
      dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "nvim-tree/nvim-web-devicons",
        {
          -- Required in mappings using `*_window_picker`
          "s1n7ax/nvim-window-picker",
          name = "window-picker",
          event = "VeryLazy",
          version = "2.*",
          opts = {
            show_prompt = false,
            selection_chars = "1234567890QWERTYUIOP",
          },
        },
      },
    },

    -- alpha {{{3
    {
      "goolord/alpha-nvim",
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

    -- gitsigns {{{3
    {
      "lewis6991/gitsigns.nvim",
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

    -- lazygit {{{3
    {
      "kdheepak/lazygit.nvim",
      -- TODO: [Use telescope extension?](https://github.com/kdheepak/lazygit.nvim#telescope-plug)
      cmd = {
        "LazyGitCurrentFile",
        "LazyGit",
        "LazyGitFilterCurrentFile",
        "LazyGitFilter",
        "LazyGitConfig",
      },
      keys = {
        {
          "<m-g>",
          "<cmd>LazyGitCurrentFile<cr>",
          desc = "Show current buffer in lazygit",
        },
        {
          "<m-G>",
          "<cmd>LazyGit<cr>",
          desc = "Show current directory in lazygit",
        },
        {
          "g<m-g>",
          "<cmd>LazyGitFilterCurrentFile<cr>",
          desc = "Show current buffer commits in lazygit",
        },
        {
          "g<m-G>",
          "<cmd>LazyGitFilter<cr>",
          desc = "Show project commits in lazygit",
        },
      },
      dependencies = {
        "nvim-lua/plenary.nvim", -- used for border decorations
      },
    },

    -- telescope {{{3
    {
      "nvim-telescope/telescope.nvim",
      lazy = false,
      cmd = "Telescope",
      tag = "0.1.4",
      keys = {
        -- META:
        {
          "<space>m",
          "<cmd>Telescope<cr>",
          desc = "Search through telescope sources (m for meta)",
        },
        -- FILES:
        {
          "<space><space>",
          "<cmd>Telescope find_files<cr>",
          desc = "Search file names",
        },
        {
          "<space>f",
          "<cmd>Telescope current_buffer_fuzzy_find<cr>",
          desc = "Search inside current buffer",
        },
        {
          "<space>F",
          "<cmd>Telescope live_grep<cr>",
          desc = "Search inside current directory files (ripgrep)",
        },
        {
          "<space>g",
          "<cmd>Telescope git_files<cr>",
          desc = "Search git files",
        },
        {
          "<space>b",
          "<cmd>Telescope buffers<cr>",
          desc = "Search buffer names",
        },
        -- VIM FEATURES:
        {
          "<space>k",
          "<cmd>Telescope keymaps<cr>",
          desc = "Search keymaps",
        },
        {
          "<space>r",
          "<cmd>Telescope registers<cr>",
          desc = "Search registers",
        },
        {
          "<space>h",
          "<cmd>Telescope help_tags<cr>",
          desc = "Search help tags",
        },
        {
          "<space>c",
          "<cmd>Telescope commands<cr>",
          desc = "Search commands",
        },
        {
          "<space>o",
          "<cmd>Telescope vim_options<cr>",
          desc = "Search vim options",
        },
        {
          "<space>z",
          "<cmd>Telescope spell_suggest<cr>",
          desc = "Search spelling suggestions",
        },
        {
          "<space>j",
          "<cmd>Telescope jumplist<cr>",
          desc = "Search jump list",
        },
        -- {
        ---- TODO: Another mapping, using `t` for tabs
        --   "<space>t",
        --   "<cmd>Telescope current_buffer_tags<cr>",
        --   desc = "Search tags",
        -- },
        -- LSP & DIAGNOSTICS:
        {
          "<space>d",
          function()
            -- 0 for current buffer
            require("telescope.builtin").diagnostics({ bufnr = 0 })
          end,
          desc = "Search diagnostics in current buffer",
        },
        {
          "<space>D",
          -- nil for all buffers
          function()
            require("telescope.builtin").diagnostics({ bufnr = nil })
          end,
          desc = "Search diagnostics in all buffers",
        },
        -- LSP
        {
          "<space>,s",
          "<cmd>Telescope lsp_document_symbols<cr>",
          desc = "Search lsp document symbols",
        },
        {
          "<space>,S",
          "<cmd>Telescope lsp_workspace_symbols<cr>",
          desc = "Search lsp workspace symbols",
        },
        {
          "<space>,o",
          "<cmd>Telescope lsp_outgoing_calls<cr>",
          desc = "Search lsp outgoing calls",
        },
        {
          "<space>,c",
          "<cmd>Telescope lsp_incoming_calls<cr>",
          desc = "Search lsp incoming calls",
        },
        {
          "<space>,d",
          "<cmd>Telescope lsp_definitions<cr>",
          desc = "Search lsp definitions",
        },
        {
          "<space>,r",
          "<cmd>Telescope lsp_references<cr>",
          desc = "Search lsp references",
        },
        -- QUICKFIX/LOCLIST
        {
          "<space>q",
          "<cmd>Telescope quickfix<cr>",
          desc = "List quickfix items",
        },
        {
          "<space>l", -- TODO: Find a better key than `l` for lsp
          "<cmd>Telescope loclist<cr>",
          desc = "List loclist items",
        },
        -- EXTENSIONS
        {
          -- TODO: Add keymap/action to delete from arglist
          "<space>a",
          function()
            require("telescope-arglist").arglist()
          end,
          desc = "Search arglist buffers",
        },
        {
          "<space>u",
          function()
            require("telescope").extensions.undo.undo()
          end,
          desc = "Search undo history",
        },
        {
          "<space>t",
          "<cmd>Telescope tele_tabby list<cr>",
          desc = "Search undo history",
        },
      },
      opts = function()
        local actions_layout = require("telescope.actions.layout")
        local actions = require("telescope.actions")
        return {
          defaults = {
            layout_strategy = "bottom_pane",
            layout_config = {
              bottom_pane = {
                height = 14,
                preview_cutoff = 100,
                prompt_position = "bottom",
              },
            },
            scroll_strategy = "limit", -- default is `cycle`
            border = true,
            winblend = 8,
            dynamic_preview_title = true,
            results_title = false,
            color_devicons = true,
            prompt_prefix = " ",
            selection_caret = " ",
            multi_icon = " +",
            mappings = {
              -- NOTE: Restrict to insert mode only (disable normal mode here)
              i = {
                ["<esc>"] = actions.close,
                ["<m-p>"] = actions_layout.toggle_preview,
                ["<m-a>"] = actions.select_all,
                ["<m-s-a>"] = actions.drop_all,
                ["<tab>"] = actions.toggle_selection,
                ["<s-tab>"] = actions.remove_selection,
                ["<m-w>"] = actions.which_key,
                ["<c-n>"] = actions.move_selection_next,
                ["<c-p>"] = actions.move_selection_previous,
                ["<c-m-n>"] = actions.move_to_bottom,
                ["<c-m-p>"] = actions.move_to_top,
                ["<c-j>"] = actions.move_selection_next,
                ["<c-k>"] = actions.move_selection_previous,
                ["<c-m-k>"] = actions.move_to_top,
                ["<c-m-j>"] = actions.move_to_bottom,
                -- NOTE: Not doing move to top/bottom for up/down
                ["<up>"] = actions.move_selection_previous,
                ["<down>"] = actions.move_selection_next,
                ["<s-up>"] = actions.add_selection
                  + actions.move_selection_previous,
                ["<s-down>"] = actions.add_selection
                  + actions.move_selection_next,
                ["<s-m-up>"] = actions.remove_selection
                  + actions.move_selection_previous,
                ["<s-m-down>"] = actions.remove_selection
                  + actions.move_selection_next,
                ["<c-e>"] = actions.results_scrolling_up,
                ["<c-y>"] = actions.results_scrolling_down,
                ["<c-m-f>"] = actions.preview_scrolling_down,
                ["<c-m-b>"] = actions.preview_scrolling_up,
                ["<m-down>"] = actions.cycle_history_next,
                ["<m-up>"] = actions.cycle_history_prev,
                -- NOTE:Revert `<c-u>` to readline style clearing line behavior
                ["<c-u>"] = false,
                ["<c-d>"] = actions.delete_buffer,
                -- QUICKFIX AND LOCATION LISTS:
                -- NOTE: If no entry is selected, send all entries
                -- REPLACE quickfix list with selected entries
                ["<c-q>"] = actions.smart_send_to_qflist,
                -- EXTEND quickfix list with selected entries at the end
                ["<c-m-q>"] = actions.smart_add_to_qflist,
                -- REPLACE location list with selected entries
                ["<c-l>"] = actions.smart_send_to_loclist,
                -- EXTEND location list with selected entries at the end
                ["<c-m-l>"] = actions.smart_add_to_loclist,
              },
            },
          },
          config = function(_, opts)
            require("telescope").setup(opts)
            require("telescope").load_extension("arglist")
            require("telescope").load_extension("fzf")
            require("telescope").load_extension("undo")
            require("telescope").load_extension("lazy")
            require("telescope").load_extension("tele_tabby")
          end,
          extensions = {
            -- "debugloop/telescope-undo.nvim",
            undo = {
              use_delta = false, -- do not use `delta` here
              -- DEFAULT MAPPINGS:
              -- mappings = {
              -- i = {
              --   ["<cr>"] = require("telescope-undo.actions").yank_additions,
              --   ["<s-cr>"] = require("telescope-undo.actions").yank_deletions,
              --   ["<c-cr>"] = require("telescope-undo.actions").restore,
              -- },
              -- },
            },
          },
        }
      end,
      dependencies = {
        "nvim-lua/plenary.nvim",
        "tsakirist/telescope-lazy.nvim",
        "TC72/telescope-tele-tabby.nvim",
        "sam4llis/telescope-arglist.nvim",
        "debugloop/telescope-undo.nvim",
        {
          "nvim-treesitter/nvim-treesitter",
          build = ":TSUpdate",
        },
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      },
    },

    -- narrow region {{{3
    -- TODO: Create keymaps
    {
      "chrisbra/NrrwRgn",
      event = "VeryLazy",
    },

    -- barbecue {{{3
    -- NOTE: Wanted 'Bekaboo/dropbar.nvim' but it's >= 0.10.0-dev. Try later.
    {
      "utilyre/barbecue.nvim",
      name = "barbecue",
      event = "VeryLazy",
      version = "*",
      keys = {
        {
          -- NOTE: If barbecuw hasn't loaded yet, this will stall one time
          "<m-b>",
          mode = { "n", "i" },
          function()
            require("barbecue.ui").toggle()
          end,
          desc = "Toggle barbecue globally",
        },
      },
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

    -- flit {{{3
    {
      "ggandor/flit.nvim",
      event = "VeryLazy",
      opts = {
        multiline = true,
      },
      dependencies = {
        "ggandor/leap.nvim",
        "tpope/vim-repeat",
      },
    },

    -- todo comments {{{3
    -- Pragmas (todo/fixme/note etc.)
    -- NOTE: `p` for pragma, like xcode pragma
    -- TODO: Toggle display in gutter
    -- TODO: Make this into a separate plugin
    {
      "folke/todo-comments.nvim",
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
      -- TODO: Add keymaps that restrict searching for pragmas in current
      -- buffer
      keys = {
        {
          "]p",
          function()
            require("todo-comments").jump_next()
          end,
          desc = "Go to next pragma",
        },
        {
          "[p",
          function()
            require("todo-comments").jump_prev()
          end,
          desc = "Go to previous pragma",
        },
        {
          "<space>p",
          -- default keywords
          "<cmd>TodoTelescope<cr>",
          desc = "Search all pragmas in telescope",
        },
        {
          "<space>P",
          -- supplied keywords
          "<cmd>TodoTelescope keywords=TODO,NOTE,FIX,ISSUE,FIXME,NOTE,XXX<cr>",
          desc = "Search pragmas(TODO/NOTE/FIX) in telescope",
        },
      },
      dependencies = {
        "nvim-telescope/telescope.nvim",
      },
    },

    -- vim-textobj-user {{{3
    {
      "kana/vim-textobj-user",
      event = "VeryLazy",
    },

    -- vim-textobj-entire {{{3
    -- `e`
    {
      "kana/vim-textobj-entire",
      event = "VeryLazy",
      dependencies = "kana/vim-textobj-user",
    },

    -- vim-textobj-indent {{{3
    -- `i`
    {
      "kana/vim-textobj-indent",
      event = "VeryLazy",
      dependencies = "kana/vim-textobj-user",
    },

    -- vim-textobj-parameter {{{3
    -- `,`
    {
      "sgur/vim-textobj-parameter",
      event = "VeryLazy",
      dependencies = "kana/vim-textobj-user",
    },

    -- vim-textobj-chainmember {{{3
    -- `m`
    {
      "D4KU/vim-textobj-chainmember",
      event = "VeryLazy",
      dependencies = "kana/vim-textobj-user",
    },

    -- vim-textobj-python {{{3
    -- `f`/`c`
    {
      "bps/vim-textobj-python",
      ft = "python",
      dependencies = "kana/vim-textobj-user",
    },

    -- vim-textobj-lua {{{3
    -- `l`
    -- {"spacewander/vim-textobj-lua",
    --     ft = "lua",
    --     dependencies = "kana/vim-textobj-user",
    -- },

    -- vim-textobj-comment {{3
    -- `c` FIXME: Collision with `bps/vim-textobj-python`'s `c`
    {
      "glts/vim-textobj-comment",
      event = "VeryLazy",
      dependencies = "kana/vim-textobj-user",
    },

    -- vim-textobj-fold {{{3
    -- Fold areas as text objects
    -- `z`
    {
      "kana/vim-textobj-fold",
      event = "VeryLazy",
      dependencies = "kana/vim-textobj-user",
    },

    -- vim-textobj-url  {{{3
    -- `u`
    {
      "LeonB/vim-textobj-url",
      event = "VeryLazy",
      dependencies = "kana/vim-textobj-user",
    },

    -- vim-textobj-elixir {{{3
    -- `e` FIXME: Collision with "entire", Change to `x`?
    -- {"andyl/vim-textobj-elixir",
    --      ft = "elixir",
    --      dependencies = "kana/vim-textobj-user",
    -- },

    -- cool {{{3
    -- Disable search highlight on moving after searching
    {
      "romainl/vim-cool",
      event = "VeryLazy",
    },

    -- colorful-winsep {{{3
    -- Colorful window border
    {
      "nvim-zh/colorful-winsep.nvim",
      event = { "WinNew" },
      opts = {
        create_event = function()
          -- disable for single window
          local win_numbers =
            require("colorful-winsep.utils").calculate_number_windows()
          if win_numbers == 2 then
            local win_id = vim.fn.win_getid(vim.fn.winnr("h"))
            local filetype = vim.api.nvim_buf_get_option(
              vim.api.nvim_win_get_buf(win_id),
              "filetype"
            )

            -- disable for given filetypes
            local disabled_filetypes = {
              "neo-tree",
              "Trouble",
              "qf",
              -- "Mundo", "MundoDiff" -- Uses 2 windows, need special treatment
            }
            if vim.tbl_contains(disabled_filetypes, filetype) then
              require("colorful-winsep").NvimSeparatorDel()
            end
          end
        end,
      },
    },

    -- rainbow_parentheses {{{3
    -- FIXME: Place after any vim-unimpaired preferences because I'm
    -- overriding the default `r` for `relativenumber` using in
    -- vim-unimpaired. Finda better solution to this predicament as this won't
    -- work if I'm loading "lazily".
    {
      "junegunn/rainbow_parentheses.vim",
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

    -- beacon {{{3
    -- Find cursor
    {
      "rainbowhxch/beacon.nvim",
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

    -- sort motion {{{3
    -- `gs`
    -- TODO: Make a plugin `gs` that ignores comments
    {
      "christoomey/vim-sort-motion",
      event = "VeryLazy",
    },

    -- titlecase {{{3
    -- Title case
    -- `gz`
    {
      "christoomey/vim-titlecase",
      event = "VeryLazy",
    },

    -- elixir {{{3
    "elixir-editors/vim-elixir",

    -- fish {{{3
    {
      "blankname/vim-fish",
      -- NOTE: `https://github.com/dag/vim-fish` was abondoned, hence using
      -- this maintained clone
      ft = { "fish" },
      config = function()
        -- TODO: Move this out of here into a general fish setup section
        vim.cmd([[
          " Set up :make to use fish for syntax checking.
          autocmd FileType fish :compiler fish
          " Enable folding of block structures in fish.
          autocmd FileType fish setlocal foldmethod=expr
        ]])
      end,
    },

    -- purescript {{{3
    {
      "purescript-contrib/purescript-vim",
      ft = { "purescript" },
    },

    -- nushell {{{3
    "elkasztano/nushell-syntax-vim",

    -- treesitter {{{3
    {
      "nvim-treesitter/nvim-treesitter",
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

    -- treesitter playground {{{3
    -- Treesitter playground
    {
      "nvim-treesitter/playground",
      dependencies = {
        "nvim-treesitter/nvim-treesitter",
      },
    },

    -- hlargs {{{3
    -- LSP `highlight-args`
    {
      "m-demare/hlargs.nvim",
      event = "VeryLazy",
      opts = {},
      dependencies = {
        "nvim-treesitter/nvim-treesitter",
      },
    },

    -- plenary {{{3
    -- Nvim/Lua helpers (often used as a dependency as well)
    {
      "nvim-lua/plenary.nvim",
      lazy = true,
      init = function()
        -- Global function that reloads module fresh, even if it were already
        -- required and cached
        R = function(x)
          require("plenary.reload").reload_module(x)
          return require(x)
        end
      end,
    },

    -- illuminate {{{3
    -- Same word highlights (LSP/treesitter/regex)
    {
      "RRethy/vim-illuminate",
      event = { "BufReadPost", "BufNewFile" },
      config = function()
        require("illuminate").configure({
          -- ordered by priority:
          providers = {
            "treesitter",
            "lsp",
            "regex",
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

    -- dressing {{{3
    -- Better vim ui
    {
      "stevearc/dressing.nvim",
      event = "VeryLazy",
    },

    -- fidget {{{3
    -- LSP loading indicator
    {
      "j-hui/fidget.nvim",
      tag = "legacy", -- TODO: Remove when fidget is eventually updated
      lazy = false,
      config = function()
        require("fidget").setup({
          text = {
            spinner = "dots_snake",
            done = "",
            commenced = "", -- "DOING"
            completed = "", -- "DONE"
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

    -- nvim-code-action-menu {{{3
    -- TODO: Run within lsp-config
    -- TODO: Only activate if lsp active
    {
      "weilbith/nvim-code-action-menu",
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

    -- qf-edit {{{3
    -- Edit quickfix list like a normal buffer
    {
      "itchyny/vim-qfedit",
      ft = "qf",
    },

    -- trouble {{{3
    -- LSP reporting UI
    -- TODO: clean keymap desc
    {
      "folke/trouble.nvim",
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

    -- aerial {{{3
    -- LSP symbol outline listing
    -- NOTE: Choosing this over "simrat39/symbols-outline.nvim" because this
    -- is much simpler and easier on the eyes.
    {
      "stevearc/aerial.nvim",
      opts = {
        show_guides = true,
        layout = {
          -- {40, 0.2} MEANS The lesser of 40 columns or 20% of total
          max_width = { 40, 0.2 },
          -- width = nil,
          min_width = 20,
        },
      },
      keys = {
        {
          ",O",
          "<cmd>AerialToggle!<cr>",
          desc = "Toggle LSP symbol outline (aerial)",
        },
      },
      dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
      },
    },

    -- lspconfig {{{3
    {
      "neovim/nvim-lspconfig",
      event = "VeryLazy",
      init = function()
        -- Add a border around `LspInfo` window
        require("lspconfig.ui.windows").default_options.border = "rounded"

        -- Common `on_attach` function
        -- FIXME: Refactor custom `on_attach` function to abstract out the
        -- "format on save" options.
        -- TODO: Rename `on_attach` to something like `custom_on_attach` so
        -- it's not so confused with the default `on_attach`.
        local common_on_attach = function(client, bufnr)
          set_common_lsp_toggling_keymaps()
          set_common_lsp_and_diagnostics_configuration(client, bufnr)
          set_common_lsp_formatting({
            bufnr = bufnr,
            desired_client_name = client.name,
            sync_format_keymap = ",f",
            async_format_keymap = "g,f",
            sync_format_on_save = false,
            async_format_on_save = false,
          })
        end

        local capabilities = require("cmp_nvim_lsp").default_capabilities(
          vim.lsp.protocol.make_client_capabilities()
        )

        -- AWK
        require("lspconfig").awk_ls.setup({
          on_attach = common_on_attach,
          capabilities = capabilities,
        })

        -- ELIXIR
        require("lspconfig").elixirls.setup({
          -- `elixir-ls` doesn't come with a `cmd` so specify this manually
          -- e.g.: "/path/to/elixir-ls/language_server.sh"
          cmd = {
            vim.fn.stdpath("data")
              .. "/mason/packages/elixir-ls/language_server.sh",
          },
          capabilities = capabilities,
          -- using custom `on_attach` to enable lsp format
          on_attach = function(client, bufnr)
            set_common_lsp_toggling_keymaps()
            set_common_lsp_and_diagnostics_configuration(client, bufnr)
            set_common_lsp_formatting({
              bufnr = bufnr,
              desired_client_name = client.name,
              sync_format_keymap = ",f",
              async_format_keymap = "g,f",
              sync_format_on_save = true, -- changed from false
              async_format_on_save = false,
            })
          end,
        })

        -- ELM
        require("lspconfig").elmls.setup({
          on_attach = common_on_attach,
          capabilities = capabilities,
        })

        -- GO
        require("lspconfig").gopls.setup({
          on_attach = common_on_attach,
          capabilities = capabilities,
        })

        -- HASKELL
        require("lspconfig")["hls"].setup({
          filetypes = { "haskell", "lhaskell", "cabal" },
          on_attach = common_on_attach,
          capabilities = capabilities,
        })

        -- PURESCRIPT
        require("lspconfig").purescriptls.setup({
          on_attach = common_on_attach,
          capabilities = capabilities,
        })

        -- RUST
        -- NOTE: Now using builtin LSP `rust-analyzer` but consider moving
        -- to `mrcjkb/rustaceanvim` for more LSP features.
        require("lspconfig").rust_analyzer.setup({
          capabilities = capabilities,
          on_attach = function(client, bufnr)
            set_common_lsp_toggling_keymaps()
            set_common_lsp_and_diagnostics_configuration(client, bufnr)
            set_common_lsp_formatting({
              bufnr = bufnr,
              desired_client_name = client.name,
              sync_format_keymap = ",f",
              async_format_keymap = "g,f",
              sync_format_on_save = true, -- changed from false
              async_format_on_save = false,
            })
          end,
        })

        -- PYTHON/RUFF
        require("lspconfig").ruff_lsp.setup({
          on_attach = common_on_attach,
          capabilities = capabilities,
        })

        -- PYTHON/PYRIGHT
        require("lspconfig").pyright.setup({
          on_attach = common_on_attach,
          capabilities = capabilities,
        })

        -- LUA
        require("lspconfig").lua_ls.setup({
          on_attach = common_on_attach,
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
            completion = {
              -- TODO: Write descriptive comment
              callSnippet = "Replace",
            },
          },
        })
      end,
    },

    -- mason {{{3
    {
      "williamboman/mason.nvim",
      lazy = false, -- because `keys` would make ahis default to true
      config = function()
        require("mason").setup({
          ui = {
            icons = {
              package_installed = "",
              package_pending = "",
              package_uninstalled = "",
            },
          },
        })
      end,
      keys = {
        {
          "<m-m>",
          "<cmd>Mason<cr>",
          mode = "n",
          desc = "Open Mason UI",
        },
      },
      dependencies = {
        {
          "WhoIsSethDaniel/mason-tool-installer.nvim", -- {{{4
          -- TODO: Decide wherether to use this plugin, mason-lspconfig or both
          -- NOTE: Available cmds are
          -- `MasonToolsInstall/MasonToolsUpdate/MasonToolsClean`
          -- NOTE: Tool names might differ between mason and lspconfig. This
          -- plugin uses mason's tool names. The plugin
          -- `williamboman/mason-lspconfig.nvim` will allow mason to understand
          -- lspconfig's tool names.
          opts = {
            ensure_installed = {
              -- English
              "alex",
              "write-good",
              -- Lua
              "stylua",
              -- Elixir
              "elixir-ls",
              "nextls",
              -- Python
              "autoflake",
              "autopep8",
              "black",
              -- "flake8", -- FIXME: Deprecated?
              "isort",
              "pyright",
              -- Shell
              "shellcheck",
              -- Elm
              "elm-format",
              "elm-language-server",
            },
          },
        },
      },
    },

    -- none-ls / null-ls {{{3
    -- formatting/code_actions/diagnostics/hover/completion
    {
      "nvimtools/none-ls.nvim",
      -- "jose-elias-alvarez/null-ls.nvim"
      -- NOTE: Add keys to toggle null-ls that don't conflict with lspconfig.
      -- READ: https://github.com/jose-elias-alvarez/null-ls.nvim/issues/896
      event = { "BufReadPre", "BufNewFile" },
      opts = function()
        local null_ls = require("null-ls")
        return {
          -- BUILTINS:
          --  https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
          -- CONFIGURING BUILTINS:
          --  https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTIN_CONFIG.md
          sources = {
            -- shell
            null_ls.builtins.formatting.shfmt,
            -- elm
            null_ls.builtins.formatting.elm_format,
            -- fish
            null_ls.builtins.formatting.fish_indent,
            null_ls.builtins.diagnostics.fish,
            -- python
            null_ls.builtins.formatting.isort,
            null_ls.builtins.formatting.black,
            -- null_ls.builtins.diagnostics.flake8, -- FIXME: Deprecated?
            -- TODO: MIGRATE TO RUFF
            -- null_ls.builtins.diagnostics.ruff,
            -- purescript
            null_ls.builtins.formatting.purs_tidy,
            -- go
            null_ls.builtins.formatting.gofumpt,
            -- haskell
            -- null_ls.builtins.formatting.cabal_fmt, -- FIXME: Deprecated?
            -- null_ls.builtins.formatting.fourmolu.with({ -- FIXME: Deprecated?
            --   extra_args = { "--indentation", "2" },
            -- }),
            -- js/html etc.
            null_ls.builtins.formatting.prettierd, -- TODO: custom config
            -- rust
            -- null_ls.builtins.formatting.rustfmt,-- FIXME: Deprecated?
            -- lua
            null_ls.builtins.formatting.stylua.with({
              timeout = 40000, --default: 5k, -1 is no_timeout
            }),
            -- null_ls.builtins.diagnostics.luacheck.with({
            --   condition = function(utils)
            --     return utils.root_has_file({ ".luacheckrc" })
            --   end,
            -- }),
            -- Writing
            null_ls.builtins.code_actions.proselint,
            null_ls.builtins.diagnostics.write_good,
            null_ls.builtins.diagnostics.alex,
          },

          -- NOTE: Reuse a shared lspconfig on_attach callback here?
          on_attach = function(client, bufnr)
            -- FORMATTING:
            -- format on save:
            if client.supports_method("textDocument/formatting") then
              set_common_lsp_formatting({
                bufnr = bufnr,
                desired_client_name = "null-ls",
                sync_format_keymap = ",F",
                async_format_keymap = "g,F",
                sync_format_on_save = true,
                async_format_on_save = false,
              })
            end
          end,
          root_dir = require("null-ls.utils").root_pattern(
            ".null-ls-root",
            ".neoconf.json",
            "Makefile",
            ".git"
          ),
        }
      end,
      dependencies = {
        "nvim-lua/plenary.nvim",
        "williamboman/mason.nvim",
      },
    },

    -- luasnip {{{3
    {
      "L3MON4D3/LuaSnip",
      version = "2.*",
      -- NOTE: `jsregexp` is optional and apparently only needed for variable/placeholder-transformations
      -- READ: https://code.visualstudio.com/docs/editor/userdefinedsnippets#_variable-transforms
      build = "make install_jsregexp",
      opts = function()
        local types = require("luasnip.util.types")
        return {
          history = true,
          delete_check_events = "TextChanged",
          -- Add indicators
          ext_opts = {
            [types.snippet] = {
              active = {
                virt_text = { { "", "Character" } },
              },
            },
            [types.choiceNode] = {
              active = {
                virt_text = { { "󰬊", "Character" } },
              },
              passive = {
                virt_text = { { "󰬊", "NonText" } },
              },
            },
            [types.insertNode] = {
              active = {
                virt_text = { { "󰬐", "CursorLineNr" } },
              },
              passive = {
                virt_text = { { "󰬐", "NonText" } },
              },
              visited = {
                virt_text = { { "", "NonText" } },
              },
            },
          },
        }
      end,
      keys = function()
        local luasnip = require("luasnip")
        return {
          -- Expand or jump forwards
          {
            "<c-m-k>",
            function()
              if luasnip.expand_or_jumpable(1) then
                luasnip.expand_or_jump(1)
              end
            end,
            mode = { "i", "s" },
          },
          -- Jump backwards
          {
            "<c-m-j>",
            function()
              if luasnip.jumpable(-1) then
                luasnip.jump(-1)
              end
            end,
            mode = { "i", "s" },
          },
          -- Expand or jump forwards, but only when within the snippet
          {
            "<c-k>",
            function()
              if luasnip.expand_or_locally_jumpable(1) then
                luasnip.expand_or_jump(1)
              end
            end,
            mode = { "i", "s" },
          },
          -- Jump backwards, but only when within the snippet
          {
            "<c-j>",
            function()
              if luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
              end
            end,
            mode = { "i", "s" },
          },
          -- select in choice node
          {
            "<c-l>",
            function()
              if luasnip.choice_active() then
                luasnip.change_choice(1)
              end
            end,
            mode = { "i" },
          },
          -- select in choice node showin with `vim.select`ui
          {
            "<c-m-l>",
            function()
              if luasnip.choice_active() then
                require("luasnip.extras.select_choice")()
              end
            end,
            mode = { "i" },
          },
        }
      end,
      dependencies = {
        "rafamadriz/friendly-snippets",
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
          require("luasnip").filetype_extend("python", { "django" })
        end,
      },
    },

    -- nvim-cmp  {{{3
    {
      "hrsh7th/nvim-cmp",
      event = "InsertEnter",
      opts = function()
        local cmp = require("cmp")
        local common_mappings = {
          -- Open completion menu
          -- ["<c-space>"] = cmp.mapping.complete(),
          -- Toggle completion menu
          ["<c-space>"] = function()
            if cmp.visible() then
              cmp.close()
            else
              cmp.complete()
            end
          end,
          -- Close completion menu and return to insert mode
          ["<c-esc>"] = cmp.mapping.close(),
          -- Close completion menu and go to normal mode
          ["<esc>"] = function()
            cmp.close()
            vim.cmd.stopinsert()
          end,
          -- Traverse without inserting, forward
          ["<tab>"] = cmp.mapping.select_next_item({
            behavior = cmp.SelectBehavior.Select,
          }),
          -- Traverse without inserting, backward
          ["<s-tab>"] = cmp.mapping.select_prev_item({
            behavior = cmp.SelectBehavior.Select,
          }),
          -- Traverse without inserting, to last item
          ["<m-tab>"] = cmp.mapping.select_next_item({
            behavior = cmp.SelectBehavior.Select,
            count = 1000,
          }),
          -- Traverse without inserting, to first item
          ["<m-s-tab>"] = cmp.mapping.select_prev_item({
            behavior = cmp.SelectBehavior.Select,
            count = 1000,
          }),
          -- NOTE:
          -- DEFAULT Traverse without inserting, FORWARD:
          --  `<c-n>`/<down>
          -- DEFAULT Traverse without inserting, BACKWARD:
          --  `<c-p>`/<up>
          -- Traverse without inserting, to last item
          ["<c-m-n>"] = cmp.mapping.select_next_item({
            behavior = cmp.SelectBehavior.Select,
            count = 1000,
          }),
          -- Traverse without inserting, to first item
          ["<c-m-p>"] = cmp.mapping.select_prev_item({
            behavior = cmp.SelectBehavior.Select,
            count = 1000,
          }),
          -- Traverse without inserting, to last item
          ["<m-down>"] = cmp.mapping.select_next_item({
            behavior = cmp.SelectBehavior.Select,
            count = 1000,
          }),
          -- Traverse without inserting, to first item
          ["<m-up>"] = cmp.mapping.select_prev_item({
            behavior = cmp.SelectBehavior.Select,
            count = 1000,
          }),
          -- Traverse docs, forward by 2 lines
          ["<c-f>"] = cmp.mapping.scroll_docs(2),
          -- Traverse docs, backward by 2 lines
          ["<c-b>"] = cmp.mapping.scroll_docs(-2),
          -- Insert selection
          -- NOTE: Set `select` to `false` to only confirm explicitly selected items.
          ["<cr>"] = cmp.mapping.confirm({
            select = true,
            behavior = cmp.ConfirmBehavior.Insert,
            callback = function()
              cmp.close()
            end,
          }),
          --  Insert current selection, replacing current word.
          ["<s-cr>"] = cmp.mapping.confirm({
            select = true,
            behavior = cmp.ConfirmBehavior.Replace,
            callback = function()
              cmp.close()
            end,
          }),
          -- Even if completion menu is on, add a new line even while the
          -- completion menu is open (convenience)
          ["<c-cr>"] = function()
            cmp.close()
            vim.cmd.normal("i\r")
          end,
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

    -- LOCAL PLUGINS {{{3
    {
      dir = "~/code/playground/nvim-play/PROJECTS/play/",
    },
  },
})
