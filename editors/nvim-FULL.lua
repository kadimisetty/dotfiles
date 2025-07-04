-- NVIM CONFIGURATION {{{1
-- vim: foldmethod=marker:foldlevel=0:nofoldenable:
-- Author: [Sri Kadimisetty](https://github.com/kadimisetty/dotfiles)

--  BEHAVIORS SPECIFIC TO THIS FILE {{{2
-- TODO: Change section name to something better.
-- NOTE: For visual mode keymaps, use `x` instead of `v`.
-- NOTE: Don't make global aliases, e.g. `bo` for `vim.bo.` etc.

-- PREFERRED KEYMAP GRAMMAR {{{2
--  +------------------+-----------------------------------+
--  | LEADER/CHORD     | SCOPE                             |
--  +------------------+-----------------------------------+
--  | `<leader>x`      | Global actions                    |
--  | `<localleader>x` | Buffer actions                    |
--  |                  |                                   |
--  |                  | TELESCOPE:                        |
--  | `<space>x`       | Search                            |
--  |                  |                                   |
--  | `<c-w>x`         | Windows                           |
--  | `<c-w>X`         | Tabs                              |
--  |                  |                                   |
--  | `<c-x>`          | Text manipulation actions         |
--  |                  |                                   |
--  | `gx`             | Auxiliary actions                 |
--  | `Gx`             | Auxiliary actions in larger scope |
--  |                  |                                   |
--  |                  | OVERLAYS:                         |
--  | `<m-x>`          | Native overlays                   |
--  | `<M-x>`          | 3rd party Overlays                |
--  |                  |                                   |
--  |                  | LSP:                              |
--  | `,x`             | Native LSP                        |
--  | `,X`             | 3rd party LSP                     |
--  |                  |                                   |
--  | `dx`/`yod`/`[d`  | Diagnostics?                      |
--  |                  |                                   |
--  | `<c-m-x>`        | Motion                            |
--  |                  |                                   |
--  |                  | UNIMPAIRED STYLE:                 |
--  | `]x`             | Do/go-to next x                   |
--  | `[x`             | Do/go-to previous x               |
--  | `]X`             | Do/go-to first x                  |
--  | `[X`             | Do/go-to last x                   |
--  | `]ox`            | Enable x                          |
--  | `[ox`            | Disable x                         |
--  | `yox`            | Toggle x                          |
--  +------------------+-----------------------------------+

-- GENERAL PREFERENCES {{{1
-- LEADERS {{{2
vim.g.mapleader = [[\]]
vim.g.maplocalleader = [[\\]]

-- ENCODING {{{2
-- NOTE: Skip setting encoding as nvim utf-8 defaults are satisfactory.

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
if vim.fn.executable("par") == 1 then
  vim.opt.formatprg = "par -w79"
else
  vim.notify("WARN: Please install `par` for `formatprg`", vim.log.levels.WARN)
end

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
-- Disable Folds by default
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
  "mark", -- jumping to marks etc. like `'m`, via `<c-O>` etc.
  "percent", -- `%`
  "quickfix", -- :cn`, `:crew`, `:make`, etc.
  "search", -- triggering search patterns
  "tag", -- tag jumps like `:ta`, `<c-T>` etc.
  "undo", -- undo or redo
  -- "hor", -- horizontal movement like `l`,`w`, `fx` etc.
  -- "jump", -- far jumps like `G`, `gg` etc.
  -- `all`    -- everything
}

-- FOLDS UI {{{3
-- FOLD CHARACTERS {{{4
-- TODO: replace default `foldtexxt` content from `foldtext()` with custom.
-- TODO: Make foldcolumn more distinguishable.
-- TODO: Use a fold label description that shortens word "lines" to "l"
-- TODO: Place line count information at end of line.
vim.opt.fillchars:append({
  -- FOLD LABEL ENDING LINE:
  fold = [[─]],
  -- FOLDCOLUMN CHARACTERS:
  foldopen = "▾",
  foldclose = "▸",
})

-- FOLD TEXT {{{4
do
  -- TODO: Make current line bold to distinguish it from the other fold lines.
  -- TODO: Right now indented folds look like `▸ · ·`, make it `· · ▸`.
  -- TODO: CONSIDER: Heirachical style:
  --                  `  │ Some fold title`
  --                  `  ᴸ Last fold title`
  -- NOTE: Keep this function global i.e. don't use `local custom_foldtext`....
  function custom_foldtext()
    local default_foldchar = "─"
    local indent_char = "▸ " -- OPTIONS: "· "
    local indent_char = "· "
    local line_count = vim.v.foldend - vim.v.foldstart + 1
    local count_text = " " .. line_count .. " " -- Don't sho "l"/"lines".
    local fold_char = vim.opt.fillchars:get().fold or default_foldchar
    local line_text = vim
      .fn
      .getline(vim.v.foldstart)
      :gsub("^%s*", "") -- Remove leading whitespace
      :gsub("{{{%d*", "") -- Remove fold markers
      :gsub("%s*$", "") -- Remove trailing whitespace
      .. " " -- Add single trailing space
    local comment_format = vim.bo.commentstring
    if comment_format and comment_format ~= "" then
      local comment_start = comment_format
        :gsub("%%s.*", "") -- Remove `%s` and anything after it
        :gsub("([%-%.%+%[%]%(%)%$%^%%%?%*])", "%%%1") -- Escape regex
      local comment_end = comment_format
        :gsub(".*%%s", "") -- Remove anything before `%s`
        :gsub("([%-%.%+%[%]%(%)%$%^%%%?%*])", "%%%1") -- Escape regex
      if comment_start and comment_start ~= "" then
        -- Remove comment start marker and any whitespace after it
        line_text = line_text:gsub("^" .. comment_start .. "%s*", "")
      end
      if comment_end and comment_end ~= "" then
        -- Remove comment end marker and any whitespace before it
        line_text = line_text:gsub("%s*" .. comment_end .. "$", "")
      end
    end
    local fold_level = vim.v.foldlevel
    local indent_text = string.rep(indent_char, fold_level - 1)
    line_text = indent_text .. line_text
    local width = vim.fn.winwidth(0)
      - vim.fn.getwininfo(vim.fn.win_getid())[1].textoff
    local padding_length = width
      - vim.fn.strdisplaywidth(line_text)
      - vim.fn.strdisplaywidth(count_text)
    local padding_text = string.rep(fold_char, math.max(padding_length, 1))
    return line_text .. padding_text .. count_text
  end

  vim.opt.foldtext = "v:lua.custom_foldtext()"
end

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

-- BACKUPS {{{2
-- TODO: Directories mentioned here might need to occasionally be cleaned.

-- BACKUP BEFORE OVERWRITING A FILE {{{3
-- ----------------------------------------------------------------------------
-- `backup` |	`writebackup` | RESULTING BEHAVIOR
-- ---------+---------------+--------------------------------------------------
-- false    | false         | no backup made
-- false    | true          | backup current file, deleted afterwards (DEFAULT)
-- true     | false         | delete old backup, backup current file
-- true     | true          | delete old backup, backup current file (DESIRED)
-- ---------+---------------+--------------------------------------------------
vim.o.backup = true
vim.o.writebackup = true

-- WRITE BACKUP SAFELY {{{3
-- Make a copy of the file and overwrite the original one
-- NOTE: `no`/`auto` are faster but `yes` is safer
vim.o.backupcopy = "yes"

-- IGNORE BACKUPS FOR PATTERNS {{{3
-- Do not make backups for these file patterns (especially temporary files
-- NOTE: Environment variables need to be expanded/normalized i.e. `$HOME` etc.
-- NOTE: Current defaults:
--        - UNIX: `/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*`
--        - MACOS: `/private/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*`
-- Ignore files in `/tmp/*` also:
vim.opt.backupskip:append({
  vim.fs.joinpath(vim.fs.normalize("/tmp"), "*"),
})

-- BACKUP FILE LOCATIONS {{{3
-- Use this directory to store backups
-- NOTE: Default backup directories are in this order. Current directory, first
-- in list, is undesirable, so removing it:
--    1. Current directory (`"."`)  - UNDESIRED
--    2. `$HOME/nvim/backup/`       - DESIRED
vim.opt.backupdir:remove(".")
-- Warn when `backupdir` has no directories
if vim.o.backupdir:len() == 0 then
  vim.notify(
    "WARN: Backups are not being created (HINT: Is `backupdir` set?)",
    vim.log.levels.WARN
  )
end

-- SWAP FILE LOCATIONS {{{3
-- Locations to store swap files
-- NOTE: Using neovim default: `vim.fn.stdpath("state")/swap/`
-- vim.o.directory

-- CWORD {{{2
-- Sometimes the cursor is on the space/quote character right before a
-- word but vim will still report that word when expanding `cword`. This
-- function will return `true` only if it's literally on top of word in `cword`
-- and not before it and false otherwise. Vim's logic can be found in it's
-- source code in file: "src/nvim/normal.(h,c)".
function is_cursor_literally_on_cword()
  local cursor_column = vim.api.nvim_win_get_cursor(0)[2]
  local line = vim.api.nvim_get_current_line()
  -- Return false if current line is empty
  if line == "" then
    return false
  end
  local cword = vim.fn.expand("<cword>")
  local regex, search_pos = vim.regex("\\<" .. vim.pesc(cword) .. "\\>"), 0
  -- Iterate through all words with `cword` text content occurences in current
  -- line with the goal of finding the actual `cword` beacuse there is no other
  -- direct way.
  while search_pos < #line do
    local start_pos, end_pos = regex:match_str(line:sub(search_pos + 1))
    -- Return false if no more occurrences of `cword` are found in the line.
    if not start_pos then
      return false
    end
    start_pos, end_pos = start_pos + search_pos, end_pos + search_pos
    -- Return true if cursor is found within this `cword` occurrence's range.
    if cursor_column >= start_pos and cursor_column <= end_pos then
      return true
    end
    search_pos = end_pos + 1
  end
  return false
end

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
  -- TODO: JS/Node/Rust/Go/Elm etc.
})

-- UI {{{2
-- WINDOW TITLE {{{3
-- NOTE:
-- 1. "Window title" can be taken to mean terminal window title
-- 2. Fields used are from `statusline`.
-- 3. Do not use special characters, it's risky.
vim.opt.titlestring =
  -- Show + if file has been modified
  "%M"
  -- Show base filename
  .. "%f"
  -- Show [help] if help window
  .. "%h"
  -- Show [RO] if read-only
  .. "%r"
  -- Show [Preview] if preview window
  .. "%w"

-- Set title to value in `titlestring`
vim.opt.title = true

-- Title to use after vim is exiting but unable to restore the previously
-- replaced title
vim.opt.titleold = "Terminal"

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

-- Set vertical window seperator to pipelike symbol │ with no vertical gaps
vim.opt.fillchars:append({ vert = [[│]] })

-- Stop all error bells
vim.opt.belloff = "all"

-- Show error messages and throw exceptions that are otherwise omitted
-- NOTE: DISABLED
-- DEFAULT: ""
-- vim.opt.debug = "msg,throw"

-- For performance, only do syntax highlight up to these columns
vim.opt.synmaxcol = 2048

-- Highlight the screen line and column of cursor
vim.opt.cursorline = true
vim.opt.cursorcolumn = false

-- Position newly split windows to below
vim.opt.splitbelow = true

-- Position newly split windows to right
vim.opt.splitright = false

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
-- TODO: Shorten description.
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

-- FILE SPECIFIC WHITESPACE {{{4
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

-- Unsaved buffers are allowed to move to the background
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

-- Provide auto-formatting support
-- `n`: Numbered lists, official example:
--      1. the first item
--         wraps.
--      2. the second item
vim.opt.formatoptions:append({ n = true })

-- LIB {{{1
-- TODO: Replace unnecessary functions with their `vim.fs.`* equivalents
-- TODO: Add docstrings and validate parameter types
-- TODO: Add a function that generates the fold level marker strings

-- normalize_path(path) {{{2
--- Normalizes given path
local normalize_path = function(path)
  -- Normalize path
  local result = vim.fn.fnamemodify(path, ":p")
  -- Remove trailing separator
  result = result:gsub("[\\/]$", "")
  return result
end

-- are_paths_equal(paths) {{{2
--- Check if given paths are equivalent
local are_paths_equal = function(paths)
  -- 0 is an empty list and 1 is a single path
  if #paths < 2 then
    return true
  end
  -- Check all paths one by one
  local first_path = normalize_path(paths[1])
  for i = 2, #paths do
    if normalize_path(paths[i]) ~= first_path then
      return false
    end
  end
  return true
end

-- replace_cword_with_string(s) {{{2
-- TODO: Do variants of this for <cexpr> and <cfile>
-- TODO: Make repeatable by setting operatorfunc (Here or at callsite?)
-- TODO: Make best effort to return cursor position at call-site
--- Replaces `<cword>` with given string
local replace_cword_with_string = function(s)
  local cursor_position = vim.api.nvim_win_get_cursor(0)
  vim.cmd.normal({ "ciw" .. s, bang = true })
  vim.api.nvim_win_set_cursor(0, cursor_position)
end

-- replace_cWORD_with_string(s) {{{2
--- Replaces `<cWORD>` with given string
local replace_cWORD_with_string = function(s)
  local cursor_position = vim.api.nvim_win_get_cursor(0)
  vim.cmd.normal({ "ciW" .. s, bang = true })
  vim.api.nvim_win_set_cursor(0, cursor_position)
end

-- replace_cexpr_with_string(s) {{{2 TODO:: SEE: `:help <cexpr>` not `:h cexpr`

-- replace_cfile_with_string(s) {{{2 TODO: SEE: `:help <cfile>`

-- does_parent_path_contain_given_path(path, parent_path) {{{2
--- Check if given parent path contains given path
local does_parent_path_contain_given_path = function(parent_path, path)
  local parent_path_normalized = vim.fn.fnamemodify(parent_path, ":p")
  local given_path_normalized = vim.fn.fnamemodify(path, ":p")
  -- Remove trailing separator if present
  parent_path_normalized = parent_path_normalized:gsub("[\\/]$", "")
  given_path_normalized = given_path_normalized:gsub("[\\/]$", "")
  -- Check if given path starts with parent path and is longer
  if
    string.find(given_path_normalized, parent_path_normalized, 1, true) == 1
  then
    return #given_path_normalized > #parent_path_normalized
  end
  return false
end

-- toggle_trailing_pattern_on_string(s, trailing_pattern) {{{2
--- Toggle trailing pattern on string
local toggle_trailing_pattern_on_string = function(s, trailing_pattern)
  if vim.endswith(s, trailing_pattern) then
    --  Remove trailing pattern
    return string.sub(s, 1, -(#trailing_pattern + 1))
  else
    --  Add trailing pattern
    return s .. trailing_pattern
  end
end

-- toggle_leading_pattern_on_string(s, leading_pattern) {{{2
--- Toggle leading pattern on string
local toggle_leading_pattern_on_string = function(s, leading_pattern)
  if vim.startswith(s, leading_pattern) then
    --  Remove leading pattern
    return string.sub(s, (#leading_pattern + 1), -1)
  else
    --  Add leading pattern
    return leading_pattern .. s
  end
end

-- LANGUAGE/FILETYPE SPECIFIC PREFERENCES {{{1
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
vim.api.nvim_create_autocmd({ "FileType" }, {
  desc = "Set XML specific settings",
  group = vim.api.nvim_create_augroup("xml_augroup", {}),
  pattern = { "xml", "ttx" },
  callback = function()
    vim.g.xml_syntax_folding = 1
    vim.opt_local.foldmethod = "syntax"
    vim.cmd.syntax({ args = { "on" } })
    -- TODO: Convert to lua(figure out how to handle `%`)
    vim.cmd([[silent! %foldopen!]])
  end,
})

-- ELM {{{2
local elm_augroup = vim.api.nvim_create_augroup("elm_augroup", {})

-- Fix common elm typos with abbreviations
vim.api.nvim_create_autocmd({ "FileType" }, {
  desc = "Fix common elm typos with abbreviations",
  group = elm_augroup,
  pattern = { "elm" },
  callback = function()
    vim
      .iter({
        { "::", ":" },
      })
      :map(function(v)
        vim.cmd.abbreviate("<buffer>", v[1], v[2])
      end)
  end,
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
        "-- MAIN",
      }
    else
      content = {
        "module " .. module_name .. " exposing (..)",
        "",
        "",
      }
    end
    -- NOTE: Using 0 for last line index to place cursor at end of added lines
    vim.api.nvim_buf_set_lines(0, 0, 0, false, content)
  end,
})

-- HASKELL {{{2
-- COMMON HASKELL {{{3
local haskell_augroup = vim.api.nvim_create_augroup("haskell_augroup", {})

-- Set `hindent` as `formatprg`
-- NOTE: Requires `hindent` in `$PATH`
-- TODO: Call via `stack` (like `ALE` does for `hlint`)?
vim.api.nvim_create_autocmd({ "FileType" }, {
  desc = "Set `hindent` as `formatprg` for haskell files",
  group = haskell_augroup,
  pattern = { "haskell" },
  callback = function()
    if vim.fn.executable("hindent") == 1 then -- EXECUTABLE EXISTS? 1:YES, 0:NO
      vim.bo.formatprg = "hindent"
    end
  end,
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
        [[main :: IO ()]],
        [[main = putStrLn "MAIN: Hello!"]],
      }
    else
      content = {
        "module " .. module_name .. " where",
        "",
        "",
      }
    end
    -- NOTE: using last_line_index as 0 sets cursor at end of added lines
    -- which is where I want the cursor to be.
    vim.api.nvim_buf_set_lines(0, 0, 0, false, content)
  end,
})

-- TODO: Make this a toggle to remove the prime character if present already.
-- TODO: Achieve this without polluting registers (here `z`)
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = haskell_augroup,
  pattern = { "haskell" },
  callback = function()
    vim.keymap.set("n", "<localleader>'", function()
      local cword = vim.fn.expand("<cword>")
      -- Verify cword is not empty, not nil and not whitesapce
      if not (cword == nil or cword == "" or cword:match("%s")) then
        replace_cword_with_string(toggle_trailing_pattern_on_string(cword, "'"))
        -- FIXME: When the cursor is on the last trailing pattern character,
        -- removing that character leaves the cursor outside the word,
        -- which is not the desired behavior. The cursor should move back
        -- one step to remain "inside" the word, allowing the action to
        -- be repeated if necessary. This will be particularly useful
        -- with dot repetition.
      end
    end)
  end,
  desc = "Toggle trailing prime character on word under cursor",
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

-- DJANGO {{{2
-- TODO: Provide django base and component skeleton template files
local django_augroup = vim.api.nvim_create_augroup("django_augroup", {})

-- TODO: Set `htmldjango` filetype automatically by checking if html file
-- belongs to a django project using django file layout Heuristics.
vim.api.nvim_create_autocmd({ "FileType" }, {
  desc = "Add keymap to set `filetype` to `htmldjango`",
  group = django_augroup,
  pattern = { "html" },
  callback = function()
    vim.keymap.set("n", "<localleader>fd", function()
      vim.opt_local.filetype = "htmldjango"
    end, {
      desc = "Set `filetype` to `htmldjango`",
      silent = true,
      buffer = true,
    })
  end,
})

-- RUST {{{2
local rust_augroup = vim.api.nvim_create_augroup("rust_augroup", {})

-- Set rust specific settings
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = rust_augroup,
  pattern = { "rust" },
  callback = function()
    -- Set `formatprg` to `rustfmt`
    vim.bo.formatprg = "rustfmt"
    -- Put a space between comment marker and comment content
    vim.bo.commentstring = [[// %s]] -- DEFAULT: `//%s` (no space)
  end,
  desc = "Set rust specific settings",
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
  desc = "Set `heex` filetype",
})
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  group = elixir_augroup,
  pattern = { "*.html.eex" },
  command = "set filetype=eex",
  desc = "Set `eex` filetype",
})
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  group = elixir_augroup,
  pattern = { "*.html.heex" },
  command = "set syntax=eelixir",
  desc = "Set `heex` syntax to `eelixir`",
})
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  group = elixir_augroup,
  pattern = { "*.html.eex" },
  command = "set syntax=eelixir",
  desc = "See `eex` syntax to `eelixir`",
})

-- FISH {{{2
local fish_augroup = vim.api.nvim_create_augroup("fish_augroup", {})

-- Set fish specific settings
vim.api.nvim_create_autocmd({ "FileType" }, {
  desc = "Set fish specific settings",
  group = fish_augroup,
  pattern = { "fish" },
  callback = function()
    -- Put a space between comment marker and comment content
    vim.bo.commentstring = [[# %s]] -- DEFAULT: `#%s` (no space)
    -- FIXME: `blankname/vim-fish` recommends `compiler fish` in a `autocmd
    -- FileType` to use `:make` for syntax checking in fish files.
    -- vim.cmd.compiler("fish")
    -- NOTE: I prefer `expr` folding for fish in general, except in
    -- `config.fish` which is explicitly set there to `marker` via modeline.
    vim.opt_local.foldmethod = "expr"
  end,
})

-- GITCOMMIT WINDOW {{{2
local git_commit_augroup = vim.api.nvim_create_augroup("git_commit_augroup", {})

-- Set git comimit window specific settings
vim.api.nvim_create_autocmd({ "FileType" }, {
  desc = "Set git commit window specific settings",
  group = git_commit_augroup,
  pattern = { "gitcommit" },
  callback = function()
    -- Enable spell-checking
    vim.wo.spell = true
  end,
})

-- TOGGLES {{{1
-- Toggle small features e.g. leading/trailing characters.
-- TODO: Find better keymap grammar. Examples:
-- 1. `<m-*>`
-- 2. Unimpaired style, i.e. `yo*` to toggle `*`, `]o*` to enable `*`, `[o*` to
--    disable `*`
-- 3. `<localleader>*`

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
-- Toggle trailing period on current line {{{3
vim.keymap.set(
  "n",
  "<localleader>.",
  [[<cmd>call ToggleTrailingStringOnLine(".", line("."))<cr>]],
  {
    silent = true,
    buffer = true,
    desc = "Toggle trailing period on current line",
  }
)

-- TOGGLES HELPERS {{{2
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

-- TERMINAL EMULATOR {{{1
local terminal_augroup = vim.api.nvim_create_augroup("terminal_augroup", {})

-- CUSTOMIZE TERMINAL {{{2
vim.api.nvim_create_autocmd({ "TermOpen" }, {
  desc = "Customize built-in terminal",
  group = terminal_augroup,
  callback = function()
    -- Keep UI basic
    vim.wo.number = false
    vim.wo.relativenumber = false
    -- Show cursorline during normal mode
    vim.wo.cursorline = true
    -- Start in insert mode
    vim.cmd.startinsert()
  end,
})

-- TERMINAL QUICK OPEN KEYMAPS {{{2
-- Open within current tab
vim.keymap.set(
  "n",
  "<m-t>",
  "<cmd>horizontal botright split term://fish<cr>",
  { silent = true }
)
-- Open in new tab
vim.keymap.set("n", "<m-T>", "<cmd>tabnew term://fish<cr>", { silent = true })

-- WINDOWS AND TABS {{{1
-- NOTE: Prefer lower case keymaps for windows and upper case for tabs.

-- CREATING/SPLITTING/DUPLICATING {{{2
-- TODO: Duplicate current buffer in new window/tab. Do actual duplication i.e.
-- make a new unsaved buffer with contents of current buffer in a new
-- window/tab.
-- WARN: Don't use duplicate when meaning splitting a buffer.
-- OPENING NEW TAB PAGE:
-- NOTE: Using `<c-w>N` as it matches with vim's `<c-w>n` (new window)
vim.keymap.set(
  "n",
  "<c-w>N",
  "<cmd>tabnew<cr>",
  { silent = true, desc = "Open new tab page" }
)
-- OPEN CURRENT BUFFER IN A VERTICAL SPLIT WINDOW:
-- FIXME: Use something other than `d` beause it denotes "duplication".
vim.keymap.set(
  "n",
  "<c-w>d",
  "<cmd>vsplit<cr>",
  { silent = true, desc = "Open current buffer in a vertical split window" }
)
-- OPEN CURRENT BUFFER IN A NEW TAB PAGE:
-- FIXME: Use something other than `D` beause it denotes "duplication".
vim.keymap.set(
  "n",
  "<c-w>D",
  "<cmd>tab split<cr>",
  { silent = true, desc = "Open current buffer in a new tab page" }
)

-- MOVING {{{2
do
  vim.keymap.set("n", "<c-w><c-w>", "<cmd>tabnext #<cr>", {
    silent = true,
    desc = "Jump to last accessed tab page",
  })

  vim.keymap.set("n", "<tab>", "<cmd>tabnext<cr>", {
    silent = true,
    desc = "Jump to next tab",
  })

  vim.keymap.set("n", "<s-tab>", "<cmd>tabprevious<cr>", {
    silent = true,
    desc = "Jump to previous tab",
  })

  vim.keymap.set("n", "<c-w>`", "<cmd>tabfirst<cr>", {
    silent = true,
    desc = "Jump to first tab on backtick",
  })

  -- Jump to closest tab from given tab position
  ---@param targetTabIndex number
  local jumpToClosestTabPosition = function(targetTabIndex)
    --  NOTE:
    --  1. When a tab position isn't present, jump to largest i.e. when
    ---    only 1-4 tab positions are present, say target is  7 go to 4.
    --- 2. 0 is considered the last tab position, specifically even wheb there
    ---    are more than 9 tabs, 0 goes to the last one). 0 being listed here
    ---    feels wonky, but this is just a utility function so letting it be.

    local numberOfTabs = vim.tbl_count(vim.api.nvim_list_tabpages())
    -- Given target is 0 (go to last tab):
    if targetTabIndex == 0 then
      vim.cmd.tablast()
    -- Given target less than 1, bit not 0:
    elseif targetTabIndex < 0 then
      vim.cmd.tabfirst()
    -- Given target less than or equal to number of tabs:
    elseif targetTabIndex <= numberOfTabs then
      vim.cmd.execute([["normal! ]] .. targetTabIndex .. [[gt"]])
    -- Given target higher than number of tabs:
    elseif targetTabIndex > numberOfTabs then
      vim.cmd.execute([["normal! ]] .. numberOfTabs .. [[gt"]])
    end
  end
  -- Make keymaps to jump to tab positions 1 through 9
  for i = 0, 9 do
    vim.keymap.set("n", "<c-w>" .. i, function()
      jumpToClosestTabPosition(i)
    end, {
      silent = true,
      desc = "Jump to closest tab page number " .. i,
    })
  end
end

-- RENAMING {{{2
-- Rename current tab (WARN: uses plugin `gcmt/taboo.vim`)
-- FIXME: Remove dependency on plugin `gcmt/taboo.vim`.
local rename_tab_with_taboo_plugin = function(show_current_tab_name_in_prompt)
  if not vim.g.loaded_taboo == 1 then -- Assert plugin `gcmt/taboo.vim` loaded.
    vim.notify(
      "ERROR: Dependency not found: `gcmt/taboo.vim`",
      vim.log.levels.ERROR
    )
  else
    vim.validate({
      show_current_tab_name_in_prompt = {
        show_current_tab_name_in_prompt,
        "boolean",
      },
    })
    local prompt
    local current_tabpage_number = vim.fn.tabpagenr()
    if show_current_tab_name_in_prompt then
      local current_taboo_tabpage_name =
        vim.fn.TabooTabName(current_tabpage_number)
      if current_taboo_tabpage_name == "" then
        prompt = "RENAME TAB: "
      else
        prompt = "RENAME TAB(" .. current_taboo_tabpage_name .. "): "
      end
    else
      prompt = "RENAME TAB: "
    end
    local ok, new_tab_name = pcall(vim.fn.input, { prompt = prompt })
    local report_rename_failed = function()
      vim.notify("WARN: Tabpage not renamed", vim.log.levels.WARN)
    end
    if not ok then -- User cancelled with `<c-c>`
      report_rename_failed()
    else
      local ok2, err = pcall(vim.cmd.TabooRename, new_tab_name)
      if not ok2 then -- User gave empty string or cancelled with `<esc>`
        report_rename_failed()
      else
        -- TODO: Reconsider this clearing command line behavior.
        print("") -- Clear command line prompt line
      end
    end
  end
end
vim.keymap.set("n", "<c-w>,", function()
  rename_tab_with_taboo_plugin(true)
end, {
  silent = true,
  desc = "Rename current tabpage",
})

-- SPLITTING {{{2
--  TODO: Find better split keymaps
--  TODO: Add keymap descriptions
--  NOTE: These are deliberately identical to my tmux pane keymaps
--  NOTE: Regretfully `<c-w>-` just doesn't fit into my vim keymap system. So
--  temporarily relying on good old `<c-w>v` and `<c-w>s` for the splits and
--  therefore leaving `<c-w>-`/`<c-w>+` alone.
--  POSSIBLE HORIZONTAL SPLIT KEYMAP:
--    `nnoremap <silent> <c-w>-     :split<CR>`
--  POSSIBLE VERTICAL SPLIT KEYMAP:
--    `nnoremap <silent> <c-w>\|    :vsplit<CR>`

-- SIZING {{{2
vim.keymap.set("n", "<c-w>=", "<cmd>wincmd =<cr>", {
  silent = true,
  desc = "Make windows equal sizes",
})

-- FOCUS {{{2
vim.keymap.set("n", "<c-h>", "<cmd>wincmd h<cr>", {
  silent = true,
  desc = "Move focus to window to the left",
})

vim.keymap.set("n", "<c-j>", "<cmd>wincmd j<cr>", {
  silent = true,
  desc = "Move focus to window to the bottom",
})

vim.keymap.set("n", "<c-k>", "<cmd>wincmd k<cr>", {
  silent = true,
  desc = "Move focus to window to the top",
})

vim.keymap.set("n", "<c-l>", "<cmd>wincmd l<cr>", {
  silent = true,
  desc = "Move focus to window to the right",
})
-- Move focus to previously focussed window
-- NOTE: Disabled because I don't tend to use this AND don't particularly feel
-- like this shortcut `<c-w>p` fits in with the rest
-- vim.keymap.set("n", "<c-w>p", "<cmd>wincmd p<cr>", { silent = true })

-- MOVING {{{2
-- NOTE: "Wrapping while moving" in this section is when the tab is at the end,
-- continue moving to the other end in a loop.
-- NOTE: Currently not using wrapping motions. To use them, while calling
-- `TabMoveBy1`, use `1` to enable, `0` to disable.
-- FIXME: Fix wrapping situation in this section.
-- MOVE TAB FORWARDS/BACKWARDS (with wrapping):
vim.keymap.set(
  "n",
  "<c-w><s-right>",
  '<cmd>call TabMoveBy1("right", 0)<cr>',
  { silent = true, desc = "Move tab forwards" }
)
vim.keymap.set(
  "n",
  "<c-w><s-left>",
  '<cmd>call TabMoveBy1("left", 0)<cr>',
  { silent = true, desc = "Moe tab backwards" }
)
-- TODO: MOVE TAB FORWARDS/BACKWARDS (with no concept of wrapping/error
-- reporting):
-- vim.keymap.set('n' , '<c-w><s-right>', '<cmd>tabmove +1<cr>', {silent = true})
-- vim.keymap.set('n' , '<c-w><s-left>', '<cmd>tabmove -1<cr>', {silent = true})

-- MOVE TAB TO THE FIRST/LAST POSITION:
-- NOTE: `:tabmove 0` moves to the first position and `:tabmove` to the last
-- NOTE: Doing both `<c-w>g*` and `g<c-w>*` variations, because I forget.
vim.keymap.set("n", "<c-w>g<s-left>", "<cmd>tabmove 0<cr>", {
  silent = true,
  desc = "Move tab to first position",
})
vim.keymap.set("n", "g<c-w><s-left>", "<cmd>tabmove 0<cr>", {
  silent = true,
  desc = "Move tab to first position",
})
vim.keymap.set("n", "<c-w>g<s-right>", "<cmd>tabmove<cr>", {
  silent = true,
  desc = "Move tab to last position",
})
vim.keymap.set("n", "g<c-w><s-right>", "<cmd>tabmove<cr>", {
  silent = true,
  desc = "Move tab to last position",
})

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
vim.keymap.set("n", "<c-w>o", "<cmd>only<cr>", {
  silent = true,
  desc = "Close all other windows in current tab",
})
vim.keymap.set("n", "<c-w>O", "<cmd>tabonly<cr>", {
  silent = true,
  desc = "Close all other tabs",
})
-- FIXME: Add user confirmation before enabling.
-- vim.keymap.set("n", "<c-w>X", "<cmd>tabclose<cr>", {
--   silent = true,
--   desc = "Closing current tab",
-- })

-- VIEWS AND SESSIONS {{{1
-- NOTE: I want to use `<c-w>` as prefix key to gel with the rest of my window/tab
--     page keymaps and since views act on windows and sessions can be
--     considered to include tabs.
-- NOTE: The perfect keymap set for views/sessions would have been `<c-w>s/S` for
--     saving and `<c-w>l/L` for loading view/sessions. However `<c-w>l` is used
--     to navigate split views and is too important to sacrifice, hence the
--     current keymaps.

-- VIEWS {{{2
--  +-----------+---------------+-------------------------------------------------+
--  | `<c-w>m`  | `:mkview`     | Save view                                       |
--  | `<c-w>v`  | `:loadview`   | Load view saved with `mkview`                   |
--  +-----------+---------------+-------------------------------------------------+
--  |  FOR 1..9 DO:(e.g. 1)                                                       |
--  | `<c-w>m1` | `:mkview 1`   | Save *view no. 1*                               |
--  | `<c-w>v1` | `:loadview 1` | Load view saved with `mkview 1` i.e *view no.1* |
--  +-----------+---------------+-------------------------------------------------+
-- NOTE: Using the overwriting variant `mkview!` isn't necessary because AFAICT
-- it only applies to manually named view files.
-- NOTE: Unlike sessions, views created via `:mkview` (given argument with no
-- filename/with just filename and no directory) aren't saved in the local
-- directory but in `viewdir`.
-- SAVE AND LOAD VIEW:
vim.keymap.set("n", "<c-w>m", function()
  local ok, res = pcall(vim.cmd.mkview)
  if ok then
    vim.notify("Saved view", vim.log.levels.INFO)
  else
    local error_message = "Unable to save view"
    if res ~= "" then
      error_message = error_message .. ": " .. res
    end
    vim.notify(error_message, vim.log.levels.ERROR)
  end
end, {
  silent = true,
  desc = "Save view",
})
vim.keymap.set("n", "<c-w>v", function()
  local ok, res = pcall(vim.cmd.loadview)
  if ok then
    vim.notify("Loaded view", vim.log.levels.INFO)
  else
    local error_message = "Unable to load view"
    if res ~= "" then
      error_message = error_message .. ": " .. res
    end
    vim.notify(error_message, vim.log.levels.ERROR)
  end
end, {
  silent = true,
  desc = "Load view",
})
-- SAVE AND LOAD VIEW (1..=9):
for i = 1, 9 do
  vim.keymap.set("n", "<c-w>m" .. i, function()
    local ok, res = pcall(vim.cmd.mkview, i)
    if ok then
      vim.notify("Saved view " .. i, vim.log.levels.INFO)
    else
      local error_message = "Unable to save view into view file " .. i
      if res ~= "" then
        error_message = error_message .. ": " .. res
      end
      vim.notify(error_message, vim.log.levels.ERROR)
    end
  end, {
    silent = true,
    desc = "Save view into `" .. i .. "`(view file)",
  })
  vim.keymap.set("n", "<c-w>v" .. i, function()
    local ok, res = pcall(vim.cmd.loadview, i)
    if ok then
      vim.notify("Loaded view " .. i, vim.log.levels.INFO)
    else
      local error_message = "Unable to load view from view file " .. i
      if res ~= "" then
        error_message = error_message .. ": " .. res
      end
      vim.notify(error_message, vim.log.levels.ERROR)
    end
  end, {
    silent = true,
    desc = "Load view from `" .. i .. "`(view file)",
  })
end

-- SESSIONS {{{2
-- SESSION OPTIONS {{{3
-- - VIM DEFAULT:
--    `blank,buffers,curdir,folds,help,options,tabpages,winsize,terminal`
-- - NEOVIM DEFAULT:
--    `blank,buffers,curdir,folds,help,tabpages,winsize,terminal` (No `options`)
-- - DESIRED:
--    `blank,buffers,curdir,folds,help,tabpages,winsize,globals`
vim.opt.sessionoptions:remove({ "terminal" })
vim.opt.sessionoptions:append({ "tabpages", "globals" })

-- CREATE/SOURCE SESSIONS {{{3
-- CREATE/SOURCE SESSIONS HELPERS {{{4
-- TODO: Validate helper functions' arguments
local source_session_file_from_current_directory = function(opts)
  local scope = opts.scope or "window" -- default: window
  local session_filepath
  if scope == "window" then
    session_filepath = "Session.vim"
  elseif scope == "global" then
    -- NOTE: getcwd(-1, -1) returns globally scoped current directory
    session_filepath = vim.fs.joinpath(vim.fn.getcwd(-1, -1), "Session.vim")
  end
  local ok, res = pcall(vim.cmd.source, session_filepath)
  if ok then
    vim.notify(
      "Sourced `Session.vim` from " .. scope .. " current directory",
      vim.log.levels.INFO
    )
  else
    if string.match(res, "E484") then
      vim.notify(
        "ERROR E484: `Session.vim` from "
          .. scope
          .. " current directory cannot be opened",
        vim.log.levels.ERROR
      )
    else
      -- any other error
      vim.notify(res, vim.log.levels.ERROR)
    end
  end
end

local create_session_file_in_current_directory = function(opts)
  local session_filepath
  local scope = opts.scope or "window" -- default: window
  local overwrite = opts.overwrite
  if scope == "window" then
    session_filepath = "Session.vim"
  elseif scope == "global" then
    -- NOTE: getcwd(-1, -1) returns globally scoped current directory
    session_filepath = vim.fs.joinpath(vim.fn.getcwd(-1, -1), "Session.vim")
  end
  local ok, res = pcall(vim.cmd.mksession, { session_filepath, bang = false })
  if ok then
    vim.notify(
      "Created `Session.vim` in " .. scope .. " current directory",
      vim.log.levels.INFO
    )
  else
    if string.match(res, "E189") then
      if not overwrite then
        vim.notify(
          "ERROR E189: Unable to overwrite `Session.vim` file in "
            .. scope
            .. " current directory",
          vim.log.levels.ERROR
        )
      else
        local ok2, res2 = pcall(vim.cmd.mksession, {
          session_filepath,
          bang = true,
        })
        if ok2 then
          vim.notify(
            "Overwrote `Session.vim` in " .. scope .. " current directory",
            vim.log.levels.INFO
          )
        else
          -- any other error
          vim.notify(res2, vim.log.levels.ERROR)
        end
      end
    else
      vim.notify(
        res, -- any other error
        vim.log.levels.ERROR
      )
    end
  end
end

-- SESSION KEYMAPS {{{4
-- +---------+-----------------------------------------------------------------+
-- |`<c-w>M`  | Create session in globally scoped current directory(overwrite) |
-- |`<c-w>S`  | Source session from globally scoped current directory          |
-- +---------+-----------------------------------------------------------------+
-- |`g<c-w>M` | Create session in window scoped current directory(overwrite)   |
-- |`g<c-w>S` | Source session from window scoped current directory            |
-- +---------+-----------------------------------------------------------------+
--
-- NOTE: Using `<c-w>m` for creating views; so using `<c-w>M` for creating
-- sessions with just the overwrite variants for now.
-- TODO: Add a function to delete `Session.vim` as well.

-- GLOBALLY SCOPED CURRENT DIRECTORY:
vim.keymap.set("n", "<c-w>M", function()
  create_session_file_in_current_directory({
    scope = "global",
    overwrite = true,
  })
end, {
  silent = true,
  desc = "Create `Session.vim` in globally scoped current directory(overwrite)",
})
vim.keymap.set("n", "<c-w>S", function()
  source_session_file_from_current_directory({ scope = "global" })
end, {
  silent = true,
  desc = "Source `Session.vim` from globally scoped current directory",
})

-- WINDOW SCOPED CURRENT DIRECTORY:
vim.keymap.set("n", "g<c-w>M", function()
  create_session_file_in_current_directory({
    scope = "window",
    overwrite = true,
  })
end, {
  silent = true,
  desc = "Create `Session.vim` in window scoped current directory(overwrite)",
})
vim.keymap.set("n", "g<c-w>S", function()
  source_session_file_from_current_directory({ scope = "window" })
end, {
  silent = true,
  desc = "Source `Session.vim` from window scoped current directory",
})

-- UTILITIES {{{1
local utilities_augroup = vim.api.nvim_create_augroup("utilities_augroup", {})

-- NOTIFY MORE MACRO ACTIONS {{{2
vim.api.nvim_create_autocmd({ "RecordingLeave" }, {
  group = utilities_augroup,
  desc = "Notify more macro actions (like cleared)",
  callback = function()
    local register_name = vim.v.event.regname
    local register_contents = vim.fn.keytrans(vim.v.event.regcontents)
    if register_contents == "" then
      -- CLEARED MACRO REGISTER:
      vim.schedule_wrap(function()
        vim.notify("cleared @" .. register_name, vim.log.levels.WARN)
      end)()
    else
      -- UPDATED MACRO REGISTER:
      vim.schedule_wrap(function()
        vim.notify(
          "recorded @" .. register_name .. ": " .. register_contents,
          vim.log.levels.INFO
        )
      end)()
    end
  end,
})

-- OPEN BUFFERS IN WINDOWS/TABS {{{2
-- NOTE: Make keymaps with existing window/tab keymaps in mind.
-- NOTE: Using the force split versions i.e. `sball`/`sall` to force open all
-- buffers.
-- OPEN ALL BUFFERS IN TABS/WINDOWS:
vim.keymap.set("n", "<c-w>b", "<cmd>sball<cr>", {
  silent = true,
  desc = "Open all buffers in windows (in current tab)",
})
vim.keymap.set("n", "<c-w>B", "<cmd>tab sball<cr>", {
  silent = true,
  desc = "Open all buffers in tabs",
})
-- OPEN ALL ARGLIST BUFFERS IN TABS/WINDOWS:
vim.keymap.set("n", "<c-w>a", "<cmd>sall<cr>", {
  silent = true,
  desc = "Open all arglist buffers in windows in current tab",
})
vim.keymap.set("n", "<c-w>A", "<cmd>tab sall<cr>", {
  silent = true,
  desc = "Open all arglist buffers in tabs",
})
-- TODO: OPEN ALL BUFFERS MENTIONED IN QUICFIX IN TABS/WINDOWS
-- TODO: OPEN ALL BUFFERS MENTIONED IN LOCATION LIST IN TABS/WINDOWS

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
vim.keymap.set("x", "<d-/>", [[:<c-u>'<,'>normal gcc<cr>]], {
  desc = "Comment selection (XCode shortcut)",
})

-- IN COMMAND LINE AUTOCOMPLETE USE `UP`/`DOWN` LIKE `<c-n>`/`<c-p>` {{{2
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

-- `bonly` TO DELETE ALL OTHER BUFFERS {{{2
-- Close all other buffers. Similar to `:only`(windows) and `:tabonly`(tabs).
-- TODO: Add variant `:Bufonly!` that force deletes even unsaved buffers.
-- TODO: Keymaps `<c-w><c-b/B>` are currently bound to "open all buffers in
-- windows/tabs", so find a keymap that works; until then it's ommands only.
vim.api.nvim_create_user_command("Bufonly", function(opts)
  vim
    .iter(vim.api.nvim_list_bufs())
    :filter(function(bufnr)
      return not (
        1 ~= vim.fn.buflisted(bufnr) -- Current buffer
        or bufnr == vim.api.nvim_get_current_buf() -- Unlisted buffers
      )
    end)
    :map(function(bufnr) -- Delete unwanted buffers
      local bufname = vim.fn.bufname(bufnr)
      local ok, _ = pcall(vim.api.nvim_buf_delete, bufnr, { force = opts.bang })
      if not ok then
        vim.notify(
          "Failed to delete buffer: " .. bufnr .. " " .. bufname,
          vim.log.levels.ERROR
        )
      end
    end)
end, {
  desc = "Delete all other buffers",
  bang = true,
})

-- `cd` VARIANTS TO GO UP TO "git root" DIR {{{2
-- NOTE: VARIANTS FOR:
-- 1. `GLCD`: cd upto window scoped dir (`lcd`)
-- 2. `GTCD`: cd upto tab scoped dir (`tcd`)
-- 3. `GCD`: cd upto global scoped dir (`cd`)
-- 4. `GCHDIR`: cd upto dir scoped to what was set in following order (`chdir`):
--      1. window scoped dir set via `lcd`
--      2. tab scoped dir set via `tcd`
--      3. global scoped dir via `cd`
-- NOTE: Using uppercase `GCD` format to avoid conflicts with fugitive plugin
-- which uses `Gcd` and `Glcd` which provide a similar feature but also
-- additional can cd to a directory relative to git_root _dir like`Gcd
-- <dir-relative-to-git-root>`. However fugitive does not provide a `tcd`
-- variant, which these commands do.
-- NOTE: `cd_kind` parameter can be one of `lcd`/`tcd`/`cd`/`chdir`
-- NOTE: `bang` parameter boolean and is to be the bang in `cd!` etc.
-- TODO: Validate parameters' values
local cd_to_git_root_directory = function(cd_kind, bang)
  -- GET GIT ROOT DIRECTORY
  local result = vim
    -- RESULT FORMAT: { code = 0, signal = 0, stdout = 'ok', stderr = '' }
    .system({ "git", "rev-parse", "--show-toplevel" }, { text = true })
    -- SYNCHRONOUS CALL
    :wait()
  -- CHECK: `pwd` is inside a git repo?
  if result["code"] ~= 0 then -- ERROR: `pwd` is not inside a git repo
    vim.notify("ERROR: " .. result["stderr"], vim.log.levels.ERROR, {})
  else -- OK: `pwd` is inside a git repo
    local git_root_dir = vim.trim(result["stdout"])
    if cd_kind == "lcd" then
      vim.cmd.lcd({ git_root_dir, bang = bang })
    elseif cd_kind == "tcd" then
      vim.cmd.tcd({ git_root_dir, bang = bang })
    elseif cd_kind == "cd" then
      vim.cmd.cd({ git_root_dir, bang = bang })
    elseif cd_kind == "chdir" then
      -- ignoring `chdir` return value
      local _ = vim.cmd.chdir({ git_root_dir, bang = bang })
    end
  end
end

vim.tbl_map(function(cd_kind)
  vim.api.nvim_create_user_command("G" .. cd_kind:upper(), function(cargs)
    cd_to_git_root_directory(cd_kind, cargs["bang"])
  end, {
    bang = true,
    desc = cd_kind .. " to git root directory",
  })
end, {
  "lcd",
  "tcd",
  "cd",
  "chdir",
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

-- CLEAR ALL REGISTERS {{{2
-- TODO: Configure by register type e.g. "all", "a-z", "0-9", "/-" or any
-- combination of those.
-- TODO: Most recently executed command is stored in register `:` and that
-- will show this command being run. Set a timer to clear that after this is
-- completed.
local clear_all_registers = function()
  -- TODO: Add user preference to configure printing notifications.
  -- NOTE: Clearing ALL POSSIBLE registers.
  -- TODO: Some of these registers require nuance to clear them, especially
  -- special ones.
  local registers_to_clear =
    'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-"'
  -- TODO: Iterate with `vim.iter`.
  for i = 1, #registers_to_clear do
    local register = registers_to_clear:sub(i, i)
    -- FIXME: Setting a register to emoty string, clears it but doesn't remove
    -- the register's contents i.e. it will still be listed in `:registers`. To
    -- clear it properly do  `call setreg('a', [])`(vimscript) which will
    -- remove it from `:registers` as well. At lest add bahevior as a user
    -- preference.
    vim.fn.setreg(register, "") -- "Clear" by setting to empty string
  end
  vim.notify("All registers cleared", vim.log.levels.INFO)
end
vim.api.nvim_create_user_command(
  -- FIXME: Assert user confirmation and add a bang variant for no confirmation.
  "RegistersClearAll",
  function(opts)
    --NOTE:  GET USER CONFIRMATION TO PROCEED IF `bang` IS GIVEN.
    if opts.bang == true then
      -- NO CONFIRMATION
      clear_all_registers()
    else
      -- GET USER CONFIRMATION FIRST
      -- FIXME: Main message passed to `confirm` is not being displayed.
      local user_choice = vim.fn.confirm(
        "Clear all registers' contents?",
        "Clear &All Registers\n&No",
        2 -- Default to NO
      )
      if user_choice == 1 then -- YES
        clear_all_registers()
      else -- NO
        vim.notify("Cancelled", vim.log.levels.INFO)
      end
    end
  end,
  {
    bang = true,
    desc = "Clear all registers",
  }
)

-- RETAIN VISUAL SELECTION AFTER AN INDENTATION SHIFT {{{2
vim.keymap.set("x", "<", "<gv", {
  silent = true,
  desc = "Shift leftwards retaining visual selection",
})
vim.keymap.set("x", ">", ">gv", {
  silent = true,
  desc = "Shift rightwards retaining visual selection",
})

-- QUICK JUMPS TO POSITIONS BY PERCENTAGE {{{2
-- CURRENT LINE {{{3
-- NOTE:
-- 1. Using current line leader: `g`
-- 2. Can't think of proper line equivalent for 100%, so just use built-in `g$`
-- 3. `g0 goes to 0% by default`, so no need for a 0 position and also cannot
--    use `g0`.
-- 4. `gH` natively starts select mode but I never use it, so feeling opkay
--    about overwriting it.
-- 5. `gM` natively jumps to 50%, but keeping custom keymap away for sake of
--    completion and description appearing in `which-key` etc.
do
  -- JUMP TO HIGH(H)/MEDIUM(M)/LOW(L) POSITION IN CURRENT LINE {{{4
  vim.keymap.set(
    "n",
    "gH",
    "0%",
    { silent = true, desc = "Jump to buffer's high(H)(start) position" }
  )
  vim.keymap.set(
    "n",
    "gM",
    "50%",
    { silent = true, desc = "Jump to buffer's middle(M) position" }
  )
  vim.keymap.set(
    "n",
    "gL",
    "100%",
    { silent = true, desc = "Jump to buffer's low(L)(end) position" }
  )
  -- JUMP TO 0/10/20/30/40/50/60/70/80/90% POSITION IN CURRENT LINE {{{4
  for i = 1, 9 do
    vim.keymap.set(
      "n",
      "g" .. i,
      (i * 10) .. "gM",
      { silent = true, desc = "Jump to current line's (N*10)% position" }
    )
  end
end
-- CURRENT BUFFER {{{3
-- NOTE:
-- 1. Using current buffer leader: `G`
-- 2. Not using 0 for 100% because of conflict woth line's native equivalent.
-- 3. Can't think of proper buffer equivalent for 100%, so just use the
--    built-in `GG`
do
  -- JUMP TO HIGH(H)/MEDIUM(M)/LOW(L) POSITION IN CURRENT BUFFER {{{4
  vim.keymap.set("n", "GH", "2%", {
    silent = true,
    desc = "Jump to current buffer's high(H) position",
  })
  vim.keymap.set("n", "GM", "50%", {
    silent = true,
    desc = "Jump to current buffer's middle(M) position",
  })
  vim.keymap.set("n", "GL", "98%", {
    silent = true,
    desc = "Jump to current buffer's low(L) position",
  })
  -- JUMP TO 0/10/20/30/40/50/60/70/80/90% POSITION IN CURRENT BUFFER {{{4
  vim.keymap.set(
    "n",
    "G0",
    "gg",
    { silent = true, desc = "Jump to current buffer's 0% position" }
  )
  for i = 1, 9 do
    vim.keymap.set(
      "n",
      "G" .. i,
      (i * 10) .. "%",
      { silent = true, desc = "Jump to current buffer's (N*10)% position" }
    )
  end
end

-- RESTORE CURSOR POSITION AFTER YANK WITH `y` {{{2
-- SEE: https://nanotipsforvim.prose.sh/sticky-yank
-- TODO: See if this can be put inside a single block like with `J`
-- FIXME: Sometimes, depending on previous yank location, this messes up my
-- duplicate line keymap, so disabling until fixed
-- do
--   -- Store cursor position right before yanking and then finish yank
--   local cursor_position_before_yank = nil
--   vim.keymap.set({ "n", "x" }, "y", function()
--     cursor_position_before_yank = vim.api.nvim_win_get_cursor(0)
--     return "y"
--   end, { expr = true })
--
--   -- Return cursor position
--   vim.api.nvim_create_autocmd("TextYankPost", {
--     desc = "Restore cursor position after yank",
--     group = utilities_augroup,
--     callback = function()
--       if vim.v.event.operator == "y" and cursor_position_before_yank then
--         vim.api.nvim_win_set_cursor(0, cursor_position_before_yank)
--       end
--     end,
--   })
-- end

-- RESTORE CURSOR POSITION AFTER JOINING TWO LINES WITH `J` {{{2
vim.keymap.set("n", "J", function()
  local cursor_position = vim.api.nvim_win_get_cursor(0)
  vim.cmd.join()
  vim.api.nvim_win_set_cursor(0, cursor_position)
end, {
  silent = true,
  desc = "Return cursor position after joining lines",
})

-- HIGHLIGHT YANKED TEXT {{{2
-- NOTE:
-- 1. Neovim comes with "highlight on yank", but I'm disabling it to use
--    plugin's that provide more features like `mei28/luminate.nvim`.
-- 2. Neovim uses the `IncSearch` highlight by default. See help for how to
--    configure.
--[[
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Briefly highlight yanked text",
  group = utilities_augroup,
  callback = function()
    vim.highlight.on_yank()
  end,
})
--]]

-- START SEARCH WITH WORD UNDER CURSOR FILLED IN {{{2
-- TODO: Decide if I should use `g/` or `<m-/>` style keymaps!
-- TODO: Stick with `feedkeys` or should I just execute a simple string like
--        `normal! /\\<c-r>\\<c-w>` instead?
-- TODO: Add variants to prefill with `WORD`(`<c-r><c-a>`) too.
-- FORWARD:
vim.keymap.set(
  "n",
  "g/", -- `"<m-/>"`,
  function()
    vim.fn.feedkeys("/", "n")
    vim.fn.feedkeys(
      vim.api.nvim_replace_termcodes("<c-r><c-w>", true, true, true),
      "n"
    )
  end,
  {
    noremap = true,
    silent = true,
    desc = "Start forward search prefilled with word under cusror",
  }
)
-- BACKWARD:
vim.keymap.set(
  "n",
  "g?", -- `"<m-s-/>"` (i.e. `<m-?>` but has to be specified that way)
  function()
    vim.fn.feedkeys("?", "n")
    vim.fn.feedkeys(
      vim.api.nvim_replace_termcodes("<c-r><c-w>", true, true, true),
      "n"
    )
  end,
  {
    noremap = true,
    silent = true,
    desc = "Start backward search prefilled with word under cusror",
  }
)

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

-- COMMANDLINE TRANSFORMATIONS  {{{2
-- FIXME: Replace these ad-hoc transformations into something more orthogonal.
-- TODO: Lay out a keymap table for these transformations.

-- TRANSFORM SEARCH INTO "SEARCH INSIDE VISUAL SELECTION" {{{3
-- Transform commandline search into "search inside recent visual selection"
-- while keeping any existing user entered search patterns.
vim.keymap.set("c", "<m-v>", function()
  local existing_search_pattern = vim.fn.getcmdline()
  local new_search_pattern = [[/\%V]] .. existing_search_pattern
  vim.fn.feedkeys(
    vim.api.nvim_replace_termcodes("<c-c>", true, true, true),
    "n"
  )
  vim.fn.feedkeys(new_search_pattern, "n")
end, {
  noremap = true,
  desc = [[Transform search into "search within recent visual selection"]],
})

-- TRANSFORM SEARCH INTO "SEARCH & REPLACE" {{{3
-- Transform commandline search into "search & replace" while keeping any
-- existing user entered search patterns.
-- TODO: If visual mode is active, keep that in mind e.g. `:'<,'>s/`.
-- FIXME: As of now if visual mode is selected, we get `:'<,'>%s/`, note the `%`
vim.keymap.set("c", "<m-r>", function()
  local existing_search_pattern = vim.fn.getcmdline()
  local new_command = ":%s/" .. existing_search_pattern .. "//gc"
  vim.fn.feedkeys(
    vim.api.nvim_replace_termcodes("<c-c>", true, true, true),
    "n"
  )
  vim.fn.feedkeys(new_command, "n")
  vim.fn.feedkeys(
    vim.api.nvim_replace_termcodes("<left><left><left>", true, true, true),
    "n"
  )
end, {
  noremap = true,
  desc = [[Transform search into "search and replace"]],
})

-- WRAP TEXT {{{2
-- SOFT WRAP TEXT (TEXT VIEW){{{3
-- Soft wrap text view for readability etc.
-- NOTE: Cnly the displayed "text view" is wrapped, not actual text content.
vim.api.nvim_create_user_command("WrapSoft", function()
  vim.wo.wrap = true -- Wrap only on display not content
  vim.wo.linebeak = true -- Break lines smartly
end, {
  bang = true,
  nargs = 0,
  desc = "Soft warp text view for readability(text not changed)",
})

-- TODO: HARD WRAP TEXT (TEXT CONTENT){{{3
-- Hard wrap text content for readability etc.
-- NOTE: Text content is changed if necessary.
vim.api.nvim_create_user_command("WrapSoft", function()
  -- TODO: This is a stub, Customize hard wrap with preferences. Be gentle.
end, {
  bang = true,
  nargs = 0,
  desc = "Hard warp text content(text might change)",
})

-- SELECT ITEM AND CLOSE QUICKFIX/LOCLIST  {{{2
vim.api.nvim_create_autocmd("FileType", {
  desc = "Select item and close quickfix/location list",
  group = utilities_augroup,
  pattern = { "qf" }, -- Matches both quickfix and location list
  callback = function()
    vim.keymap.set(
      "n",
      "<s-cr>",
      "<cr><cmd>cclose<cr><cmd>lclose<cr>", -- NOTE: Unable to convert to lua
      {
        silent = true,
        buffer = true,
        desc = "Select item and close quickfix/loclist",
      }
    )
  end,
})

-- RESTORE QUICKFIX SELECTION KEYMAP(`<cr>`) {{{2
-- Restore default item selection behavior of `<cr>` in quickfix/loclist,
-- because I tend to override `<cr>` in plugin configs etc. e.g. "mini.map".
vim.api.nvim_create_autocmd("FileType", {
  desc = "Restore `<cr>` original selection behavior in quickfix",
  group = utilities_augroup,
  pattern = { "qf" }, -- Matches both quickfix and location list
  callback = function()
    vim.keymap.set("n", "<cr>", "<cr>", {
      silent = true,
      buffer = true,
      desc = "Select item in current line inside quickfix window",
    })
  end,
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
    -- TODO: See if you can do this without switching to each tab
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
-- - ISSUE: first word will pass fine, words after when going up with k move
--   into space and copy that space along with word. If i use a h to just go
--   back one letter, them the entire keymap fails because there is no h on the
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

-- GET HIGHLIGHT GROUP NAME UNDER CURSOR {{{2
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

-- OPEN COMMAND LINE PREFILLED WITH `:=` AND `:lua ` {{{2
-- This is to make it easy/fast to type lua expressions into the command line.
-- PREFILL `:=` {{{3
-- FIXME: 05MAR2025: Unable to get `vim.keymap.set()` version to work.
vim.cmd([[nnoremap <m-s-;> :=]]) -- i.e. `<m-:>`
-- TODO: PREFILL `:lua `: {{{3
-- NOTE: Ignoring this for lack of a good keymap(`<m-l>` is already in use).
-- vim.keymap.set( "n", "TODO", ":lua ",
--   { silent = true, desc = "Open commandline prefilled with `:lua `" }
-- )

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

-- INSERT WHITESPACE WITHOUT MOVING CURSOR IN INSERT MODE {{{2
-- TODO: Consider variants that accept a count (note that this is insert mode).
-- SPACE {{{3
vim.keymap.set("i", "<m-space>", "<space><c-o>h", {
  silent = true,
  desc = "Insert space without moving cursor",
})

-- TAB {{{3
vim.keymap.set("i", "<m-tab>", function()
  local cursor_position = vim.api.nvim_win_get_cursor(0)
  vim.cmd.normal({ "i\t", bang = true })
  vim.api.nvim_win_set_cursor(0, cursor_position)
  vim.cmd.startinsert()
end, {
  silent = true,
  desc = "Insert tab without moving cursor",
})

-- NEWLINE {{{3
-- ABOVE:
vim.keymap.set("i", "<m-O>", function()
  local cursor_position = vim.api.nvim_win_get_cursor(0)
  vim.cmd.normal({ "O", bang = true })
  vim.api.nvim_win_set_cursor(0, { cursor_position[1] + 1, cursor_position[2] })
  vim.cmd.startinsert()
end, {
  silent = true,
  desc = "Insert new line above, without moving cursor",
})
-- BELOW:
vim.keymap.set("i", "<m-o>", function()
  local cursor_position = vim.api.nvim_win_get_cursor(0)
  vim.cmd.normal({ "o", bang = true })
  vim.api.nvim_win_set_cursor(0, cursor_position)
  vim.cmd.startinsert()
end, {
  silent = true,
  desc = "Insert new line below, without moving cursor",
})

-- DE-INDENT IN INSERT MODE WITH `<s-tab>`{{{2
vim.keymap.set("i", "<s-tab>", "<c-d>", {
  silent = true,
  desc = "Delete indent",
})

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

-- RESTORE `<c-i>` TO DISTINGUISH IT FROM `<tab>` KEYMAPS {{{2
-- NOTE: `<c-i>` and `<tab>` are same in vim but, thankfully, different in nvim
-- and so allows them to be used in different keymaps, however, by default,
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
-- NOTE: Keymap `yom` is in the style of `tpope/vim-unimpaired`
-- TODO: Use lua
-- TODO: Add keymap descriptions
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
vim.keymap.set("n", "[om", function()
  vim.bo.modifiable = false
end, { silent = true })
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
--    or keep doing current behavior of duplicating another line
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
-- NOTE: Using `g` menmonic instead of `s`(`signcolumn`) because `g` can be
-- "gutter" but primarily because `s` is being used for `spell`.
-- TOGGLE GUTTER (SIGN COLUMN):
-- NOTE: Not dealing with `set signcolumn=auto` because it complicates keymaps.
vim.keymap.set("n", "yog", function()
  -- NOTE: When enabling `signcolumn`, setting it to `yes` and not `auto`.
  if vim.wo.signcolumn ~= "no" then -- NOTE: `signcolumn` can be no/yes/auto
    vim.wo.signcolumn = "no"
  else
    vim.wo.signcolumn = "yes"
  end
end, {
  silent = true,
  desc = "Toggle gutter (`signcolumn`)",
})
-- TURN ON GUTTER (SIGN COLUMN):
vim.keymap.set("n", "]og", "<cmd>setlocal signcolumn=yes<cr>", {
  silent = true,
  desc = "Enable gutter (`signcolumn`)",
})
-- TURN OFF GUTTER (SIGN COLUMN):
vim.keymap.set("n", "[og", "<cmd>setlocal signcolumn=no<cr>", {
  silent = true,
  desc = "Disable gutter (`signcolumn`)",
})

-- SCROLL OTHER WINDOW {{{2
-- TODO: Apply to both "scroll" and "movement" nromal mode commands present
-- in `scroll.txt`.
-- TODO: Treating "OTHER WINDOW" as previous window(`<c-w>p`) by default, but
-- allow that to be configured with a given "window id".
-- TODO: Create commands like `ScrollOtherWindowUpNLines` etc.
-- TODO: Fix table structure after finishing TODO's.

-- NOTE: KEYMAP GRAMMAR:
-- +------------------------------------------+----------+--------------------+
-- | DESCRIPTION                              | THIS     | MY KEYMAP          |
-- |                                          | WINDOW   | TO RUN COMMAND     |
-- |                                          | COMMAND  | IN OTHER WINDOW    |
-- | SCROLLING VERTICALLY: -------------------+----------+--------------------+
-- |                                          |          |                    |
-- | Scroll window up by [count] line(s)      | `<c-y>`  | `<m-c-y>`          |
-- | Scroll window down by [count] line(s)    | `<c-e>`  | `<m-c-e>`          |
-- |                                          |          |                    |
-- | Scroll window up by [count] times        | `<c-u>`  | `<m-c-u>`          |
-- | `scroll` (default is half screen)        |          |                    |
-- | Scroll window down by [count] times      | `<c-d>`  | `<m-c-d>`          |
-- | `scroll` (default is half screen)        |          |                    |
-- |                                          |          |                    |
-- | Scroll window [count] pages forwards     | `<c-f>`  | `<m-c-f>`          |
-- | (downwards)                              |          |                    |
-- | Scroll window [count] pages backwards    | `<c-b>`  | `<m-c-b>`          |
-- | (upwards)                                |          |                    |
-- |                                          |          |                    |
-- | TODO: SCROLLING VERTICALLY RELATIVE TO CURSOR: -----+--------------------+
-- |                                          |          |                    |
-- |                                          | `z<cr>`  | TODO: `<m-z><m-cr>`|
-- |                                          | `zt`     | TODO: `<m-z><m-t>` |
-- |                                          | `z.`     | TODO: `<m-z><m-.>` |
-- |                                          | `zb`     | TODO: `<m-z><m-b>` |
-- |                                          |          |                    |
-- | MOVING CURSOR LINE VERTICALLY: ----------+----------+--------------------+
-- | [count] lines downwards                  | `j`      | `<m-c-j>`          |
-- | [count] lines upwards                    | `k`      | `<m-c-k>`          |
-- |                                          |          |                    |
-- +------------------------------------------+----------+--------------------+

-- NOTE: This is currently bound to run given normal command  in "previous"
-- window only. Add variant with a configurable "other" window.
local run_scroll_command_in_previous_window = function(scroll_command)
  -- TODO: Switch terminology/features from "previous" to "other" window.
  -- TODO: SMALL OPTIMIZATION: Only use a count if `vim.v.count1 > 1`.
  return function()
    return "<c-w>p" .. vim.v.count1 .. scroll_command .. "<c-w>p"
  end
end

vim
  .iter({
    -- TODO: Separate into sections similar to the grammar table.
    {
      key = "<m-c-y>",
      scroll_command = "<c-y>",
      desc = "Scroll previous window upwards",
    },
    {
      key = "<m-c-e>",
      scroll_command = "<c-e>",
      desc = "Scroll previous window downwards",
    },
    {
      key = "<m-c-u>",
      scroll_command = "<c-u>",
      desc = "Scroll previous window up half page(`scroll`)",
    },
    {
      key = "<m-c-d>",
      scroll_command = "<c-d>",
      desc = "Scroll previous window down half page(`scroll`)",
    },
    {
      key = "<m-c-f>",
      scroll_command = "<c-f>",
      desc = "Scroll previous window page forward",
    },
    {
      key = "<m-c-b>",
      scroll_command = "<c-b>",
      desc = "Scroll previous window page backward",
    },
    {
      key = "<m-c-j>",
      scroll_command = "j",
      desc = "Move previous window cursor line downwards",
    },
    {
      key = "<m-c-k>",
      scroll_command = "k",
      desc = "Move previous window cursor line upwards",
    },
  })
  :map(function(item)
    vim.keymap.set(
      "n",
      item.key,
      run_scroll_command_in_previous_window(item.scroll_command),
      { silent = true, expr = true, desc = item.desc }
    )
  end)

-- SELECT PREVIOUS INSERTED/YANKED TEXT {{{2
-- NOTE: Inspired by github.com/justinmk/config/.../keymaps.lua
vim.keymap.set(
  "n",
  "gV",
  "`[v`]",
  { desc = "Select previous inserted/yanked text" }
)

-- MAKE `n`/`N` REPEAT SEARCH CONSISTENTLY {{{2
-- Make `n`/`N` always search in the same/opposite direction of initial search,
-- regardless of whether it was during `/`(forward) or `?`(backward) search.
-- NOTE: Inspired by github.com/justinmk/config/.../keymaps.lua
vim.keymap.set("n", "n", function()
  return vim.v.searchforward == 1 and "n" or "N"
end, {
  expr = true,
  desc = "Repeat search forward consistently",
})
vim.keymap.set("n", "N", function()
  return vim.v.searchforward == 1 and "N" or "n"
end, {
  expr = true,
  desc = "Repeat search backward consistently",
})

-- REMOVE DUPLICATES IN ARGLIST {{{2
local remove_duplicates_in_arglist = function()
  local arglist_items = vim.fn.argv()
  if #arglist_items == 1 or #arglist_items == 0 then
    vim.notify("No duplicates in `arglist`", vim.log.levels.INFO)
    return
  end
  local seen_items = {}
  local unique_items = {}
  for _, arg in ipairs(arglist_items) do
    local full_path = vim.fn.fnamemodify(arg, ":p") -- Use full paths to detect duplicates better.
    if not seen_items[full_path] then
      seen_items[full_path] = true
      table.insert(unique_items, arg)
    end
  end
  if #unique_items < #arglist_items then
    vim.cmd.argdelete("*") -- Clear current arglist to create anew.
    if #unique_items > 0 then
      for _, arg in ipairs(unique_items) do
        vim.cmd.argadd(arg)
      end
    end
    vim.notify(
      string.format(
        "Removed %d duplicate(s) from `arglist`",
        #arglist_items - #unique_items
      ),
      vim.log.levels.INFO
    )
  else
    vim.notify("No duplicates in `arglist`", vim.log.levels.INFO)
  end
end
vim.api.nvim_create_user_command("RemoveDuplicatesInArglist", function()
  remove_duplicates_in_arglist()
end, {
  desc = "Remove duplicates in `arglist`",
})

-- TOGGLE CURSOR LINES {{{2
-- TODO: Consider using `-` and `|` so like  `yo-` and `yo|`?

-- LOAD NEOVIM CONFIG (`init.lua`) {{{2
-- NOTE:
--  - `<leader>v`: Open `init.lua` in current window.
--  - `<leader>V`: Open `init.lua` in a new tab.
do
  local neovim_config_init_filename = "init.lua"
  local neovim_config_init_full_path =
    vim.fs.joinpath(vim.fn.stdpath("config"), neovim_config_init_filename)
  -- OPEN IN CURRENT WINDOW:
  vim.keymap.set("n", "<leader>v", function()
    local ok, err = pcall(vim.cmd.edit, neovim_config_init_full_path)
    if not ok then
      vim.notify(
        "ERROR: Failed to open `init.lua` neovim config file: " .. err,
        vim.log.levels.ERROR
      )
    end
  end, {
    silent = true,
    desc = "Open `init.lua` neovim config file in current window",
  })
  -- OPEN IN NEW TAB:
  vim.keymap.set("n", "<leader>V", function()
    local ok, err = pcall(vim.cmd.tabedit, neovim_config_init_full_path)
    if not ok then
      vim.notify(
        "ERROR: Failed to open `init.lua` neovim config file: " .. err,
        vim.log.levels.ERROR
      )
    end
  end, {
    silent = true,
    desc = "Open `init.lua` neovim config file in a new tabpage",
  })
end

-- PRINT/INSPECT HELPER {{{2
P = function(...)
  print(vim.inspect(...))
end

-- OPEN (NEO)VIM HELP FOR WORD {{{3
-- NOTE: Inspired by github.com/justinmk/config/.../keymaps.lua
-- NOTE: Elsewhere in my configuration, I have some code that will always open
-- `help` in a separate tab, so that's what's happening if `open_in_tab =
-- false` is still opening the help page in a new tab.
local open_vim_help_for = function(word, open_in_tab)
  word = vim.trim(word or "")
  if word == "" or word:find("%s") then
    error("Help topic nees to be a single non-empty word")
  end
  local cmd = string.format("%shelp %s", open_in_tab and "tab " or "", word)
  local ok = pcall(vim.cmd, cmd)
  if not ok then
    vim.notify(
      "ERROR: Unable to open help for: `" .. word .. "`",
      vim.log.levels.ERROR
    )
    return
  end
end

vim.keymap.set("n", "vK", function()
  open_vim_help_for(
    vim.fn.expand("<cword>"),
    true -- open in tab
  )
end, { desc = "Show vim help for word under cursor" })

vim.keymap.set("v", "vK", function()
  local s, e = vim.fn.getpos("'<"), vim.fn.getpos("'>")
  if s[3] > e[3] then
    -- Handle reverse selection case by ensuring "start_column" <= "end_column"
    s, e = e, s
  end
  open_vim_help_for(
    table.concat(
      vim.api.nvim_buf_get_text(0, s[2] - 1, s[3] - 1, e[2] - 1, e[3], {}),
      " "
    ),
    true -- open in tab
  )
end, { desc = "Show vim help for word in selection" })

-- `make` SHORTCUTS {{{2
-- NOTE: Keep keymaps in tandem with equivalents in fish shell config and
-- terminal hailing keymaps.
-- NOTE: `<m-*>` for horizontal splits and `<s-m-*>` for vertical splits.
-- NOTE: Doing both  `<s-m-m><m-*>` and `<s-m-m><s-m-*>` versions to account
-- for accidentally holding the shift modifier too long.
vim
  .iter({
    -- { keymap_suffix(i.e. "*" in `<m-m><m-*>`), make_command }
    { "m", "make" },
    { "b", "make build" },
    { "r", "make run" },
    { "c", "make clean" },
    { "f", "make fmt" },
    { "t", "make test" },
  })
  :map(function(v)
    local horizontal_split_keymap_prefix = "<m-m>"
    local vertical_split_keymap_prefix = "<s-m-m>"
    local keymap_suffix = v[1]
    local make_command = v[2]
    -- Horizontal split with `<m-m><m-*>`
    vim.keymap.set(
      "n",
      horizontal_split_keymap_prefix .. "<m-" .. keymap_suffix .. ">",
      "<cmd>horizontal botright split term://" .. make_command .. "<cr>",
      {
        silent = true,
        desc = "Run `" .. make_command .. "` in a horizontal split terminal ",
      }
    )
    -- Vertical split with `<m-m><m-*>`
    vim.keymap.set(
      "n",
      vertical_split_keymap_prefix .. "<m-" .. keymap_suffix .. ">",
      "<cmd>vertical rightbelow split term://" .. make_command .. "<cr>",
      {
        silent = true,
        desc = "Run `" .. make_command .. "` in a vertical split terminal ",
      }
    )
    -- Vertical split with both keys using shift with `<s-m-m><s-m-*>`
    vim.keymap.set(
      "n",
      vertical_split_keymap_prefix .. "<s-m-" .. keymap_suffix .. ">",
      "<cmd>vertical rightbelow split term://" .. make_command .. "<cr>",
      {
        silent = true,
        desc = "Run `" .. make_command .. "` in a vertical split terminal ",
      }
    )
  end)

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
vim.keymap.set("x", "<c-s>", "<c-c>:<c-u>update<cr>", { silent = true })
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
    vim.keymap.set({ "n", "x" }, ",a", f, { desc = desc, buffer = bufnr })
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
      function()
        -- TODO: Make more readable i.e. better than current raw JSON output.
        vim.notify(
          vim.inspect(vim.lsp.buf.list_workspace_folders()),
          vim.log.levels.INFO
        )
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
  -- TODO: Add keymap and command to start/stop/toggle LSP (`lspconfig`)
  local toggle_lspconfig_lsp = function()
    -- TODO: Check if able to receive `client` via argument from
    -- `common_on_attach` rather than getting all active clients again here
    local active_clients = vim.lsp.get_active_clients()
    if vim.tbl_isempty(active_clients) then
      vim.cmd("LspStart")
      vim.notify("Starting LSP (lspconfig)", vim.log.levels.INFO)
    else
      vim.cmd("LspStop")
      local display_message = "Stopping LSP (lspconfig)"
      -- FIXME: Fix message display format.
      for _, client in ipairs(active_clients) do
        display_message = display_message .. " : " .. client.name
      end
      vim.notify(display_message, vim.log.levels.INFO)
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
    vim.cmd("LspStart")
    vim.notify("Starting LSP (lspconfig)", vim.log.levels.INFO)
  end, { desc = "Start LSP (lspconfig)" })
  vim.api.nvim_create_user_command("StartLSPConfig", function()
    vim.cmd("LspStart")
    vim.notify("Starting LSP (lspconfig)", vim.log.levels.INFO)
  end, { desc = "Start LSP (lspconfig)" })
  vim.keymap.set("n", "]o,", function()
    vim.cmd("LspStop")
    vim.notify("Stopping LSP (lspconfig)", vim.log.levels.INFO)
  end, { desc = "Stop LSP (lspconfig)" })
  vim.api.nvim_create_user_command("StopLSPConfig", function()
    vim.cmd("LspStop")
    vim.notify("Stopping LSP (lspconfig)", vim.log.levels.INFO)
  end, { desc = "Stop LSP (lspconfig)" })
end

-- LSP FORMATTING {{{2
local set_common_lsp_formatting = function(opts)
  -- NOTE:
  -- 1. PREFER SYNC FORMATTING
  --  REASON: https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Formatting-on-save#async-formatting
  -- 2. RECOMMENDED KEYMAPPING CONVENTION:
  --  <lsp>f   : sync format    (primary e.g. via lspconfig)
  --  g<lsp>f  : async format   (primary e.g. via lspconfig)
  --  <lsp>F   : sync format    (secondary e.g. null-ls)
  --  g<lsp>F  : async format   (secondary e.g. null-ls)
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
    return opts.desired_client_name == nil
      or opts.desired_client_name == client.name
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
    local desc = "Show diagnostics floating window"
    local f = vim.diagnostic.open_float
    -- NOTE: Something like: `gd`, `<m-d>`, `,d`, ',?'
    vim.keymap.set("n", ",?", f, { desc = desc })
    vim.api.nvim_create_user_command("DiagnosticsShow", f, { desc = desc })
  end
  do
    local desc = "Close diagnostics floating window"
    local f = function()
      -- NOTE: Cannot target diagnostic windows specifically, so settling for
      -- closing all floating windows(by checking `relative` on all windows,
      -- which  should be set to `win` in floating windows.)
      for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
        if vim.api.nvim_win_get_config(win).relative == "win" then
          vim.api.nvim_win_close(win, true)
        end
      end
    end
    vim.keymap.set("n", ",z", f, { desc = desc })
    vim.api.nvim_create_user_command("DiagnosticsClose", f, { desc = desc })
  end
  do
    local desc = "Go to previous diagnostic"
    local f = function()
      vim.diagnostic.goto_prev()
      vim.diagnostic.open_float()
    end
    vim.keymap.set("n", "[,", f, { desc = desc })
    vim.api.nvim_create_user_command(
      "DiagnosticsGoToPrevious",
      f,
      { desc = desc }
    )
  end
  do
    local desc = "Go to next diagnostic"
    local f = function()
      vim.diagnostic.goto_next()
      vim.diagnostic.open_float()
    end
    vim.keymap.set("n", "],", f, { desc = desc })
    vim.api.nvim_create_user_command("DiagnosticsGoToNext", f, { desc = desc })
  end
  do
    local desc = "Go to previous `ERROR` diagnostic"
    local f = function()
      vim.diagnostic.goto_prev({
        severity = vim.diagnostic.severity.ERROR,
      })
      vim.diagnostic.open_float()
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
      vim.diagnostic.open_float()
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
        vim.notify("Enabling diagnostics", vim.log.levels.INFO)
      else
        vim.diagnostic.disable()
        vim.notify("Disabling diagnostics", vim.log.levels.INFO)
      end
    end
    vim.keymap.set("n", "yo,", f, { desc = desc })
    vim.api.nvim_create_user_command("DiagnosticsToggle", f, { desc = desc })
  end
end

-- LSP & DIAGNOSTICS CONFIGURATION {{{2
local set_common_lsp_and_diagnostics_configuration = function(_, bufnr)
  -- TODO: Show signature help in a float in insert mode?
  set_common_lsp_keymaps(bufnr)
  set_common_diagnostics_configuration()
end

-- LAZY PLUGIN MANAGER {{{1
-- LAZY SETUP {{{2
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    lazyrepo,
    lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({

  -- LAZY SETUP OPTIONS  {{{3
  install = { colorscheme = { "default" } },
  ui = { border = "rounded" },

  -- LAZY PLUGINS {{{2
  spec = {
    -- folke/snacks - indent/statuscolumn {{{3
    {
      "folke/snacks.nvim",
      opts = {
        indent = { -- {{{4
          -- FIXME: Disable changing cursor color when it goes on indent scope.
          -- TODO: Add user commands to enable/disable/toggle.
          -- TODO: Add unimpaired style keymaps(`yoi`) to enable/disable/toggle.
          animate = { -- NOTE: `animate` is v0.10+ only.
            style = "up_down",
            duration = {
              step = 20, -- ms per step, DEFAULT: 20
              total = 40, -- ms maximum duration, DEFAULT: 500
            },
          },
          -- TODO: Tone down default colors for both both un/focussed indents.
          -- TODO: Vary indent color based on depth (`:help snacks-indent.txt`).
          -- hl = { "SnacksIndent1" ... "SnacksIndent8", },
        },

        statuscolumn = { -- {{{4
          -- TODO: Switch to `luukvbaal/statuscol.nvim` ASAP.
        },
      },
    },

    -- visual-split - show reference in split {{{3
    -- TODO: Replace with own reference plugin
    {
      "wellle/visual-split.vim",
      init = function()
        -- TODO: Specify keymaps for lazy loading purposes in "keys"
        -- FIXME: `xmap`/`nmap` default keymaps `<c-w>gr` are unwanted, I want
        -- to use `<c-w>gsr` for them, but `xunmap` errors out and mapping it
        -- to `<nop>` works but is ugly, find a solution.
        -- VISUAL MODE
        vim.cmd([[
          xmap <c-w>gr <nop>
          xmap <c-w>gsr  <plug>(Visual-Split-VSResize)
          " xmap <c-w>gss <plug>(Visual-Split-VSSplit)
          " xmap <c-w>gsa <plug>(Visual-Split-VSSplitAbove)
          " xmap <c-w>gsb <plug>(Visual-Split-VSSplitBelow)
        ]])
        -- OPERATOR PENDING MODE
        vim.cmd([[
          nmap <c-w>gr <nop>
          nmap <c-w>gsr  <plug>(Visual-Split-Resize)
          "nmap <c-w>gss <plug>(Visual-Split-Split)
          "nmap <c-w>gsa <plug>(Visual-Split-SplitAbove)
          "nmap <c-w>gsb <plug>(Visual-Split-SplitBelow)
        ]])
      end,
      -- TODO: Specify user commands for lazy loading purposes.
      -- cmd = {
      --   "VSSplit", -- Respects `'splitbelow'` setting
      --   "VSSplitAbove", -- Create new split above current window
      --   "VSSplitBelow", -- Create new split below current window
      -- },
    },

    -- which-key - show keymaps {{{3
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

    -- key-analyzer - show vacant keymaps {{{3
    {
      "meznaric/key-analyzer.nvim",
      opts = {},
    },

    -- mini.surround - surrounding manipulation {{{3
    -- NOTE: Current line is indicated by `_` in this plugin.
    {
      "echasnovski/mini.surround",
      version = false,
      event = "VeryLazy",
      opts = {
        highlight_duration = 700, -- DEFAULT: 500
        search_method = "cover", -- DEFAULT: `cover`. TODO: Investigate this.
        mappings = {
          add = "sa", -- Normal and Visual modes
          delete = "sd",
          find_left = "sF", -- Find surrounding to left
          find = "sf", -- Find surrounding to right
          highlight = "sh",
          replace = "sr",
          update_n_lines = "sn",
          suffix_last = "N", -- Suffix to search with "prev", DEFAULT: `l`("last")
          suffix_next = "n", -- Suffix to search with "next", DEFAULT: `n`
        },
      },
    },

    -- abolish - search word variants {{{3
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

    -- endwise - complete "end" like keyword {{{3
    {
      "tpope/vim-endwise",
      event = "VeryLazy",
    },

    -- eunuch - unix helpers {{{3
    {
      "tpope/vim-eunuch",
      event = "VeryLazy",
    },

    -- liquid - jekyll support {{{3
    {
      "tpope/vim-liquid",
      event = "VeryLazy",
    },

    -- repeat - repeat last command {{{3
    {
      "tpope/vim-repeat",
      event = "VeryLazy",
    },

    -- rsi - readline insertion support  {{{3
    {
      "tpope/vim-rsi",
      event = "VeryLazy",
    },

    -- vinegar - netrw helpers {{{3
    {
      "tpope/vim-vinegar",
      event = "VeryLazy",
    },

    -- fugitive - git helper {{{3
    {
      "tpope/vim-fugitive",
      event = "VeryLazy",
      init = function()
        vim.api.nvim_create_user_command(
          "Gcommit",
          "G commit",
          { desc = "alias for fugitive's `G commit`" }
        )
      end,
    },

    -- flog - git helper {{{3
    -- TODO: CONSIDER: Give flog my main git overlay leader key, instead of
    -- "lazygit"? (as of now it is `<m-g>`).
    -- TODO: CONSIDER: Add keymap to show flog's git status split?
    -- FIXME: The commit marker dot symbol is not showing the same glyph in
    -- plugin's README screenshots, might be term issue.
    {
      "rbong/vim-flog",
      cmd = {
        "Flog",
        "Flogsplit",
        -- "Floggit",
      },
      keys = {
        {
          "<leader>g",
          "<cmd>Flogsplit<cr>",
          mode = "n",
          desc = "Open flog git log in split",
        },
        {
          "<leader>G",
          "<cmd>Flog<cr>",
          mode = "n",
          desc = "Open flog git log in new tab",
        },
      },
      dependencies = {
        "tpope/vim-fugitive",
      },
    },

    -- unimpaired(lua) - essential togglge/navigation keymaps {{{3
    -- NOTE: Replacing `tpope/vim-unimpaired` because I want to choose defaults
    {
      "tummetott/unimpaired.nvim",
      lazy = false,
      opts = {
        default_keymaps = false,
        keymaps = {
          -- NOTE: Disabled because I don't use them enough to warrant a keymap:
          -- - FILE NAVIGATION
          -- - VCS(SCM/GIT) MARKER NAVIGATION
          -- - CASE SENSITIVITY IN SEARCH PATTERNS
          -- - LIST CHARACTERS
          -- - COLOR COLUMN
          -- - VIRTUAL EDIT
          -- - TEXT WRAPPING
          --
          -- NOTE: Disabled in favor of 3rd party plugins:
          -- - TEXT MOVEMENT(EXCHANGE) -- Replacing with `mini.move`
          --
          -- NOTE: Disabled because v0.11+ comes with these built-in:
          -- - ARGUMENT LIST NAVIGATION
          -- - BUFFER NAVIGATION
          -- - TAG NAVIGATION
          -- - LOCATION LIST NAVIGATION
          -- - QUICKFIX LIST NAVIGATION
          -- - ADD EMPTY LINE ABOVE/BELOW
          --
          -- NOTE: My currently active keymaps:
          -- SEARCH HIGHLIGHTS:
          enable_hlsearch = "[oh", -- DEFAULT
          disable_hlsearch = "]oh", -- DEFAULT
          toggle_hlsearch = "yoh", -- DEFAULT
          -- LINE NUMBERS:
          enable_number = "[on", -- DEFAULT
          disable_number = "]on", -- DEFAULT
          toggle_number = "yon", -- DEFAULT
          enable_relativenumber = "[oN", -- DEFAULT `r`
          disable_relativenumber = "]oN", -- DEFAULT `r`
          toggle_relativenumber = "yoN", -- DEFAULT `r`
          -- SPELL CHECK:
          enable_spell = "[os", -- DEFAULT
          disable_spell = "]os", -- DEFAULT
          toggle_spell = "yos", -- DEFAULT
          -- BACKGROUND:
          enable_background = "[ob", -- DEFAULT
          disable_background = "]ob", -- DEFAULT
          toggle_background = "yob", -- DEFAULT
          -- CURSOR LINE & CURSOR COLUMN:
          enable_cursorline = "[o_", -- DEFAULT `c`
          disable_cursorline = "]o_", -- DEFAULT `c`
          toggle_cursorline = "yo_", -- DEFAULT `c`
          enable_cursorcolumn = "[o|", -- DEFAULT `u`
          disable_cursorcolumn = "]o|", -- DEFAULT `u`
          toggle_cursorcolumn = "yo|", -- DEFAULT `u`
          enable_cursorcross = "[o+", -- DEFAULT `x`
          disable_cursorcross = "]o+", -- DEFAULT `x`
          toggle_cursorcross = "yo+", -- DEFAULT `x`
        },
      },
    },

    -- mini move - text movement {{{3
    {
      "echasnovski/mini.move",
      version = false,
      event = "VeryLazy",
      opts = {
        --[[
        mappings = {
          -- WARN: KEYMAP CONFLICT ALERT: I use keymaps
          -- `<m-left/right/up/down>` in section "LINE SPLIT PUSHES" where they
          -- play a major role.
          -- NOTE: `''` (empty string) disables option.
          -- NOTE: Plugin comes with default keymaps `<m-h/j/k/l>`.
          -- VISUAL SELECTION MODE:
          left = "<m-left>",
          right = "<m-right>",
          down = "<m-down>",
          up = "<m-up>",
          -- NORMAL MODE("linewise" mode):
          line_left = "<m-left>",
          line_right = "<m-right>",
          line_down = "<m-down>",
          line_up = "<m-up>",
        },
        --]]
      },
      init = function()
        -- NOTE: I don't want to set these keymaps officially as they might
        -- change, so temporarily setting them here manually.
        vim.keymap.set("n", "<m-up>", function()
          MiniMove.move_line("up")
        end, { desc = "Move line upwards" })
        vim.keymap.set("n", "<m-down>", function()
          MiniMove.move_line("down")
        end, { desc = "Move line downwards" })
        vim.keymap.set("x", "<m-up>", function()
          MiniMove.move_selection("up")
        end, { desc = "Move visual selection upwards" })
        vim.keymap.set("x", "<m-down>", function()
          MiniMove.move_selection("down")
        end, { desc = "Move visual selection downwards" })
      end,
    },

    -- mini align - text alignment {{{3
    {
      "echasnovski/mini.align",
      version = false, -- KEEP(version): as per docs
      event = "VeryLazy",
      lazy = false,
      opts = {
        mappings = {
          start_with_preview = "ga",
          start = "gA",
        },
      },
    },

    -- treesj/mini.splitjoin -- split join expressions {{{3
    {
      "Wansmer/treesj",
      -- NOTE:
      -- 1. Only keep 1 keymap - toggle.
      -- 2. Removing insert mode completion due to issue with returning to
      --    insert mode afterwards.
      -- TODO:
      -- 1. Make `mini.splitjoin` add trailing comma on last item in relevant
      --    areas for relevant filetypes.
      --    EXAMPLES:
      --    - github.com/jackieaskins/dotfiles/blob/main/nvim/lua/plugins/mini-splitjoin.lua
      --    - github.com/sid-6581/NeovimConfig/blob/main/lua/plugins/mini_splitjoin.lua
      event = "VeryLazy",
      opts = { use_default_keymaps = false },
      cmd = {
        "TSJToggle",
        "TSJSplit",
        "TSJJoin",
      },
      keys = {
        {
          "<c-t>",
          mode = "n",
          function()
            if
              -- treesj supports current buffer filetype?
              vim.list_contains(
                require("treesj.langs")["presets"],
                vim.bo.filetype
              )
            then
              require("treesj").toggle()
            else
              require("mini.splitjoin").toggle()
            end
          end,
          desc = "Toggle split-join on node under cursor",
        },
      },
      dependencies = {
        "nvim-treesitter/nvim-treesitter",
        {
          "echasnovski/mini.splitjoin",
          version = "*",
          -- NOTE: Disable default keymaps because this is here as backup only
          opts = { mappings = { toggle = "", split = "", join = "" } },
        },
      },
    },

    -- mini.trailspace - highlight/trim trailing whitespace {{{3
    -- NOTE: I'm using this plugin to highlight trailing whitespace only, not
    -- trim it because I'm using `vim-strip-trailing-whitespace` for trimming
    -- due to git-related nuances.
    -- TODO: This behavior can be performed by another `mini` plugin
    -- `mini.hipatterns`. Consider jsut removing this plugin in favor of that?
    {
      "echasnovski/mini.trailspace",
      version = false,
      opts = {
        -- only_in_normal_buffers = true, -- DEFAULT
      },
    },

    -- strip-trailing-whitespace - strip trailing whitespace {{{3
    -- TODO: Strip only in vcs(git) changed files.
    -- NOTE: This plugin is not currently being used for highlighting.
    -- NOTE: Strips trailing whitespace on changed lines only. To strip
    -- trailing whitespace on all lines in entire file, use command
    -- `:StripTrailingWhitespace`. Do not replace with a similar plugin,
    -- because they likely don't respect this behavior.
    "axelf4/vim-strip-trailing-whitespace",

    -- visual-whitespace - show whitespace in visual selections {{{3
    {
      "mcauley-penney/visual-whitespace.nvim",
      -- NOTE: Not using visual mode keys to lazy load as recommended by plugin
      -- docs, because it misses situations like selections made by mouse etc.
      event = "VeryLazy",
      opts = {
        -- highlight = { link = "Visual" }, FIXME: Make highlight standout less.
        -- excluded = { filetypes = {}, buftypes = {}, },
        -- space_char = "·", -- DEFAULT: ·
        tab_char = "¬", -- OPTIONS: ¬ ⇥ ─ DEFAULT: →
        nl_char = "", -- DEFAULT: ↲
        cr_char = "", -- DEFAULT: ←
      },
    },

    -- emmet - html completions {{{3
    {
      "mattn/emmet-vim",
      event = "VeryLazy",
    },

    -- mini.animate - animate movements/actions {{{3
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

    -- mini.map - sidebar minimap {{{3
    {
      "echasnovski/mini.map",
      event = "VeryLazy",
      keys = function()
        local minimap = require("mini.map")
        return {
          {
            "<cr>",
            function()
              minimap.toggle()
            end,
            desc = "Toggle mini map",
          },
          {
            "<m-cr>",
            function()
              minimap.toggle_focus({ use_previous_cursor = false })
            end,
            desc = "Toggle mini map focus",
          },
          {
            "<s-cr>",
            function()
              minimap.toggle_side()
            end,
            desc = "Toggle mini map side",
          },
        }
      end,
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
            winblend = 20,
            show_integration_count = false,
            -- NOTE: `width = 1` for just scrollbar, mind the whitespace
            width = 5,
            -- NOTE: Setting `focusable` to false, still allows for
            -- `minimap.toggle_focus()` to work.
            -- TODO: I'm using `<m-cr>` to toggle focus on mini.map window. But
            -- I wouldn't like to do the same with mouse click though. Instead
            -- I would like mouse click to act like `<cr>` inside the map i.e.
            -- return to clicked area indicated by map. Add an autocommand for
            -- this behavior.
            focusable = false,
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
            -- NOTE:L Set both scroll values the same; distinguish by color
            scroll_line = "│",
            scroll_view = "│",
          },
        }
      end,
      dependencies = { "lewis6991/gitsigns.nvim" },
    },

    -- smartcolumn - line over limit indicator {{{3
    {
      "m4xshen/smartcolumn.nvim",
      opts = {
        colorcolumn = {
          "80", -- DEFAULT: Only 80
          "100",
        },
        disabled_filetypes = {
          -- DEFAULT: help, text, markdown,
          "alpha",
          "checkhealth",
          "lazy",
          "mason",
          "neo-tree",
          "orphans",
          "qf", -- quickfix/location list
        },
        custom_colorcolumn = {
          python = "80",
          gitcommit = { 50, 72 },
        },
        scope = "window", -- AVAILABLE: file/window/line
        -- DEFAULT: editorconfig = true, -- Uses `max_line_length`
      },
    },

    -- helpview - help file decorations {{{3
    {
      "OXY2DEV/helpview.nvim",
      lazy = false, -- NOTE: Disable lazy loading
      dependencies = { "nvim-treesitter/nvim-treesitter" },
    },

    -- other.nvim - open alternate files {{{3
    {
      "rgroli/other.nvim",
      -- FIXME: unable to detect "other" file in cargo projects
      -- TODO:
      -- 1. Consider using `tpope/vim-projectionist` instead becauses of it's
      --    simpler pattern specification i.e. `{}`.
      -- 1. Find good keymaps.
      -- 2. Add custom language/framework Heuristics instead of the provided
      --    built-ins.
      cmd = {
        "Other",
        "OtherTabNew",
        "OtherSplit",
        "OtherVSplit",
      },
      config = function()
        require("other-nvim").setup({
          {
            mappings = {
              "golang",
              "python",
              "rust",
            },
          },
        })
      end,
    },

    -- mini.hipatterns - highlight "pragma" patterns like `TODO`/`NOTE`… {{{3
    -- TODO: Add helpers to move between these pragmas.
    -- TODO: Add helpers to search among them inside project or current file.
    -- TODO: Replace my other trailing whitespace plugin with this plugin's
    -- similar feature.
    -- FIXME: Remove `folke/todo-comments.nvim` when done replacing it.
    {
      "echasnovski/mini.hipatterns",
      version = false,
      opts = function()
        local mini_extra_gen_highlighter_words =
          require("mini.extra").gen_highlighter.words
        -- USE CUSTOM HIGHLIGHT IN `GIT COMMIT CLOSES MARKER`:
        -- TODO: Use an API-style function to set highlight with backup.
        -- NOTE: Link to @keyword if defined, else fallback; reapplied on
        -- colorscheme change since highlights may reset
        local function set_git_commit_closer_marker_highlight()
          local ok, keyword_highlight =
            pcall(vim.api.nvim_get_hl, 0, { name = "@keyword", link = false })
          local highlight_to_link_to = "MiniHipatternsNote" -- Use as default
          if
            ok -- `nvim_get_hl` may succeed even if highlight group is undefined
            and keyword_highlight --  Is a table (not nil or error),
            and next(keyword_highlight) ~= nil --  Has atleast 1 attr(`fg`/`bg`)
          then
            highlight_to_link_to = "@keyword"
          end
          vim.api.nvim_set_hl(
            0,
            "GitCommitClosesMarker",
            { link = highlight_to_link_to }
          )
        end
        set_git_commit_closer_marker_highlight() -- Apply now
        vim.api.nvim_create_autocmd("ColorScheme", {
          -- Reapply when colorscheme changes, as highlights may be cleared
          callback = set_git_commit_closer_marker_highlight,
        })
        return {
          highlighters = {
            -- TODO: Try to get preceding space as padding inside the highlight
            -- like `folke/todo-comments.nvim` does.
            -- TODO: MAIN FUNCTIONS:
            -- GIT COMMIT MESSAGE "CLOSES" KEYWORD HIGHLIGHTER(Closes/Fixes/Resolves):
            -- TODO: Make a generator for these:
            git_closes = {
              pattern = function(buf_id)
                if vim.bo[buf_id].filetype == "gitcommit" then
                  return "^%s*()[Cc][Ll][Oo][Ss][Ee][SsDd]?():?[ ]+"
                end
              end,
              group = "MiniHipatternsNote",
            },
            git_resolves = {
              pattern = function(buf_id)
                if vim.bo[buf_id].filetype == "gitcommit" then
                  return "^%s*()[Rr][Ee][Ss][Oo][Ll][Vv][Ee][SsDd]+():?[ ]+"
                end
              end,
              group = "MiniHipatternsNote",
            },
            git_fixes = {
              -- FIXME: Unlike "closes" and "resolves", this "fixes" pattern
              -- will end up allowing "wrong" words like `fixd`/`fixs`/`fixe`.
              -- I'm allowing that to keep the pattern here simple as can't
              -- seem to use `|` or `(...)` within the selection boundaries
              -- `()..()` in these patterns.
              pattern = function(buf_id)
                if vim.bo[buf_id].filetype == "gitcommit" then
                  return "^%s*()[Ff][Ii][Xx][Ee]?[SsDd]?():?[ ]+"
                end
              end,
              group = "MiniHipatternsNote",
            },
            -- TODO: HEX COLORS:
            -- PRAGMAS:
            -- TODO: Consider frontier matching(SEE PLUGIN helpdocs).
            -- TODO: Fill quickfix/location_list/picker with matches.
            TODO = mini_extra_gen_highlighter_words(
              { "TODO" },
              "MiniHipatternsTodo"
            ),
            NOTE = mini_extra_gen_highlighter_words(
              { "NOTE" },
              "MiniHipatternsNote"
            ),
            WARN = mini_extra_gen_highlighter_words(
              { "WARN" },
              "MiniHipatternsHack"
            ),
            FIXME = mini_extra_gen_highlighter_words(
              { "FIXME" },
              "MiniHipatternsFixme"
            ),
            XXX = mini_extra_gen_highlighter_words(
              { "XXX" },
              "MiniHipatternsHack"
            ),
          },
        }
      end,
      dependencies = { "echasnovski/mini.extra", version = false },
    },

    -- boole - toggle/invert current word {{{3
    {
      "nat-418/boole.nvim",
      -- NOTE: Use `allow_caps_additions` over `additions` to preserve case.
      -- TODO:
      -- 1. Disable unnecessary default values. See source for examples.
      -- 2. Allow symbol pairs like`==`/`!=`, `&&`/`||` etc.
      opts = {
        mappings = { increment = "<c-a>", decrement = "<c-x>" },
        -- i.e. enable/disable, Enable/Disable, ENABLE/DISABLE
        allow_caps_additions = {
          { "true", "false" },
          { "enable", "disable" },
          { "before", "after" },
          { "enabled", "disabled" },
          { "enables", "disables" },
          { "right", "left" },
          { "up", "down" },
          { "top", "bottom" },
          { "with", "without" },
          { "yes", "no" },
          { "on", "off" },
          { "and", "not", "or" },
          { "if", "then", "else", "elif", "end" }, -- TODO: Split per language
          { "const", "let", "var" }, -- TODO: Split per language
          { "struct", "enum", "impl" }, -- TODO: Split per language
          -- `folke/todo-comments.nvim`
          { "TODO", "NOTE", "XXX", "WARN", "FIXME" },
          -- NOTE: Numbers up to 20 because it becomes 2 word numbers after that
          {
            "zero",
            "one",
            "two",
            "three",
            "four",
            "five",
            "six",
            "seven",
            "eight",
            "nine",
            "ten",
            "eleven",
            "twelve",
            "thirteen",
            "fourteen",
            "eighteen",
            "nineteen",
            "twenty",
          },
          {
            "first",
            "second",
            "third",
            "fourth",
            "fifth",
            "sixth",
            "seventh",
            "eighth",
            "ninth",
            "tenth",
            "eleventh",
            "twelfth",
            "thirteenth",
            "fourteenth",
            "fifteenth",
            "sixteenth",
            "seventeenth",
            "eighteenth",
            "nineteenth",
            "twentieth",
          },
        },
      },
    },

    -- e-ink.nvim - grayscale colorscheme {{{3
    {
      "alexxGmZ/e-ink.nvim",
      enabled = false,
      priority = 1000,
      init = function()
        vim.cmd.colorscheme("e-ink")
      end,
    },

    -- catppuccin - pastel colorscheme {{{3
    -- TODO: Use non-colorscheme features in this plugin
    {
      "catppuccin/nvim",
      enabled = true,
      name = "catppuccin", -- Keep, because "nvim"(of `catppuccin/nvim`) is bad
      priority = 1000, -- keep high for colorschemes
      opts = {
        -- FIXME: Flavor isn't working, so manually setting in `init` for now.
        flavor = "auto",
        -- flavor = "latte", -- lightest
        -- flavor = "frappe", -- muted
        -- flavor = "macchiato", -- gentle
        -- flavor = "mocha", -- darkest
        --
        -- TODO: Replace dedicated inactive window dimming plugin with this
        -- dim_inactive = {
        --   enabled = false,
        --   shade = "dark",
        --   percentage = 0.15, -- shade percentage
        -- },
      },
      init = function()
        vim.cmd.colorscheme(
          -- "catppuccin"
          -- catppuccin-macchiato"
          "catppuccin-mocha"
        )
      end,
    },

    -- tokyonight - folke colorscheme {{{3
    {
      "folke/tokyonight.nvim",
      enabled = false,
      priority = 1000, -- Keep high for colorschemes
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
      init = function()
        vim.cmd.colorscheme("tokyonight")
      end,
    },

    -- visual-split.vim - split from visual selection or text object {{{3
    {
      "wellle/visual-split.vim",
      -- TODO: Only going to be using "split", so remove "resize" keymaps and
      -- functions. Just use a single keymap and text object operator for
      -- "split above", for example: `<c-w>gv` or something shorter.
      event = "VeryLazy",
    },

    -- mini.statusline - statusline helper {{{3
    {
      "echasnovski/mini.statusline",
      version = false,
      opts = {
        content = {
          active = function()
            local mini_statusline = require("mini.statusline")
            -- PLUGIN FEATURES:
            local mode, mode_hl =
              mini_statusline.section_mode({ trunc_width = 120 })
            -- local git = mini_statusline.section_git({ trunc_width = 40, })
            local diff = mini_statusline.section_diff({
              trunc_width = 75,
              icon = "",
            })
            local diagnostics = mini_statusline.section_diagnostics({
              trunc_width = 75,
              icon = "",
            })
            -- TODO: Use something other than `++` to indicate LSPs.
            local lsp = mini_statusline.section_lsp({
              trunc_width = 75,
              icon = "",
            })
            local filename =
              mini_statusline.section_filename({ trunc_width = 140 })
            local general_truncate_point_marker = "%<"
            local end_left_alignment_marker = "%="
            -- CUSTOM FEATURES:
            local calculate_progress = function()
              local cur = vim.fn.line(".")
              local total = vim.fn.line("$")
              if cur == 1 then
                return "TOP"
              elseif cur == total then
                return "BOT"
              else
                return string.format("%2d%%%%", math.floor(cur / total * 100))
              end
            end
            local calculate_location = function()
              local col = vim.fn.charcol(".")
              local line = vim.fn.line(".")
              return string.format("%3d:%-2d", col, line)
            end
            local calculate_git_branch = function()
              local git_icon = "" -- FIXME: Get from `mini.icon`.
              local summary =
                -- FROM `mini.git`:
                vim.b.minigit_summary_string
                -- FROM `gitsigns`:
                or vim.b.gitsigns_head
              if summary == nil then
                return "" -- CWD NOT A GIT REPO
              elseif summary == "main" or summary == "master" then
                return git_icon -- CWD IS GIT PRIMARY BRANCH i.e.`main`/`master`
              else
                return git_icon .. " " .. summary
              end
            end
            local calculate_filetype_icon = function()
              local filetype_icon
              if filetype == nil or filetype == "" then
                filetype_icon = ""
              else
                local mini_icons = require("mini.icons")
                filetype_icon, _, _ = mini_icons.get("filetype", filetype)
              end
              return filetype_icon
            end
            local filetype = vim.bo.filetype or ""
            -- local filetype_icon = calculate_filetype_icon()
            local git_branch = calculate_git_branch()
            local progress = calculate_progress()
            local location = calculate_location()
            -- LAYOUT:
            -- TODO: Ensure each section has a highlight group, because if
            -- there isn't an assigned one, the section inherits the previous
            -- section's highlight group which might result in surprises.
            return mini_statusline.combine_groups({
              {
                hl = mode_hl,
                strings = { mode },
              },
              {
                hl = "MiniStatuslineDevinfo",
                strings = {
                  git_branch,
                  diff, -- TODO: Make diff coutns more pronounced
                },
              },
              general_truncate_point_marker,
              {
                hl = "MiniStatuslineFilename",
                strings = {
                  -- filetype_icon,
                  filename,
                },
              },
              end_left_alignment_marker,
              {
                -- hl = "MiniStatuslineDevinfo",
                strings = {
                  diagnostics,
                  lsp,
                },
              },
              {
                -- hl = "MiniStatuslineFileinfo",
                strings = {
                  -- fileinfo,
                  -- filetype_icon,
                  filetype,
                },
              },
              {
                -- hl = MiniStatuslineInactive,
                strings = {
                  progress,
                  location,
                },
              },
            })
          end,
        },
      },
      init = function()
        -- NOTE: While `mini.statusline` has a nice truncated view feature for
        -- compressed window statuslines, I still like having a single
        -- statusline.
        vim.go.laststatus = 3
      end,
      dependencies = {
        "echasnovski/mini.icons",
        "echasnovski/mini-git",
        "echasnovski/mini.diff",
      },
    },

    -- lualine - statusline helper {{{3
    -- FIXME: Transfer everything to `mini.statusline` and remove `lualine`.
    {
      "nvim-lualine/lualine.nvim",
      -- TODO: Consider moving to `echasnovski/mini.statusline`
      enabled = false,
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
                -- TODO: Extract into a lualine extension
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
                padding = 1,
              },
            },
            lualine_b = {
              {
                "branch",
                -- icon = "" -- Ideally this would be my icon of choice
                -- NOTE: In order to hide the `main` branch and showing my icon
                -- of choice the following "hack" needs to be done:
                -- 1. Set `icon` to a blank string
                -- 2. Set `padding` to accommodate hard-coded icon
                -- 3. Define `fmt` with hard-coded icon  of choice
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
              {
                "diff",
                colored = true,
                symbols = { added = "+", modified = "~", removed = "-" },
                padding = { left = 0, right = 1 },
              },
            },
            lualine_c = {
              {
                "filename",
                path = 1,
                symbols = {
                  unnamed = "NO NAME",
                  newfile = "NEW FILE",
                  modified = "+",
                  -- TODO: Show distinct symbols for `readonly` and
                  -- `modifiable` as the current default ``readonly = "[-]"` is
                  -- for both `readonly` and `nomodifiable`
                },
                padding = 1,
                -- NOTE: Hard coding `󰆧` to appear before aerial
                component_separators = { left = "󰆧", right = "" },
              },
              {
                "aerial",
                padding = { left = 1, right = 0 },
                colored = true,
                -- NOTE:  Show only 1 symbol, i.e. 'depth = -1'
                depth = -1,
                -- sep = "  ", -- →
                -- dense = true,
                -- dense_sep = "·", --  ·
              },
            },
            lualine_x = {
              {
                "diagnostics",
                -- NOTE: Equivalent custom "gitsign" symbols:  ""󰬌  󰬞  󰬐   "
                symbols = { error = "E", warn = "W", info = "I", hint = "H" },
              },
              -- NOTE: Preferring a simple buffer filetype
              -- {
              --   "filetype",
              --   icon_only = false,
              --   icon = { align = "right" },
              --   colored = false,
              --   padding = { left = 1, right = 1 },
              -- },
              "bo:filetype", -- TODO: Use uppercase
              { "progress", padding = { left = 1, right = 0 } },
              { "location", padding = { left = 1, right = 0 } },
            },
            lualine_y = {},
            lualine_z = {
              { "searchcount", padding = 1 },
              { "selectioncount", padding = 1 },
            },
          },
          inactive_sections = {
            lualine_a = { "filename" },
            lualine_b = {},
            lualine_c = {},
            lualine_x = {},
            lualine_y = {},
            lualine_z = {},
          },
          extensions = {
            "aerial",
            "fugitive",
            "lazy",
            "man",
            "mason",
            "oil",
            "quickfix",
            "trouble",
          },
        }
      end,
      dependencies = {
        "folke/trouble.nvim",
        "nvim-neo-tree/neo-tree.nvim",
        "nvim-tree/nvim-web-devicons",
        "tpope/vim-fugitive",
      },
    },

    -- taboo - tab bar helper {{{3
    {
      "gcmt/taboo.vim",
      init = function()
        vim.g.taboo_tab_format = [[ %d %f %m ]]
        vim.g.taboo_renamed_tab_format = [[ %d %l %m ]]
      end,
      dependencies = { "ryanoasis/vim-devicons" },
    },

    -- undotree - undo tree helper {{{3
    {
      "jiaoshijie/undotree",
      opts = {},
      keys = function()
        local undotree = require("undotree")
        return {
          -- TODO: Add `<s-cr>` to update undo state and exit
          {
            "<m-u>",
            function()
              undotree.toggle()
              -- TODO: Hide this message on closing undotree
              vim.notify(
                "UNDOTREE: ",
                "j/k: ↑/↓, J/K: ↑/↓ + change state, ",
                "cr: change state, p: go to preview, q: quit",
                vim.log.levels.INFO
              )
            end,
            desc = "Toggle undotree",
          },
        }
      end,
      dependencies = "nvim-lua/plenary.nvim",
    },

    -- autoclose - autocomplete brackets {{{3
    {
      "m4xshen/autoclose.nvim",
      opts = {
        options = {
          disabled_filetypes = { "text", "markdown" },
          pair_spaces = true,
        },
        keys = {
          ['"'] = { escape = true, close = true, pair = '""' },
          ["'"] = { escape = true, close = true, pair = "''" },
          ["`"] = { escape = true, close = true, pair = "``" },
          ["|"] = { escape = true, close = true, pair = "||" },
          ["("] = { escape = true, close = true, pair = "()" },
          ["["] = { escape = true, close = true, pair = "[]" },
          ["{"] = { escape = true, close = true, pair = "{}" },
          ["<"] = { escape = true, close = true, pair = "<>" },
        },
      },
    },

    -- mini.files - sidebar filesystem helper {{{3
    -- TODO: Delete to trash (IMPORTANT)
    -- TODO: Co-ordinate with `neo-tree.nvim`:
    -- 1. Use `-`/`_` to toggle plugin with ALL files in `cwd`
    -- 2. Use `<m-->`/`<m-_>` to toggle plugin with GIT-RELATED files in `cwd`
    -- TODO: Add decoration to focussed window. SEE: mini.files `highlights`
    -- TODO: As of now, I "disabled" history (remembering previous location)
    -- because I don't want plugin to open at a possibly irrelevant location
    -- but consider enabling it as long as the previous location is a child
    -- directory of current plugin parent root directory.
    {
      "echasnovski/mini.files",
      version = false,
      event = "VeryLazy",
      opts = {
        windows = {
          width_focus = 30,
          width_nofocus = 20,
          preview = true,
          width_preview = 36,
        },
        mappings = {
          synchronize = "<c-s>", -- DEFAULT: "="
          reset = "=", -- DEFAULT: "<bs>"
          -- NOTE:
          -- 1. Disabling `go_in` behavior and only keeping `go_in_plus`
          -- 2. Disabling `go_out`/`go_out_p;us` behavior in favor of custom
          --    `<esc>` behavior.
          go_in = "", -- DEFAULT: "l"
          go_in_plus = "<cr>", -- DEFAULT: "L"
          go_out = "", -- DEFAULT: "h"
          go_out_plus = "", -- DEFAULT: "H"
        },
      },
      init = function()
        local minifiles = require("mini.files")
        local go_out_upto_root_dir_only_and_close_afterwards = function()
          -- NOTE: `explorer_state` is nil when mini.files is closed
          local explorer_state = minifiles.get_explorer_state()
          if explorer_state ~= nil then
            -- POSSIBLE CHILD PATH: path in first branch
            local possible_child_path = explorer_state["branch"][1]
            -- PARENT PATH: `root_dir` in current mini.files instance
            local parent_path = explorer_state["anchor"]
            if
              are_paths_equal({ possible_child_path, parent_path })
              or does_parent_path_contain_given_path(
                parent_path,
                possible_child_path
              )
            then
              if explorer_state["depth_focus"] == 1 then
                minifiles.close()
              else
                minifiles.go_out()
              end
            else
              minifiles.close()
            end
          end
        end

        vim.api.nvim_create_autocmd("User", {
          pattern = "MiniFilesBufferCreate",
          group = vim.api.nvim_create_augroup("mini-files-augroup", {}),
          callback = function(args)
            -- NOTE:
            -- 1. `<esc>` goes outward and closes when attempting to go beyond
            --    root_dir.
            -- 2. `<s-esc>` just closes minifiles, just like the toggle would
            --    have done. This is a convenience keymap.
            local buf_id = args.data.buf_id
            vim.keymap.set(
              "n",
              "<esc>",
              go_out_upto_root_dir_only_and_close_afterwards,
              {
                buffer = buf_id,
                desc = "Go outwards in mini.files (closes at root dir)",
              }
            )
            vim.keymap.set("n", "<s-esc>", function()
              minifiles.close()
            end, { desc = "Close mini.files" })
          end,
        })
      end,
      keys = {
        {
          "-",
          function()
            -- TODO: Currently using `minifiles.reset()` to avoid starting from
            -- previous location, but provide an alternative when I *want* to
            -- start from previous location,
            local minifiles = require("mini.files")
            if not minifiles.close() then
              minifiles.open()
              minifiles.reset()
            end
          end,
          desc = "Toggle mini.files",
        },
      },
    },

    -- neo-tree - sidebar filesystem helper {{{3
    -- TODO: Co-ordinate keymaps with mini.files. SEE: mini.files TODO.
    -- FIXME: Cleanup commands being used in keymaps because there are too many
    -- loading errors, eg: `?` to show help within plugin window.
    {
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v2.x",
      event = "VeryLazy",
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
      init = function()
        -- Disable deprecated commands e.g. `:NeoTreeReveal`
        vim.g.neo_tree_remove_legacy_commands = 1
      end,
      cmd = { "Neotree" },
      keys = {
        -- All files with current file selected in cwd
        {
          "_",
          "<cmd>Neotree action=focus source=filesystem position=left toggle=true reveal=true<cr>",
          desc = "Toggle NeoTree",
        },
        -- FIXME: Git relevant files with current file selected in cwd
        -- {
        --   "_",
        --   "<cmd>Neotree action=focus source=git_status position=left toggle=true reveal=true<cr>",
        --   desc = "Toggle NeoTree",
        -- },
      },
      dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "nvim-tree/nvim-web-devicons",
        {
          -- Required in keymaps using `*_window_picker`
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

    -- alpha - start page {{{3
    {
      "goolord/alpha-nvim",
      config = function()
        local dashboard = require("alpha.themes.dashboard")
        dashboard.section.header.val = {
          [[ _____ __    _____    _____ _____ _____]],
          [[|     |  |  |  _  |  |   __| __  |     |]],
          [[|  |  |  |__|     |  |__   |    -|-   -|]],
          [[|_____|_____|__|__|  |_____|__|__|_____|]],
        }
        dashboard.section.buttons.val = {
          dashboard.button(
            "e",
            "EDIT NEW BUFFER",
            "<cmd>enew | startinsert<cr>"
          ),
          dashboard.button(
            "s",
            "SOURCE `./Session.vim`",
            "<cmd>source ./Session.vim<cr>"
          ),
          dashboard.button("q", "QUIT", "<cmd>quitall<cr>"),
        }
        dashboard.section.footer.val = {
          [[do not sleep, my starling, do not sleep]],
        }
        -- TODO: Investigate if a custom namespace is necessary here
        local ns = vim.api.nvim_create_namespace("alpha_custom_highlights")
        vim.api.nvim_set_hl_ns(ns)
        vim.api.nvim_set_hl(ns, "AlphaCustomDashboardHeader", {
          fg = vim.fn.synIDattr(
            vim.fn.synIDtrans(vim.fn.hlID("Comment")),
            "fg"
          ),
          bold = true,
          italic = false,
        })
        vim.api.nvim_set_hl(ns, "AlphaCustomDashboardFooter", {
          fg = vim.fn.synIDattr(
            vim.fn.synIDtrans(vim.fn.hlID("LineNrAbove")),
            "fg"
          ),
          bold = true,
          italic = true,
        })
        dashboard.section.header.opts.hl = "AlphaCustomDashboardHeader"
        dashboard.section.footer.opts.hl = "AlphaCustomDashboardFooter"
        require("alpha").setup(dashboard.opts)
      end,
    },

    -- mini.git - git helper {{{3
    -- FIXME: Add fugitive user command equivalents before enabling.
    -- {
    --   "echasnovski/mini-git",
    --   version = false,
    --   lazy = false,
    --   main = "mini.git",
    --   opts = {},
    -- },

    -- gitsigns - git helper {{{3
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

          -- TODO: Add git buffer keymaps on git load
          local function map(mode, l, r, desc)
            vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
          end

          map("n", "]h", gs.next_hunk, "Next Hunk")
          map("n", "[h", gs.prev_hunk, "Prev Hunk")
          -- TODO: `[H`/`]H` for first/last hunk

          -- TODO: Uncomment and adapt
          -- map({ "n", "x" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
          -- map({ "n", "x" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
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

    -- diffview.nvim - git diff viewer/helper {{{3
    {
      "sindrets/diffview.nvim",
      cmd = {
        "DiffviewClose",
        "DiffviewFileHistory",
        "DiffviewFocusFiles",
        "DiffviewLog",
        "DiffviewOpen",
        "DiffviewRefresh",
        "DiffviewToggleFiles",
      },
      opts = function()
        local actions = require("diffview.actions")
        local common_keymaps = {
          -- NOTE: I use tabs to switch between tag pages and they're too
          -- important to be overwritten, so replacing their plugin behavior of
          -- `select_next_entry`/`select_prev_entry` with `[f`/`]f` whose
          -- "unimpaired" behavior of next/previous file is undesirable in this
          -- context anyway and also because they are similar to plugin's
          -- `[F`/`]F`(`select_first_entry`/`select_last_entry`).
          ["<tab>"] = false,
          ["<s-tab>"] = false,
          ["]f"] = actions.select_next_entry,
          ["[f"] = actions.select_prev_entry,
        }
        return {
          keymaps = {
            view = common_keymaps,
            file_panel = common_keymaps,
            file_history_panel = common_keymaps,
          },
        }
      end,
      dependencies = "nvim-lua/plenary.nvim",
    },

    -- lazygit - git helper {{{3
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

    -- telescope - fuzzy search {{{3
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
        ---- TODO: Another keymap, using `t` for tabs
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
              -- DEFAULT KEYMAPS:
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

    -- narrow region - focus on selected region {{{3
    -- TODO: Create keymaps
    {
      "chrisbra/NrrwRgn",
      event = "VeryLazy",
    },

    -- dropbar - clickable breadcrumb (barbecue alternative) {{{3
    -- FIXME: Has issue with completions in insert menu
    -- TODO: Allow navigation through list without selecting the list, i.e.
    -- select only on <cr`>`.
    {
      "Bekaboo/dropbar.nvim",
      init = function()
        local dropbar_api = require("dropbar.api")
        vim.keymap.set("n", "<c-6>", function()
          dropbar_api.pick()
        end, {
          silent = true,
          desc = "Choose dropbar breadcrumb",
        })
      end,
      -- NOTE: optional, but required for fuzzy finder support
      dependencies = {
        "nvim-telescope/telescope-fzf-native.nvim",
      },
    },

    -- mini.jump - jump helper {{{3
    {
      "echasnovski/mini.jump",
      version = false,
      event = "VeryLazy",
      opts = { delay = { highlight = 10 } },
    },

    -- csvview - csv displayer {{{3
    {
      "hat0uma/csvview.nvim",
      -- TODO: Activate (`CsvViewEnable`) automatically for `csv`/`tsv` files?
      opts = {
        parser = { comments = { "#", "//" } },
        -- view = {
        --  NOTE: `border` show `|`, `highlight` shows delimiter
        --   display_mode = "highlight",  -- DEFAULT
        -- },
        keymaps = {
          textobject_field_inner = { "if", mode = { "o", "x" } },
          textobject_field_outer = { "af", mode = { "o", "x" } },
          -- TODO: Come up with other movement keymaps, because I use `<tab>`
          -- based normal mode keymaps elsewhere.
          -- NOTE: PLUGIN RECOMMENDED MOVEMENT KEYMAPS (based on excel):
          -- - `<tab>` / `<s-tab>` move horizontally
          -- - `<cr>`/`<s-cr>` move vertically between rows(cursor to field end)
          -- jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
          -- jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
          -- jump_next_row = { "<Enter>", mode = { "n", "v" } },
          -- jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
        },
      },
      ft = { "csv", "tsv" },
      cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
      init = function()
        local csvview_augroup =
          vim.api.nvim_create_augroup("csvview_augroup", {})
        -- NOTIFY WHEN `CsvView` IS ENABLED/DISABLED:
        vim.api.nvim_create_autocmd("User", {
          pattern = "CsvViewAttach",
          group = csvview_augroup,
          callback = function()
            vim.notify("`CsvView` ON", vim.log.levels.INFO)
          end,
        })
        vim.api.nvim_create_autocmd("User", {
          pattern = "CsvViewDetach",
          group = csvview_augroup,
          callback = function()
            vim.notify("`CsvView` OFF", vim.log.levels.INFO)
          end,
        })
      end,
    },

    -- skel-nvim - skeleton/template files {{{3
    -- NOTE:  Load skeletons from `skeleton` directory within nepvim's config
    -- directory i.e. `vim.fn.stdpath('config)`. e.g.:
    -- `$HOME/.config/nvim/skeleton/rust.skel`
    -- TODO:
    -- 1. Implement for more languages and utilise the plugin's `substitutions`
    --    feature.
    -- 2. Refactor out language specific template filling from elm etc. into
    --    here.
    {
      "motosir/skel-nvim",
      opts = {
        mappings = {
          ["*.html"] = {
            "basic.html.skel",
            "elm.html.skel",
            "elm-full.html.skel",
          },
        },
      },
    },

    -- foldnav - fold navigation {{{3
    -- NOTE: Works only in folds (duh). Check if folds are active by opening
    -- `foldcolumn` with for e.g: `:set foldcolumn=5`.
    -- TODO: Add a `foldcolumn` toggler.
    {
      "domharries/foldnav.nvim",
      version = "*",
      config = function()
        vim.g.foldnav = {
          -- Briefly flash area of fold being referenced
          flash = { enabled = true },
        }
      end,
      keys = {
        --[[
        NOTE: Table shows vim's equivalent keymaps(VIM), the keymaps I
        added/overwrote(MINE) to use the features provided by foldnav.
        +-----+------+-------------------+----------------------------------+
        | VIM | MINE | FOLDNAV           | DESCRIPTION                      |
        |-----+------+-------------------+----------------------------------|
        |     | zK   | goto_prev_start() | Most recent place a fold started |
        | [z  | [z   | goto_start()      | Start of enclosing fold          |
        | zj  | zj   | goto_next()       | Start of next fold               |
        | zk  | zk   | goto_prev_end()   | End of previous fold             |
        | ]z  | ]z   | goto_end()        | End of enclosing fold            |
        +-----+------+-------------------+----------------------------------+
        --]]
        {
          "zK",
          function()
            require("foldnav").goto_prev_start()
          end,
          mode = { "n", "x", "o" },
        },
        {
          "[z",
          function()
            require("foldnav").goto_start()
          end,
          mode = { "n", "x", "o" },
        },
        {
          "zj",
          function()
            require("foldnav").goto_next()
          end,
          mode = { "n", "x", "o" },
        },
        {
          "zk",
          function()
            require("foldnav").goto_prev_end()
          end,
          mode = { "n", "x", "o" },
        },
        {
          "]z",
          function()
            require("foldnav").goto_end()
          end,
          mode = { "n", "x", "o" },
        },
      },
    },

    -- todo-comments - highlight "pragmas" like `TODO` {{{3
    -- FIXME: Remove this plugin.
    {
      "folke/todo-comments.nvim",
      enabled = false,
      event = { "BufReadPost", "BufNewFile" },
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
      cmd = { "TodoTelescope" },
      -- NOTE: `p` for "pragma", like XCode pragma
      -- TODO: Add keymaps that restrict pragma searching to current buffer
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

    -- mini.ai - text objects {{{3
    {
      "echasnovski/mini.ai",
      version = false,
      opts = function()
        local mini_ai = require("mini.ai")
        local mini_extra = require("mini.extra")
        return {
          mappings = {
            -- around = "a",
            -- inside = "i",
            -- TODO: Use `n`/`N` here? (Something like my `mini.surround` config)
            -- around_next = "an",
            -- inside_next = "in",
            -- around_last = "al",
            -- inside_last = "il",
            -- TODO: Check if need to be similar to my `mini.surround` equivalents?
            -- goto_left = "g[",
            -- goto_right = "g]",
          },
          n_lines = 600, -- DEFAULT: 50
          -- search_method = "cover_or_next",
          -- silent = false,
          custom_textobjects = {
            -- TODO: URL (e.g. `LeonB/vim-textobj-url`)
            -- ENTIRE BUFFER (MNEMONIC: `e` for entire buffer.):
            -- NOTE: Leading/trailing blank lines are consdered in `a`/`i`.
            e = mini_extra.gen_ai_spec.buffer(),
            -- INDENT:
            i = mini_extra.gen_ai_spec.indent(),
            -- ARGUMENT:
            a = false, -- NOTE: Disabling argument default `a`.
            [","] = mini_ai.gen_spec.argument(),
            -- ASSIGNMENT:
            ["="] = mini_ai.gen_spec.treesitter({
              a = "@assignment.outer", --  "@assignment.rhs",
              i = "@assignment.inner", -- "@assignment.lhs",
            }),
            -- CLASS:
            c = mini_ai.gen_spec.treesitter({
              a = { "@class.outer" },
              i = { "@class.inner" },
            }),
            -- COMMENT:
            ["#"] = mini_ai.gen_spec.treesitter({
              a = { "@comment.outer" },
              i = { "@comment.inner" },
            }),
            -- LOOP:
            l = mini_ai.gen_spec.treesitter({
              a = "@loop.outer",
              i = "@loop.inner",
            }),
            -- FUNCTION DEFINITION:
            f = mini_ai.gen_spec.treesitter({
              a = "@function.outer",
              i = "@function.inner",
            }),
            -- FUNCTION CALL:
            F = mini_ai.gen_spec.function_call(), -- DEFAULT: `f`
            -- TODO: "CHAINMEMBER" FUNCTION (e.g. `D4KU/vim-textobj-chainmember`)
            -- CODE BLOCK:
            k = mini_ai.gen_spec.treesitter({ -- code block
              a = { "@block.outer", "@conditional.outer", "@loop.outer" },
              i = { "@block.inner", "@conditional.inner", "@loop.inner" },
            }),
            -- MARKDOWN CODE BLOCK:
            M = mini_ai.gen_spec.treesitter({
              a = { "@codeblock.outer" },
              i = { "@codeblock.inner" },
            }),
            -- NUMBER(MNEMONIC: `d` for digits. `n` is used by `mini.ai` itself.):
            d = mini_extra.gen_ai_spec.number(), -- e.g. `123`, `1.23`, `-1.23`
            -- FOLD:
            -- FIXME: Remove usage of `normal` command here, it's messing with
            -- active fold layouts and is also inelegant.
            -- NOTE: When making changes to this, consider:
            -- 1. `a` will have to include blank lines following current fold.
            -- 2. When deleting current fold `diz`, it shouldn't delete any
            --    attached different folds(i.e. fo;ds with no blank lines
            --    between them).
            z = function(ai_type)
              local current_line = vim.api.nvim_win_get_cursor(0)[1]
              local current_buffer = 0
              local current_fold_level = vim.fn.foldlevel(current_line)
              if current_fold_level == 0 then
                return nil
              end
              local fold_start_line = vim.fn.foldclosed(current_line)
              local fold_end_line = vim.fn.foldclosedend(current_line)
              if fold_start_line == -1 then
                -- Use foldtextresult to find actual fold boundaries
                local search_line = current_line
                -- Find fold start - go up until we find the start of this fold
                while search_line >= 1 do
                  -- Check if this line can be folded and would include our current line
                  vim.cmd("normal! " .. search_line .. "G")
                  local test_fold_start = vim.fn.foldclosed(search_line)
                  local test_fold_end = vim.fn.foldclosedend(search_line)
                  if
                    test_fold_start ~= -1
                    and test_fold_start <= current_line
                    and test_fold_end >= current_line
                  then
                    fold_start_line = test_fold_start
                    fold_end_line = test_fold_end
                    break
                  end
                  -- Try to create a fold at this line and see if it includes current line
                  local saved_foldenable = vim.wo.foldenable
                  vim.wo.foldenable = true
                  pcall(vim.cmd, "normal! zc")
                  local fold_start_test = vim.fn.foldclosed(current_line)
                  local fold_end_test = vim.fn.foldclosedend(current_line)
                  pcall(vim.cmd, "normal! zo")
                  vim.wo.foldenable = saved_foldenable
                  if fold_start_test == search_line then
                    fold_start_line = fold_start_test
                    fold_end_line = fold_end_test
                    break
                  end
                  search_line = search_line - 1
                end
                -- Restore cursor position
                vim.api.nvim_win_set_cursor(0, { current_line, 0 })
                -- Fallback to original method if nothing found
                if fold_start_line == -1 then
                  return nil
                end
              end
              local selection_start_line = fold_start_line
              local selection_start_col = 1
              local selection_end_line = fold_end_line
              local selection_end_col
              if ai_type == "a" then
                local buffer_last_line =
                  vim.api.nvim_buf_line_count(current_buffer)
                while selection_end_line < buffer_last_line do
                  local next_line = selection_end_line + 1
                  local next_line_content = vim.api.nvim_buf_get_lines(
                    current_buffer,
                    next_line - 1,
                    next_line,
                    false
                  )[1]
                  local next_line_fold_level = vim.fn.foldlevel(next_line)
                  if
                    next_line_content
                    and next_line_content:match("^%s*$")
                    and next_line_fold_level <= current_fold_level
                  then
                    selection_end_line = next_line
                  else
                    break
                  end
                end
              end
              local end_line_content = vim.api.nvim_buf_get_lines(
                current_buffer,
                selection_end_line - 1,
                selection_end_line,
                false
              )[1] or ""
              selection_end_col = #end_line_content
              if selection_end_col == 0 then
                selection_end_col = 1
              end
              return {
                from = {
                  line = selection_start_line,
                  col = selection_start_col,
                },
                to = { line = selection_end_line, col = selection_end_col },
              }
            end,
          },
        }
      end,
      dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-treesitter/nvim-treesitter-textobjects",
        { "echasnovski/mini.extra", version = false },
      },
    },

    -- cool - turn off search highlight after search completed {{{3
    {
      "romainl/vim-cool",
      event = "VeryLazy",
    },

    -- colorful-winsep - colorful window borders {{{3
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

    -- zen-mode - focus helper {{{3
    {
      "folke/zen-mode.nvim",
      -- TODO: Configure terminal emulator hooks(wezterm etc.)
      -- NOTE: Where possible, prefer specific configuration set within keymaps
      -- rather than global configuration set here in `opts`.
      opts = { window = { backdrop = 1 } },
      keys = function()
        -- NOTE: KEYMAP GRAMMAR:
        -- +---------+--------------+----------------------+
        -- | KEYMAP  | CONTENT TYPE | UI MINIMALISM LEVEL  |
        -- +---------+--------------+----------------------+
        -- | `<m-z>` | CODE         | BASIC                |
        -- | `<m-Z>` | CODE         | EXTREME              |
        -- | TODO:   | PROSE        | BASIC                |
        -- | TODO:   | PROSE        | EXTREME              |
        -- +---------+--------------+----------------------+
        local zenmode = require("zen-mode")
        return {
          --  CODE (BASIC UI MINIMALISM)
          {
            "<m-z>",
            function()
              zenmode.toggle({ window = { width = 0.94, height = 1 } })
            end,
            desc = "Toggle ZenMode (CODE - BASIC UI MINIMALISM)",
          },
          --  CODE (EXTREME UI MINIMALISM)
          {
            "<m-Z>",
            function()
              zenmode.toggle({
                window = {
                  width = 0.8,
                  height = 0.9,
                  -- WINDOW OPTIONS(`vim.wo.*`):
                  options = {
                    number = false, -- disable number column
                  },
                },
                plugins = {
                  -- GLOBAL OPTIONS(`vim.o.*`):
                  options = {
                    enabled = true,
                    ruler = false, -- disables ruler text in command line area
                    showcmd = false, -- disables command in last line of screen
                    laststatus = 0, -- 0 hides and 3 shows `statusline`
                  },
                },
              })
            end,
            desc = "Toggle ZenMode (CODE - EXTREME UI MINIMALISM)",
          },
        }
      end,
    },

    -- rainbow_parentheses - multi-colored nested "parenthesis" {{{3
    {
      "junegunn/rainbow_parentheses.vim",
      -- lazy = false,
      keys = {
        {
          "[or",
          "<cmd>RainbowParentheses<cr>",
          desc = "Enable rainbow parenthesis",
        },
        {
          "]or",
          "<cmd>RainbowParentheses!<cr>",
          desc = "Disable rainbow parenthesis",
        },
        {
          "yor",
          "<cmd>RainbowParentheses!!<cr>",
          desc = "Toggle rainbow parenthesis",
        },
      },
      cmd = {
        "RainbowParentheses", -- ENABLE
        -- FIXME: Trailing `!` triggers `lazy.nvim` error: Invalid command name.
        -- "RainbowParentheses!", -- DISABLE
        -- "RainbowParentheses!!", -- TOGGLE
      },
      init = function()
        -- CONFIGURATION:
        vim.g["rainbow#max_level"] = 40
        vim.g["rainbow#pairs"] = {
          { "(", ")" },
          { "[", "]" },
          { "{", "}" },
          { "<", ">" },
        }
        -- ENABLE IN "PARENTHESIS" HEAVY LANGUAGES:
        local rainbow_parentheses_augroup =
          vim.api.nvim_create_augroup("rainbow_parentheses", {})
        vim.api.nvim_create_autocmd({ "FileType" }, {
          desc = "Enable rainbox parenthesis automatically for parenthesis heavy languages",
          group = rainbow_parentheses_augroup,
          pattern = {
            -- "rust",
            "json",
            "lisp",
          },
          callback = function()
            vim.cmd("RainbowParentheses")
          end,
        })
      end,
    },

    -- smear - animate cursor movement with a smear effect {{{3
    {
      "sphamba/smear-cursor.nvim",
      opts = {
        smear_insert_mode = false,
        -- NOTE: Smear over transparent background is apparently better when
        -- the font supports "legacy computing symbols", so enable that with
        -- `legacy_computing_symbols_support`. If it isn't supported, the
        -- plugin might show a solid color which can be configured with
        -- `transparent_bg_fallback_color`
        legacy_computing_symbols_support = false,
        -- APPEARANCE(fast and tight):
        stiffness = 0.7, -- DEFAULT: 0.6, RANGE: [0, 1]
        trailing_stiffness = 0.5, -- DEFAULT: 0.3, RANGE: [0.3 ,0, 1]
        -- distance_stop_animating = 0.5, -- DEFAULT: 0.1, RANGE: > 0
      },
    },

    -- beacon - draw attention to cursor after jump {{{3
    {
      "rainbowhxch/beacon.nvim",
      opts = {
        enable = true,
        size = 6,
        fade = true,
        minimal_jump = 5,
        show_jumps = true,
        focus_gained = false, -- TODO: Consider enabling
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

    -- sort-motion - sort operator {{{3
    -- `gs`
    -- TODO: Make a plugin `gs` that ignores comments
    {
      "christoomey/vim-sort-motion",
      event = "VeryLazy",
    },

    -- titlecase - title case operator {{{3
    -- `gz`
    {
      "christoomey/vim-titlecase",
      event = "VeryLazy",
    },

    -- markdown {{{3
    {
      "MeanderingProgrammer/render-markdown.nvim",
      ft = { "markdown" },
      opts = {
        -- TODO: Add checkbox customizations.
        -- TODO: Add completions `completions = { blink = { enabled = true }
        -- }`.
      },
      cmd = {
        -- "RenderMarkdown", -- NOTE: SEE: `init`.
        "RenderMarkdownEnable",
        "RenderMarkdownEnableForCurrentBuffer",
        "RenderMarkdownDisable",
        "RenderMarkdownDisableForCurrentBuffer",
        "RenderMarkdownToggle",
        "RenderMarkdownToggleForCurrentBuffer",
      },
      init = function()
        local render_markdown = require("render-markdown")
        -- NOTE: Removing "bare" in-built command `RenderMarkdown` in order to
        -- use the following more explicit commands to avoid confusion.
        -- REMOVE BARE `RenderMarkdown`:
        vim.api.nvim_del_user_command("RenderMarkdown")
        -- ENABLE:
        vim.api.nvim_create_user_command(
          "RenderMarkdownEnableForCurrentBuffer",
          function()
            render_markdown.buf_enable()
          end,
          { desc = "Enable RenderMarkdown plugin for current buffer" }
        )
        vim.api.nvim_create_user_command("RenderMarkdownEnable", function()
          render_markdown.enable()
        end, { desc = "Enable RenderMarkdown plugin" })
        -- DISABLE:
        vim.api.nvim_create_user_command(
          "RenderMarkdownDisableForCurrentBuffer",
          function()
            render_markdown.buf_disable()
          end,
          { desc = "Disable RenderMarkdown plugin for current buffer" }
        )
        vim.api.nvim_create_user_command("RenderMarkdownDisable", function()
          render_markdown.disable()
        end, { desc = "Disable RenderMarkdown plugin" })
        -- TOGGLE:
        vim.api.nvim_create_user_command(
          "RenderMarkdownToggleForCurrentBuffer",
          function()
            render_markdown.buf_toggle()
          end,
          { desc = "Toggle RenderMarkdown plugin for current buffer" }
        )
        vim.api.nvim_create_user_command("RenderMarkdownToggle", function()
          render_markdown.toggle()
        end, { desc = "Toggle RenderMarkdown plugin" })
      end,
      dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "echasnovski/mini.icons",
      },
    },

    -- zig {{{3
    {
      "ziglang/zig.vim",
      ft = { "zig", "zon" },
      init = function()
        -- vim.g.zig_fmt_autosave = 0 -- 0 disables format_on_save
      end,
    },

    -- elixir {{{3
    "elixir-editors/vim-elixir",

    -- fish {{{3
    {
      "blankname/vim-fish",
      -- NOTE: `https://github.com/dag/vim-fish` was abondoned, hence using
      -- this maintained clone
      ft = { "fish" },
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
          "go",
          "lua",
          "nix",
          "query",
          "rust",
          "vim",
          "vimdoc",
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

    -- hlargs - LSP `highlight-args` {{{3
    {
      "m-demare/hlargs.nvim",
      event = "VeryLazy",
      opts = {},
      dependencies = {
        "nvim-treesitter/nvim-treesitter",
      },
    },

    -- plenary - nvim/Lua helpers {{{3
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

    -- full_visual_line.nvim - highlights full screen line in `V` mode {{{3
    {
      "0xAdk/full_visual_line.nvim",
      enabled = false,
      opts = {},
      keys = "V",
    },

    -- mini.cursorword - highlight repetitions of word under cursor {{{3
    -- TODO: Replace underline styling with a more `vim-illuminate` like
    -- background highlighting.
    -- TODO: Replace with a treesitter/lsp/regex aware alternative like
    -- `vim-illuminate` which didn't work for me because it adds unremovable
    -- default keymaps (`<m-n>`, `<m-p>`).
    {
      "echasnovski/mini.cursorword",
      version = false,
      opts = {},
    },

    -- luminate - highlight yank/paste/undo/redo {{{3
    {
      "mei28/luminate.nvim",
      -- NOTE: Neovim cokes with "highlight on yank". Disable it to use this
      -- plugin's highlights for uniformity sake.
      event = { "VeryLazy" },
      opts = {
        duration = 300, -- milliseconds
        yank = { enabled = true },
        paste = { enabled = true },
        undo = { enabled = true },
        redo = { enabled = true },
      },
    },

    -- dressing - better vim UI {{{3
    {
      "stevearc/dressing.nvim",
      event = "VeryLazy",
    },

    -- orphans - show abandoned plugins {{{3
    {
      "ZWindL/orphans.nvim",
      cmd = "Orphans",
      opts = {},
    },

    -- mini notify - notification helper {{{3
    {
      "echasnovski/mini.notify",
      version = false,
      opts = function()
        local mini_notify = require("mini.notify")
        local ui = vim.api.nvim_list_uis()[1]
        local lsp_icon = "󰆧" -- TODO: Replace with `mini.icons`.
        return {
          lsp_progress = {
            enable = true,
            duration_last = 1000, -- ms
            level = "INFO", -- DEFAULT: "INFO"
          },
          -- format = nil, -- NOTE: `mini_notify.default_format()`
          content = {
            format = function(notification)
              -- return mini_notify.default_format(notification)
              if notification.data.source == "lsp_progress" then
                return lsp_icon .. " " .. notification.msg
              else
                -- TODO: Setup `mini.icons` and configure icons for each log level.
                return notification.level .. ": " .. notification.msg
              end
            end,
            sort = nil,
          },
          window = {
            config = {
              style = "minimal",
              border = "rounded",
              -- title_pos = "right",
              title = "",
              -- SHOW NOTIFICAITONS IN BOTTOM RIGHT OF EDITOR:
              relative = "editor",
              anchor = "SE",
              row = ui.height - 3, -- NOTE: Account for statuscolumn height
              col = ui.width - 1,
            },
            winblend = 60,
          },
        }
      end,
      init = function()
        local mini_notify = require("mini.notify")
        -- NOTE: Make `mini.notify` the default notification handler by
        -- wrapping `vim.notify` itself.
        vim.notify = mini_notify.make_notify()
        -- CLEAR ACTIVE NOTIFICATIONS:
        vim.api.nvim_create_user_command("MiniMotifyClear", function()
          mini_notify.clear()
        end, { desc = "Remove active `mini.notify` messages" })
        vim.keymap.set("n", "<leader>zm", function()
          mini_notify.clear()
        end, {
          silent = true,
          desc = "Remove active `mini.notify` messages",
        })
        -- SHOW HISTORY:
        vim.api.nvim_create_user_command("MiniMotifyHistory", function()
          mini_notify.show_history()
        end, { desc = "Show `mini.notify` message history" })
        -- REFRESH NOTIFICATION WINDOW:
        vim.api.nvim_create_user_command("MiniMotifyRefresh", function()
          mini_notify.refresh()
        end, { desc = "Refresh `mini.notify` messages" })
      end,
    },

    -- fidget - LSP loading indicator {{{3
    {
      "j-hui/fidget.nvim",
      enabled = false,
      opts = {
        progress = {
          display = {
            render_limit = 12, -- Default 16
            done_icon = "",
            format_message = function(msg)
              local message = msg.message
              if not message then
                message = msg.done and "" or ""
              end
              if msg.percentage ~= nil then
                return string.format("%s %.0f%%", message, msg.percentage)
              else
                return message
              end
            end,
          },
        },
        notification = {
          window = {
            max_width = 24, -- default: 0 for none
          },
        },
      },
    },

    -- debugprint - print debug statements {{{3
    -- TODO: Consider treesitter-aware alternative: `Goose97/timber.nvim`
    {
      "andrewferrier/debugprint.nvim",
      version = "*", -- * is stable version
      opts = {},
    },

    -- qf-edit - edit quickfix list like a normal buffer {{{3
    {
      "itchyny/vim-qfedit",
      ft = "qf",
    },

    -- vim-qf_resize - make quickfix/location-list as small as possible {{{3
    -- TODO: Make or find a better more configurable alternative.
    {
      "blueyed/vim-qf_resize",
      ft = "qf",
    },

    -- auto-cmdheight - expand commandline for long messages {{{4
    -- WARN: Remove in v0.12+ SEE: https://www.reddit.com/r/neovim/comments/1jqk8x1/introducing_autocmdheightnvim/ml7soga/
    -- NOTE: Plugin recommends `lazy = false`
    {
      "jake-stewart/auto-cmdheight.nvim",
      opts = {
        -- max_lines = 5, -- DEAFULT: 5
        -- duration = 2, -- DEFAULT: 2
        -- remove_on_key = true, -- DEFAULT: true
        -- clear_always = false -- DEFAULT: false
      },
    },

    -- trouble - reporting UI (lsp/make etc) {{{3
    -- TODO: clean keymap desc
    {
      "folke/trouble.nvim",
      cmd = { "TroubleToggle", "Trouble" },
      opts = { use_diagnostic_signs = true },
      keys = function()
        local trouble = require("trouble")
        local window_toggling_keys = {}
        vim
          .iter({
            {
              prefix = "x",
              cmd = "Trouble",
              desc = "Open trouble",
            },
            {
              prefix = "d",
              cmd = "Trouble diagnostics toggle filter.buf=0",
              desc = "Toggle trouble buffer diagnostics",
            },
            {
              prefix = "D",
              cmd = "Trouble diagnostics toggle",
              desc = "Toggle trouible workspace diagnostics",
            },

            {
              prefix = "s",
              cmd = "Trouble symbols toggle focus=false",
              desc = "Toggle trouble LSP document symbols",
            },
            {
              prefix = "p",
              cmd = "Trouble todo toggle",
              desc = "Toggle trouble pragmas (TODO/NOTE/WARN...)",
            },
            {
              prefix = ",",
              cmd = "Trouble lsp toggle focus=false win.position=right",
              desc = "Toggle trouble LSP definitions/references/...",
            },
            {
              prefix = "l",
              cmd = "Trouble loclist toggle",
              desc = "Toggle trouble location list",
            },
            {
              prefix = "q",
              cmd = "Trouble qflist toggle",
              desc = "Toggle trouble quickfix list",
            },
          })
          :each(function(v)
            local prefix = "<m-x>"
            vim.list_extend(window_toggling_keys, {
              {
                prefix .. v.prefix,
                "<cmd>" .. v.cmd .. "<cr>",
                desc = v.desc,
              },
              {
                prefix .. "<m-" .. v.prefix .. ">",
                "<cmd>" .. v.cmd .. "<cr>",
                desc = v.desc,
              },
            })
          end)
        local navigation_keys = {
          {
            "[x",
            function()
              trouble.previous({ skip_groups = true, jump = true })
            end,
            desc = "Go to previous trouble item",
          },
          {
            "]x",
            function()
              trouble.next({ skip_groups = true, jump = true })
            end,
            desc = "Go to next trouble item",
          },
          {
            "[X",
            function()
              trouble.first({ skip_groups = true, jump = true })
            end,
            desc = "Go to first trouble item",
          },
          {
            "]X",
            function()
              trouble.last({ skip_groups = true, jump = true })
            end,
            desc = "Go to last trouble item",
          },
        }
        return vim.list_extend(window_toggling_keys, navigation_keys)
      end,
      init = function()
        vim.api.nvim_create_autocmd("FileType", {
          desc = "Jump to selected item and close trouble window",
          group = vim.api.nvim_create_augroup("trouble_augroup", {}),
          pattern = { "trouble" },
          callback = function()
            vim.keymap.set(
              "n",
              "<s-cr>",
              "<cmd>Trouble diagnostics jump_close<cr>",
              {
                silent = true,
                buffer = true,
                desc = "Jump to selected trouble item and close trouble window",
              }
            )
          end,
        })
      end,
    },

    -- aerial - LSP symbol outline helper {{{3
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
        {
          "g,O", -- TODO: Use keymap that fits in with rest of my grammar better
          "<cmd>AerialToggle<cr>",
          desc = "Toggle and focus on LSP symbol outline (aerial)",
        },
      },
      init = function()
        local aerial_augroup = vim.api.nvim_create_augroup("aerial_augroup", {})
        vim.api.nvim_create_autocmd({ "FileType" }, {
          desc = "Set keymap to jump to symbol under cursor and close aerial",
          group = aerial_augroup,
          pattern = { "aerial" },
          callback = function()
            vim.keymap.set("n", "<s-cr>", function()
              local aerial = require("aerial")
              aerial.select()
              aerial.close()
            end, {
              buffer = true,
              silent = true,
              desc = "Jump to symbol under cursor and close aerial",
            })
          end,
        })
      end,
      dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
      },
    },

    -- actions-preview - code action with preview {{{3
    -- TODO: Only activate if lsp active
    {
      "aznhe21/actions-preview.nvim",
      keys = {
        {
          ",A",
          function()
            require("actions-preview").code_actions()
          end,
          mode = { "n", "x" },
        },
      },
    },

    -- lspconfig - lsp server configurations {{{3
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

        -- C/CPP/OBJC/OBJCPP/CUDA/PROTO
        require("lspconfig").clangd.setup({
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

        -- FISH
        require("lspconfig").fish_lsp.setup({
          on_attach = common_on_attach,
          capabilities = capabilities,
        })

        -- GO
        require("lspconfig").gopls.setup({
          on_attach = common_on_attach,
          capabilities = capabilities,
        })

        -- HASKELL
        require("lspconfig").hls.setup({
          filetypes = { "haskell", "lhaskell", "cabal" },
          on_attach = common_on_attach,
          capabilities = capabilities,
        })

        -- NIX
        require("lspconfig").nixd.setup({
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

        -- PYTHON(RUFF)
        require("lspconfig").ruff.setup({
          on_attach = common_on_attach,
          capabilities = capabilities,
        })

        -- PYTHON(PYRIGHT)
        require("lspconfig").pyright.setup({
          on_attach = common_on_attach,
          capabilities = capabilities,
        })

        -- SWIFT(SOURCEKIT)
        require("lspconfig").sourcekit.setup({
          on_attach = common_on_attach,
          capabilities = capabilities,
        })

        -- ZIG
        require("lspconfig").zls.setup({
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

    -- mason - tools provider {{{3
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

    -- none-ls/null-ls - treat formatting/code_actions etc. like LSP {{{3
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
            -- django
            null_ls.builtins.diagnostics.djlint,
            null_ls.builtins.formatting.djlint, -- NOTE: DEFAULT: `--max-line-length=120`
            -- purescript
            null_ls.builtins.formatting.purs_tidy,
            -- swift
            null_ls.builtins.diagnostics.swiftlint,
            null_ls.builtins.formatting.swiftformat,
            -- c, cpp, cuda, proto
            null_ls.builtins.diagnostics.cppcheck,
            null_ls.builtins.formatting.clang_format,
            -- null_ls.builtins.formatting.uncrustify,
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
            -- nix
            null_ls.builtins.formatting.alejandra,
            -- null_ls.builtins.formatting.nixfmt,
            null_ls.builtins.diagnostics.statix,
            null_ls.builtins.diagnostics.deadnix,
            -- lua
            null_ls.builtins.formatting.stylua,
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

    -- luasnip - snippet manager {{{3
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

    -- nvim-cmp - auto-completion helpers {{{3
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
        -- FIXME: Disable for specific filetypes
        -- cmp.setup.filetype({ "dropbar_menu" }, {
        --   sources = {},
        -- })
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
          -- TODO: Expertly assign priority to the source
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

    -- LOCAL: plural-thing - toggle plural on `cword` {{{3
    {
      -- "kadimisetty/nvim-plural-thing",
      dir = "~/code/personal/nvim-plural-thing/",
      opts = { keymap = "<c-p>" },
    },

    -- LOCAL: toggle-thing - toggle leading/trailing patterns on line {{{3
    {
      -- "kadimisetty/nvim-toggle-thing",
      dir = "~/code/personal/nvim-toggle-thing/",
      opts = {},
    },

    -- LOCAL: gx-thing - extends `gx` {{{3
    {
      -- "kadimisetty/nvim-gx-thing",
      dir = "~/code/personal/nvim-gx-thing/",
      opts = {
        keymap = "gx", -- use different keymap to not overload `gx`
      },
    },

    -- LOCAL: line-thing - decorative lines for headers/dividers etc. {{{3
    {
      -- "kadimisetty/nvim-line-thing",
      dir = "~/code/personal/nvim-line-thing/",
      opts = {
        fill_chars = { "*", "-", "=", "X" }, -- DEFAULT: `{ "-" }`
        keymap_prefix_above = "[",
        keymap_prefix_above_without_indent = "g[",
        keymap_prefix_below = "]",
        keymap_prefix_below_without_indent = "g]",

        keymap_prefix_surround = "<localleader>{",
        keymap_prefix_surround_alt = "<localleader>}",
        keymap_prefix_surround_without_indent = "<localleader>g{",
        keymap_prefix_surround_alt_without_indent = "<localleader>g}",

        keymap_prefix_inverted_surround = "<localleader>(",
        keymap_prefix_inverted_surround_without_indent = "<localleader>g(",
        keymap_prefix_inverted_surround_reversed = "<localleader>)",
        keymap_prefix_inverted_surround_without_indent_reversed = "<localleader>g)",
      },
    },

    -- LOCAL: my playground {{{3
    {
      dir = "~/code/playground/nvim/PROJECTS/play/",
    },
  },
})
