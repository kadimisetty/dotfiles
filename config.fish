# FISH SHELL CONFIGURATION {{{1
# vim: foldmethod=marker:foldlevel=0:nofoldenable:
# AUTHOR: Sri Kadimisetty


# FISH PLUGINS (FUNDLE) {{{1
# FUNDLE FISH PLUGIN MANAGER (https://github.com/danhper/fundle):
# DIRECTIONS:
#   1. Install [fundle itself](https://github.com/danhper/fundle).
#   2. Install
#      [oh-my-fish](https://github.com/oh-my-fish/oh-my-fish#installation).
#   3. List fish plugins`fundle plugin ph-my-fish/plugin` in lines at top of
#      file.
#   4. Initiate fundle with `fundle init` after packages list.
#   5. In a new/reloaded shell run `fundle install` and the plugins are now
#      available.
#   6. Configure and add bindings to plugins as necessary.
#   7. To uninstall, remove the plugin line and on a new/reloaded shell run
#      `fundle clean`.
#   8. To update all plugins, run `fundle update`.
#   9. Periodically update fundle itself with `fundle self-update`.

# LIST PLUGINS (KEEP SORTED AND USE SINGLE QUOTES):
fundle plugin 'jorgebucaran/autopair.fish'
fundle plugin Markcial/upto
fundle plugin catppuccin/fish
fundle plugin decors/fish-colored-man
fundle plugin edc/bass
fundle plugin oh-my-fish/plugin-gi
fundle plugin oh-my-fish/plugin-license
fundle plugin tuvistavie/oh-my-fish-core # for oh-my-fish plugins
if test $(uname) != Darwin
    # ignore these plugins in macos
    fundle plugin oh-my-fish/plugin-pbcopy
end

# START FUNDLE (PLACE AFTER PLUGIN LIST):
fundle init

# CONFIGURE PLUGINS:
# TODO

# LIB {{{1
# IS `pwd` INSIDE GIT REPO? (STATUS/EXPLICIT) {{{2
# Reports if `pwd` is within a git repo by setting status code {{{3
# USAGE: ```
# is_inside_git_repo_STATUS
# if test $status -eq 0
#   echo "OK"
# else
#   echo "FAIL"
# end```
function is_inside_git_repo_STATUS \
    --description "Is `pwd` within a git repo? (with status code)"
    test true = \
        (git rev-parse --is-inside-work-tree 2>/dev/null) 2>/dev/null
end

# Reports if `pwd` is within a git repo explicitly with "true"/"false" {{{3
# USAGE: ```
# if test true = (is_inside_git_repo_EXPLICIT)
#   echo "OK"
# else
#   echo "FAIL";
# end```
function is_inside_git_repo_EXPLICIT \
    --description "Is `pwd` within a git repo? (with true/false)"
    if test true = \
            (git rev-parse --is-inside-work-tree 2>/dev/null) 2>/dev/null
        echo -ns true
    else
        echo -ns false
    end
end

# ECHO VARIANTS {{{2
# TODO: Validate arguments in all variants.
# TODO: Pick appropriate color to print `echo` with.
# TODO: Add `--description` and provide regular description as well.
# TODO: Handle piping in all variants. Look at `echo-ERROR` for inspiration.
# TODO: Use `argparse` as much as possible. and where not possible use
#       `echo-USAGE` to print basic usage info.

# ECHO REFERENCE {{{3
# NOTE: Variants inspired by neovim's '`vim.log.levels.*`.
# TODO: Sync function definitions/description with this table's contents.
# -------------------+--------------------------------------------------------+
# VARIANT            | DESCRIPTION                                            |
# -------------------+--------------------------------------------------------+
# echo               | REGULAR/UNTOUCHED: Print message to `stdout`.          |
#                    |                                                        |
# LOG LEVELS: -------+--------------------------------------------------------+
# echo-INFO          | Print message as informational(`INFO`).                |
# echo-DEBUG         | Print message for debugging purposes(`DEBUG`).         |
# echo-WARN          | Print message as warning(`WARN`) to `stdout`.          |
# echo-ERROR         | Print message as error(`ERROR`) with status code       |
#                    | to `stderr`.                                           |
#                    |                                                        |
# MISC: -------------+--------------------------------------------------------+
# echo-USAGE         | Print message as a function's usage info(`USAGE`).     |
#                    |                                                        |
# TASKS: ------------+--------------------------------------------------------+
# echo-task_INIT     | Print message as a task is initiated(`INIT`).          |
# echo-task_DONE     | Print message as a task is done(`DONE`).               |
# echo-task_WRAP     | Run task(given function) and print message             |
#                    | before(`INIT`) and after(`DONE`) it's execution.       |
#                    |                                                        |
# SECTIONS: ---------+--------------------------------------------------------+
# echo-section_INIT  | Print message as a section beginning(`INIT`).          |
# echo-section_DONE  | Print message as a section ending(`DONE`).             |
# echo-section_WRAP  | Run section(given function) and print messages at      |
#                    | the beginning(`INIT`) and ending(`DONE`) of execution. |
# -------------------+--------------------------------------------------------+

# ECHO LIB {{{3
function _echo_with_customized_message \
    --description "" \
    --argument-names message prefix_label message_color
    # NOTE: When resetting use `normal` to reset all formatting, not just color.
    set_color normal
    set_color $message_color
    echo -s \
        (set_color --bold) \
        $prefix_label": " \
        (set_color --dim --italic) \
        $message
    set_color normal
end


# ECHO LOG LEVELS {{{3
# ECHO INFO
# Print message as informational(`INFO`)
# USAGE: `echo-INFO "Formatting files in this directory"
# OUTPUT(stdout): `INFO: Formatting files in this directory.`
function echo-INFO \
    --description "Print message as informational"
    _echo_with_customized_message $argv INFO $fish_color_quote
end

# ECHO DEBUG
# TODO: Consider `echo-DEBUG` variants for variable/message/function.
# Print message for debugging purposes(`DEBUG`)
# USAGE 1: `echo-DEBUG "Incrmenting counter"
# OUTPUT(stdout): `DEBUG: Incrementing counter
# USAGE 2: `ECHO_DEBUG_DISABLE=1; echo-DEBUG "Can you see me?"
# OUTPUT(stdout): ``
function echo-DEBUG \
    --description "Print message for debugging purposes"
    if not test -n "$ECHO_DEBUG_DISABLE"
        _echo_with_customized_message $argv DEBUG $fish_color_param
    end
end

# ECHO WARN
# Print message as warning(`WARN`) to `stdout`.
# USAGE: `echo-WARN "This will be deprecated soon."
# OUTPUT(stdout): `WARN: This will be deprecated soon.`
# NOTE: Printing to`stdout`(i.e. not `stderr`) on purpose because this is
# a warning and not an error.
function echo-WARN \
    --description "Print message as warning to `stdout`"
    _echo_with_customized_message $argv WARN $fish_color_operator
end

# ECHO ERROR
# Print message as error(`ERROR`) with status code to `stderr`.
# TODO: Should return a non-zero status code?
# TODO: Accept error status code as an argument?
# USAGE 1: `echo-ERROR "incorrect configuration file: conf.json"
# OUTPUT(stderr): `ERROR: incorrect configuration file: conf.json`
# USAGE 2: `echo "incorrect configuration file: conf.json" | echo-ERROR`
# OUTPUT(stderr): `ERROR: incorrect configuration file: conf.json`
function echo-ERROR \
    --description "Print message as error to `stderr`"
    # SETUP:
    # Use current theme's error color
    set_color $fish_color_error
    # Init message to eventually print
    set --function msg $argv
    # APPEND PIPED INPUTS:
    if not isatty stdin
        # Append a space f any arguments were supplied
        if test (count $argv) -ne 0
            set --append msg " "
        end
        # Append piped inputs
        cat /dev/stdin | while read each_line
            set --append msg $each_line
        end
    end
    # WRITE TO STDERR:
    # Bail if no arguments were given/piped in
    if test "$msg" = "" || test "$msg" = " "
        # Print error (i.e. no arguments given) to stderr
        echo "echo-ERROR: ERROR: No argument(s) provided" >&2
    else
        # Print error to stderr as desired
        echo -s "ERROR: " $msg >&2
    end
    # CLEANUP:
    # Restore fish shell print color
    set_color $fish_color_normal
    return 1 # STATUS CODE 1: ` EPERM 1 operation not permitted
end

# ECHO MISC {{{3
# ECHO USAGE
# Print message as a function's usage info(`USAGE`)
# USAGE: `echo-USAGE "xxx (REQ:option1) (OPT:flag)"
# OUTPUT(stdout): `USAGE: xxx (REQ:option1) (OPT:flag)`
function echo-USAGE \
    --description "Print message as a function's usage info"
    _echo_with_customized_message "`$argv`" USAGE $fish_color_quote
end

# ECHO TASKS {{{3
# ECHO TASK INIT
# Print message as a task is initiated(`INIT`)
# USAGE: `echo-task_INIT "Started task"
# OUTPUT(stdout): `INIT: Started task`
function echo-task_INIT \
    --description "Print message as a task is initiated" \
    --argument-names message
    _echo_with_customized_message $message INIT $fish_color_operator
end

# ECHO TASK DONE
# Print message as a task is done(`DONE`).
# USAGE: `echo-task_DONE "Completed task"
# OUTPUT(stdout): `DONE: Completed task`
function echo-task_DONE \
    --description "Print message as a task is done" \
    --argument-names message
    _echo_with_customized_message $message DONE $fish_color_operator
end

# ECHO TASK WRAP
# Run task(given function) and print message before(`INIT`) and after(`DONE`)
# it's execution.
# TODO: Include task function name in message output?
# TODO: Don't just limit to passing in `$message`, use the entire `$argv` here.
# USAGE: `echo-task_WRAP function_that_prints_abc "Running task"
# OUTPUT(stdout): ```
# INIT: Running task
# abc
# DONE: Running task```
function echo-task_WRAP \
    --description "Print message before/after given task is executed" \
    --argument-names task_function message
    if not test -n "$task_function"
        echo-USAGE "echo-task_WRAP (REQ:task_function) (OPT:message)"
        return 1
    end
    if not test -n "$message"
        # NOTE: If message wasn't given, use the function name as message.
        set --function message "`$task_function`"
    end
    if not functions --query $task_function
        echo-ERROR "Function with given name does not exist: $task_function"
        return 1
    else
        echo-task_INIT $message
        eval "$task_function"
        echo-task_DONE $message
    end
end

# ECHO SECTIONS {{{3
# ECHO SECTION INIT
# Print message as a section beginning (`INIT`)
# TODO: Add indention hierarchy for child sections?
# USAGE: `echo-section_INIT "Configuration Section"
# OUTPUT(stdout): ```\n>>> INIT: Configuration Section`
function echo-section_INIT \
    --description "Print message as a section beginning" \
    --argument-names message
    echo # Blank line intended
    _echo_with_customized_message $message ">>> INIT" $fish_color_operator
end

# ECHO SECTION DONE
# Print message as a section ending (`DONE`)
# USAGE: `echo-section_DONE "Configuration Section"
# OUTPUT(stdout): ```<<< DONE: Configuration Section\n`
function echo-section_DONE \
    --description "Print message as a section ending" \
    --argument-names message
    _echo_with_customized_message $message "<<< DONE" $fish_color_operator
    echo # Blank line intended
end

# ECHO SECTION WRAP
# Run section(given function) and print messages at      the beginning(`INIT`)
# and ending(`DONE`) of execution.
# TODO: Don't just limit to passing in `$message`, use the entire `$argv` here.
# USAGE: `echo-SECTION_WRAP function_that_prints_abc "SECTION"
# OUTPUT(stdout): ```
# \n>>> INIT:
# abc
# <<< DONE: SECTION\n```
function echo-section_WRAP \
    --description "Print message before/after given section is executed" \
    --argument-names section_function message
    if not test -n "$section_function"
        echo-USAGE "echo-section_WRAP (REQ:section_function) (OPT:message)`"
        return 1
    end
    if not test -n "$message"
        # NOTE: If message wasn't given, use the function name as message.
        set --function message "`$section_function`"
    end
    if not functions --query $section_function
        echo-ERROR "Function with given name does not exist: `$section_function`"
        return 1
    else
        echo-section_INIT $message
        eval "$section_function"
        echo-section_DONE $message
    end
end


# SOURCE FILE IF IT EXISTS OR FAIL SILENTLY {{{2
# TODO: Provided argument might be 0/singular/plural
# USAGE: `$ source_if_exists ./XXX.md`
function source_if_exists \
    --description "Source file if it exists" \
    --argument-names file_to_source
    if test -e $file_to_source
        source $file_to_source
    end
end


# HISTORY {{{1
# BASH STYLE HISTORY `!!`/`!$` EXPANSIONS {{{2
# TODO: Consider more bash expansions?
# NOTE: Fish cannot do `!$` because it uses `$` for something else, hence `!!!`
function _last_history_item
    echo $history[1] # FIXME: Rewrite, look into `history --null` and `--max` ??
end
function _last_history_item_argument
    # Use `printf` instead of echo according to general recommendation.
    printf '%s' $history[1] | read --tokenize --list last_command_tokens
    and echo $last_command_tokens[-1]
end
# NOTE: `!!!` instead of `!$` because of fish's issues with `$` in strings.
abbr --add '!!!' --position anywhere --function _last_history_item_argument
abbr --add '!!' --position anywhere --function _last_history_item

# HISTORY ALIASES {{{2
# NOTE: Main variants are `--exact`/`--prefix`/`--contains` but history
# provides another dimension of variants with `--max`, `--show-time` and
# `--case-sensitive`, but currently mostly implementing just `--show-time` in
# order to keep the number of aliases manageable.
# HISTORY LIST {{{3
# NOTE: "list" aliases include "search".
# NOTE: I prefer to use `--reverse` on "list" results.
# WITHOUT TIME {{{4
alias history-list-ALL="history"
alias history-list-LAST_1="history --max=1 --reverse"
alias history-list-LAST_5="history --max=5 --reverse"
alias history-list-LAST_10="history --max=10 --reverse"
alias history-list_EXACT_MATCH="history search --exact"
alias history-list_PREFIX_MATCH="history search --prefix"
alias history-list_CONTAINS="history search --contains"

# WITH TIME {{{4
alias history-list-ALL_WITH_TIME="history --show-time"
alias history-list-LAST_1_WITH_TIME="history --max=1 --reverse --show-time"
alias history-list-LAST_5_WITH_TIME="history --max=5 --reverse --show-time"
alias history-list-LAST_10_WITH_TIME="history --max=10 --reverse --show-time"
alias history-list_EXACT_MATCH_WITH_TIME="history search --exact --show-time"
alias history-list_PREFIX_MATCH_WITH_TIME="history search --prefix --show-time"
alias history-list_CONTAINS_WITH_TIME="history search --contains --show-time"

# HISTORY DELETE {{{3
# NOTE: `delete` aliases include `clear` and `clear-session`
alias history-delete="history delete"
alias history-delete_ALL="history clear"
alias history-delete_CURRENT_SESSION="history clear-session"
alias history-delete_EXACT_MATCH="history delete --exact"
alias history-delete_PREFIX_MATCH="history delete --prefix"
alias history-delete_CONTAINS="history delete --contains"

# HISTORY MERGE {{{3
alias history-merge_FROM_OTHER_SESSIONS="history merge"


# COMPLETION HELPERS {{{1
# NOTE: Using "meta-tab" seems like a better fit to open completion with search
# enabled i.e. `complete-and-search`, rather than default "shift tab"(`btab`).
bind \e\t complete-and-search
bind \e\t --mode default complete-and-search
bind \e\t --mode insert complete-and-search


# `fg` SHORTCUT {{{1
# `c-z` sends active process to background, adding shortcut binding `m-z` to
# send to foreground i.e. `fg`.
# FIXME: Once `fg` brings back the active process (example `vim`) and that
# process is closed, there is a message displayed "Send job 1 (vim) to
# foreground" and the shell is also unresponsive awaiting a newline. Make
# these side-effects not show.
bind \ez fg
bind \ez --mode default fg
bind \ez --mode insert fg


# NIX {{{1
# SETUP {{{2
# NOTE: Place as close to top as possible to make nix available immediately.
source_if_exists $HOME/.nix-profile/etc/profile.d/nix.fish

# LOCALE {{{2
if type -q nix && test $(uname) = Linux
    # TODO: See if there's a better way to check for nix presence than `type -q
    # "nix"`.
    # TODO: Check if applicable to macOS.
    # SETTING LOCALE:
    # 	ISSUE: When using Nix(OS/pkg-manager) there is an issue where
    # 	environmental variable LOCALE_ACHIVE doesn't point to the desired
    # 	system's locale-archive.
    #   READ: [Troubleshooting when using nix on non-NixOS linux
    #      distributions](https://nixos.wiki/wiki/Locales)

    if test -e /etc/NIXOS
        # On NixOS
        # Applying this on NixOS as well, because the issue exists on non-bash
        # shells like `fish` etc.
        if test -e /run/current-system/sw/lib/locale/locale-archive
            set --export LOCALE_ARCHIVE /run/current-system/sw/lib/locale/locale-archive
        end
    else
        # TODO: Narrow down this conditional block further. Currently only
        # checking for (non-NixOS) linux here but as noted in the link, this
        # issue and fix is documented as applicable only to Debian, Red Hat,
        # and Arch derivatives.
        if test -e /usr/lib/locale/locale-archive
            set --export LOCALE_ARCHIVE /usr/lib/locale/locale-archive
        end
    end
end

# ALIASES {{{2
#TODO: Repalce `nix-env` aliases with `nix profile`
#alias ne='nix-env'
#alias neh='nix-env --help'
#alias nei='nix-env --install'
#alias neiattr='nix-env --install --attr'
#alias neuninstall='nix-env --uninstall'
#alias neq='nix-env --query --description'
#alias neqi='nix-env --query --installed --description'
#alias neqa='nix-env --query --available --description'
#alias nelg='nix-env --list-generations'
#alias nesg='nix-env --switch-generation'
#alias ns='nix-shell'
#alias nixx='nix --extra-experimental-features "nix-command flakes repl-flake"'
#function noption --description "value of given config option"
#    nix-instantiate \
#        --eval \
#        --expr "(import <nixpkgs/nixos> {}).config."$argv[1] $argv[2..-1]
#end


# COMMON FISH SPECIFIC PREFERENCES {{{1
# DISABLE WELCOME GREETING {{{2
set fish_greeting ""

# THEME{{{2
# DRACULA {{{3
# fish_config theme choose Dracula

# TOKYO NIGHT {{{3
# fish_config theme choose tokyonight_day
# fish_config theme choose tokyonight_moon
# fish_config theme choose tokyonight_night
# fish_config theme choose tokyonight_storm

# CATPPUCCIN {{{3
# FIX: fundle isn't installing theme; for now manually installing in fish's
# theme location
# fish_config theme save "Catppuccin Latte"
# fish_config theme save "Catppuccin Frappe"
# fish_config theme save "Catppuccin Macchiato"
fish_config theme choose "Catppuccin Mocha"

# SET VIM AS DEFAULT EDITOR {{{2
set --export EDITOR nvim
set --export VISUAL nvim
set fish_cursor_default block # `default` includes normal and visual modes
set fish_cursor_insert line
set fish_cursor_replace_one underscore

# PUT PERSONAL EXECUTABLES ON PATH (Create dir if not present) {{{2
if ! test -e "$HOME/bin"
    mkdir $HOME/bin
end
fish_add_path $HOME/bin/
# PUT COMMONLY USED BIN PATH ON PATH (used by `stack` etc. Create dir if not
# present.):
if ! test -e "$HOME/.local/bin"
    mkdir $HOME/.local/bin
end
fish_add_path $HOME/.local/bin
function fish_command_not_found
    echo -s \
        (set_color $fish_color_error --dim) "ERROR: Command `" \
        (set_color normal) \
        (set_color $fish_color_error --bold ) "$argv[1]" \
        (set_color normal) \
        (set_color $fish_color_error --dim) "` not found." >&2
    set_color normal
end


# SHELL SPECIFIC ALIASES {{{1
# MISC {{{2
# TODO: Move `mcd` into LIB section
function mcd --description "`mkdir` and `cd` into new directory"
    mkdir $argv
    and cd $argv
end
alias l="ls -A" # On macos `-A` exist but not longform `--almost-all`
alias ls-ALL="ls -A" # Same as my earlier `l` alias; just for clarity's sake.
alias rm-confirm="rm -i" # Request confirmation
# Quick `cd` into specified directories like `$HOME/code/`
# set CDPATH $HOME/code/

# DESIGN {{{2
set --export DESIGN_DIR "$HOME/design//"
alias design-EXTERNAL="cd $HOME/design/design-external/"
alias design-KEEP="cd $HOME/design/design-keep/"
alias design-PERSONAL="cd $HOME/design/design-personal/"
alias design-PLAYGROUND="cd $HOME/design/design-playground/"
alias design-SANDBOX="cd $HOME/design/design-sandbox/"

# CODE {{{2
set --export CODE_DIR "$HOME/code/"
# NOTE: Using both `code-*` and `*` alias variations for convenience sake.
alias dotfiles="cd $HOME/code/personal/dotfiles/"
alias external="cd $HOME/code/external/"
alias keep="cd $HOME/code/keep/"
alias personal="cd $HOME/code/personal/"
alias playground="cd $HOME/code/playground/"
alias sandbox="cd $HOME/code/sandbox/"
alias code-DOTFILES="cd $HOME/code/personal/dotfiles/"
alias code-EXTERNAL="cd $HOME/code/external/"
alias code-KEEP="cd $HOME/code/keep/"
alias code-PERSONAL="cd $HOME/code/personal/"
alias code-PLAYGROUND="cd $HOME/code/playground/"
alias code-SANDBOX="cd $HOME/code/sandbox/"


# VI MODE ENHANCEMENTS {{{1
# ENABLE VI MODE:
fish_vi_key_bindings

# NOTE: Some terminals like wezterm have issues with displaying fish cursor
# appropriately, use this option to explicitly set the vi cursor. SEE:
# 1. https://github.com/wez/wezterm/issues/2781
# 2. https://fishshell.com/docs/current/interactive.html
set fish_vi_force_cursor 1

# READLINE BINDINGS ENHANCEMENTS FOR VI MODE (INSERT + NORMAL) {{{2
# NOTE: `bind --function-names` shows bindable input functions
# TODO: Only bind when vi mode is enabled.
# TODO: Use a function to simplify these binding assingments.
# MOVING {{{3
bind \ca --mode default beginning-of-line
bind \ca --mode insert beginning-of-line
bind \ce --mode default end-of-line
bind \ce --mode insert end-of-line
bind \cb --mode default backward-char
bind \cb --mode insert backward-char
bind \cf --mode default forward-char
bind \cf --mode insert forward-char
bind \eb --mode default backward-word
bind \eb --mode insert backward-word
bind \ef --mode default forward-word
bind \ef --mode insert forward-word

# EDITING {{{3
bind \ct --mode default transpose-chars
bind \ct --mode insert transpose-chars
bind \et --mode default transpose-words
bind \et --mode insert transpose-words
bind \eu --mode default upcase-word
bind \eu --mode insert upcase-word
bind \el --mode default downcase-word
bind \el --mode insert downcase-word
bind \ec --mode default capitalize-word
bind \ec --mode insert capitalize-word


# KITTY {{{1
if test -n "$KITTY_WINDOW_ID"
    function icat --description "Display image(s) inline"
        # NOTE: icat is a kitten(kitty plugin)
        kitty +kitten icat --align=left $argv
    end
end


# PROMPT {{{1
# PROMPT COMPONENTS {{{2
# SPACER PROMPT COMPONENT {{{3
# TODO: Squash condition guards
function _spacer_prompt_component \
    --argument-names space_count
    if not test -n "$space_count" # Argument exists?
        or not math $space_count &>/dev/null # Argument is a number?
        or test $space_count -le 0 &>/dev/null # Argument is greater than 0?
        return 1
    end
    echo -ns (string repeat --count $number_of_spaces " ")
end

# ROOT PROMPT COMPONENT {{{3
function _root_prompt_component \
    --argument-names left_margin right_margin
    if fish_is_root_user
        _spacer_prompt_component $left_margin
        set_color $fish_color_cwd_root
        echo -ns ROOT
        set_color $fish_color_normal
        _spacer_prompt_component $right_margin
    end
end

# CURRENT WORKING DIRECTORY PROMPT COMPONENT {{{3
function _cwd_prompt_component \
    --argument-names left_margin right_margin
    _spacer_prompt_component $left_margin
    if fish_is_root_user
        set_color $fish_color_cwd_root --bold
    else
        set_color white --dim # ALTERNATES: `fish_color_cwd`
    end
    echo -ns (prompt_pwd)
    set_color $fish_color_normal
    _spacer_prompt_component $right_margin
end

# INPUT INDICATOR PROMPT COMPONENT {{{3
function _vi_aware_input_indicator_prompt_component \
    --argument-names previous_command_status left_margin right_margin
    _spacer_prompt_component $left_margin
    set_color white --dim
    # ALTERNATES:              "" #     󰁜  󰁜  󱦲
    set --function _prompt_ok_symbol " "
    set --function _prompt_error_symbol " "
    # `$_previous_command_status` SUCCESS codes: 0
    # `$_previous_command_status` FAILURE codes: 1/12/123/124/125/126/127…
    if test $previous_command_status -eq 0
        # SEE: https://fishshell.com/docs/current/cmds/fish_mode_prompt.html
        switch $fish_bind_mode
            case insert
                set_color $fish_color_comment --dim
            case default
                set_color brblue --dim
            case replace_one
                set_color magenta --dim
            case replace
                set_color brmagenta --dim
            case visual
                set_color bryellow --dim
            case "*"
                set_color brred --dim
        end
        echo -ns $_prompt_ok_symbol
    else
        set_color $fish_color_error --bold
        echo -ns $_prompt_error_symbol
    end
    set_color $fish_color_normal
    _spacer_prompt_component $right_margin
end

# BACKGROUND JOBS PROMPT COMPONENT {{{3
function _background_jon_prompt_component \
    --argument-names left_margin right_margin
    set --function background_jobs_count (jobs | wc -l | string trim)
    if test $background_jobs_count -gt 0
        _spacer_prompt_component $left_margin
        set_color $fish_color_command --bold
        echo -ns "󰒲 "$background_jobs_count
        set_color $fish_color_normal
        _spacer_prompt_component $right_margin
    end
end

# ERROR STATUS INDICATOR PROMPT COMPONENT {{{3
function _error_status_prompt_component \
    --argument-names previous_command_status left_margin right_margin
    if test $previous_command_status -ne 0 # i.e. not success status code (0)
        _spacer_prompt_component $left_margin
        set_color $fish_color_error
        set --function _error_indicator_symbol " " # 🅔
        echo -ns $_error_indicator_symbol
        echo -ns "E:"(fish_status_to_signal $previous_command_status)
        set_color $fish_color_normal
        _spacer_prompt_component $right_margin
    end
end

# PRIVATE MODE PROMPT COMPONENT {{{3
function _private_mode_component \
    --argument-names left_margin right_margin
    if test -n "$fish_private_mode"
        _spacer_prompt_component $left_margin
        set_color magenta --dim
        echo -ns PRIVATE
        set_color $fish_color_normal
        _spacer_prompt_component $right_margin
    end
end

# GIT PROMPT COMPONENT {{{3
function _git_prompt_component \
    --argument-names left_margin right_margin
    _spacer_prompt_component $left_margin
    set_color brblack
    echo -ns (fish_git_prompt)
    set_color $fish_color_normal
    _spacer_prompt_component $right_margin
end

# GIT COMMIT INDICATOR PROMPT COMPONENT {{{3
# TODO: Change color intensity (like in a github user's 'contribution graph).
# TODO: Make a multiple day(weekly/monthly etc.) component variant.
# TODO: Allow configuring direction LTR/RTL (useful for multiple day variants).
# TODO: Allow activation under a particular "root directory"" only. For
# example, activate only when one of the parent directories is "personal" which
# could indicate that this component be activated only on "personal repos".
# TODO: Use `argparse` to handle function arguments.
# TODO: Accept symbols/duration/intensity as function parameters.
#
# Displays indicator that conveys whether commits were made in given duration
function _git_commit_count_indicator_prompt_component \
    --argument-names left_margin right_margin date_specificier
    # TODO: Set `date_specificier` default to "midnight"
    if test true = (is_inside_git_repo_EXPLICIT)
        set --function symbol_no_commit " " # ALTERNATES: 󱓼
        set --function symbol_one_or_more_commits " " # ALTERNATES:    󱓻
        _spacer_prompt_component $left_margin
        # NOTE: This condition includes the case of a git repo with no initial
        # commit made yet. Exercise caution when changing.
        if test 1 -gt (git log --oneline --since=$date_specificier 2>/dev/null \
          | string trim \
          | wc -l)
            # COMMITS MADE TODAY: 0
            set_color $fish_color_operator
            echo -ns $symbol_no_commit
        else
            # COMMITS MADE TODAY: 1 OR MORE
            set_color $fish_color_comment
            echo -ns $symbol_one_or_more_commits
        end
        _spacer_prompt_component $right_margin
        set_color $fish_color_normal
    end
end

# MAIN PROMPT {{{2
function fish_mode_prompt
    # NOTE: KEEP EMPTY: `fish_mode_prompt` has to return nothing in order to
    # allow "vi mode status" to get called inside `fish_prompt`.
end
function fish_prompt
    # NOTE: KEEP AT TOP: Previous command status has to be captured at top.
    set --function previous_command_status $status
    _spacer_prompt_component 1
    _root_prompt_component 0 1
    _cwd_prompt_component 0 1
    _vi_aware_input_indicator_prompt_component $previous_command_status 0 1
end
function fish_right_prompt
    # NOTE: KEEP AT TOP: Previous command status has to be captured at top.
    set --function previous_command_status $status
    _error_status_prompt_component $previous_command_status 1 0
    _git_commit_count_indicator_prompt_component 1 0 midnight
    _private_mode_component 1 0
    _background_jon_prompt_component 1 0
    _git_prompt_component 0 0
end

# GIT PROMPT SETTINGS {{{2
# NOTE:
# 1. Filled circle for staged file related states
# 2. Unfilled circle for unstaged file related states
set __fish_git_prompt_show_informative_status true
set __fish_git_prompt_use_informative_chars true
set __fish_git_prompt_char_stateseparator ""
# GIT PROMPT GENERAL COLORS:
set __fish_git_prompt_color $fish_color_comment # ALTS: brblack
set __fish_git_prompt_color_bare blue
set __fish_git_prompt_color_prefix brblack
set __fish_git_prompt_color_suffix brblack
# GIT PROMPT CLEAN STATE:
set __fish_git_prompt_char_cleanstate "  " # ALTS:  , 󰊢 ,  , 
set __fish_git_prompt_color_cleanstate $fish_color_comment
# GIT PROMPT DIRTY STATE (UNSTAGED FILES) WITH CHANGES EXIST:
set __fish_git_prompt_showdirtystate true
set __fish_git_prompt_char_dirtystate " 󱨧 " # ALTS: , 
set __fish_git_prompt_color_dirtystate brred
# GIT PROMPT STAGED FILES WITHOUT ADDITIONAL CHANGES EXIST:
set __fish_git_prompt_char_stagedstate "  "
set __fish_git_prompt_color_stagedstate yellow
# GIT PROMPT UNTRACKED FILES EXIST:
set __fish_git_prompt_showuntrackedfiles true
set __fish_git_prompt_char_untrackedfiles "  " # ALTS:   
set __fish_git_prompt_color_untrackedfiles brmagenta
# GIT PROMPT INVALID STATE:
# NOTE: In fish git prompt parlance, "unmerged" changes can be considered
# additional changes to already added files.
set __fish_git_prompt_char_invalidstate "  " # ALTS: 
set __fish_git_prompt_color_invalidstate brred
# GIT PROMPT UPSTREAM AND DOWNSTREAM DIFFERENCES:
set __fish_git_prompt_showupstream auto
set __fish_git_prompt_char_upstream_ahead " "
set __fish_git_prompt_char_upstream_behind " "
set __fish_git_prompt_color_upstream yellow
# TODO: LOOK INTO `*_DONE` COLORS:
#   https://fishshell.com/docs/current/cmds/fish_git_prompt.html?highlight=git
#   set __fish_git_prompt_color_upstream_done "green"
# GIT PROMPT STASH:
set __fish_git_prompt_showstashstate true
set __fish_git_prompt_char_stashstate "  " # ALTS:   
set __fish_git_prompt_color_stashstate $fish_color_comment # ALTS: brblack


# LSD {{{1
# TODO: [Setup configuration](https://github.com/Peltoche/lsd#configuration)
alias lsd-long='lsd --long'
alias lsd-tree='lsd --tree'
alias lsd-tree_DEPTH_1='lsd --tree --depth 1'
alias lsd-tree_DEPTH_2='lsd --tree --depth 2'
alias lsd-tree_DEPTH_3='lsd --tree --depth 3'
alias lsd-tree_DEPTH='lsd --tree --depth' # User supplies "depth"


# EXA {{{1
# TODO: exa is abandoned, switch to [eza](https://github.com/eza-community/eza)
alias exa-tree="exa --tree"
alias exa-tree_GIT="exa --tree --git-ignore --git"


# CD UPWARDS WITH `..`S {{{1
# NOTE: Feature parity with fish plugin `danhper/fish-fastdir`:
#   1. Not doing the plugin's directory history stack helpers `d` in favor of
#      fish's directory history combo: `dirh`/`cdh`/`prevd`/`nextd`. There is
#      also fish's directory stack combo: `dirs`/`pushd`/`popd`.
#   2. Offering 4 level upwards just like the plugin.
#   3. Not doing `alias ..="cd ../"` because `..` works natively.
alias ...="cd ../../"
alias ....="cd ../../../"


# `make` SHORTCUTS {{{1
# TODO:
#   1. Generate automatically to avoid repetition.
#   2. Grab content of echo from function meta description. Tied to "1".
# NOTE: Keep keybindings in tandem with equivalents in neovim config:
# - `\em\em`: `make`
# - `\em\eb`: `make build`
# - `\em\er`: `make run`
# - `\em\ec`: `make clean`
# - `\em\ef`: `make fmt`
# - `\em\et`: `make test`
# `make` {{{2
function _make --description make --wraps make
    set_color normal
    set_color --bold --italics
    echo make
    set_color normal
    make
    commandline --function repaint
end
bind \em\em _make
bind \em\em --mode default _make
bind \em\em --mode insert _make
# `make build` {{{2
function _make_build --description "make build" --wraps "make build"
    set_color normal
    set_color --bold --italics
    echo "make build"
    set_color normal
    make build
    commandline --function repaint
end
bind \em\eb _make_build
bind \em\eb --mode default _make_build
bind \em\eb --mode insert _make_build
# `make run` {{{2
function _make_run --description "make run" --wraps "make run"
    set_color normal
    set_color --bold --italics
    echo "make run"
    set_color normal
    make run
    commandline --function repaint
end
bind \em\er _make_run
bind \em\er --mode default _make_run
bind \em\er --mode insert _make_run
# `make clean` {{{2
function _make_clean --description "make clean" --wraps "make clean"
    set_color normal
    set_color --bold --italics
    echo "make clean"
    set_color normal
    make clean
    commandline --function repaint
end
bind \em\ec _make_clean
bind \em\ec --mode default _make_clean
bind \em\ec --mode insert _make_clean
# `make fmt` {{{2
function _make_fmt --description "make fmt" --wraps "make fmt"
    set_color normal
    set_color --bold --italics
    echo "make fmt"
    set_color normal
    make fmt
    commandline --function repaint
end
bind \em\ef _make_fmt
bind \em\ef --mode default _make_fmt
bind \em\ef --mode insert _make_fmt
# `make test` {{{2
function _make_test --description "make test" --wraps "make test"
    set_color normal
    set_color --bold --italics
    echo "make test"
    set_color normal
    make test
    commandline --function repaint
end
bind \em\et _make_test
bind \em\et --mode default _make_test
bind \em\et --mode insert _make_test


# GIT {{{1
# TODO: Import the git aliases section back here as soon as possible.
source ~/code/personal/fish-git-thing/gitaliases.fish
# `cd` upwards to root git directory
# TODO: Accept argument sub directory with heirarchy calculated from git root
# directory, like in fugitive's `Gcd`.
alias gcd='cd (git rev-parse --show-toplevel)'

# FZF {{{1
# ripgrep options being used to power fzf:
#           --files             : Print file's names but not their content
#           --hidden            : Search hidden files and directories
#           --smart-case        : Search smart with upper and lower case
#           --glob "!.git/*"    : Ignore .git/ folder
set --export \
    FZF_DEFAULT_COMMAND 'rg --files --hidden --smart-case --glob "!.git/*"'

function _fzf_search_history --description "Search command history with `fzf`"
    # TODO: Ensure `fzf` is installed locally
    # Get history and pipe into fzf
    history --null |
        # Run fzf using history's entries as source
        fzf \
            # Prefill query with command line content
            --query=(commandline) \
            # Prompt indicator
            --prompt=" " \
            # Current line indicator
            --pointer="" \
            # Enable multi-selection
            --multi \
            # Selected line indicator
            --marker="+" \
            # Read input delimited by ascii null
            --read0 \
            # Print input delimited by ascii null
            --print0 \
            # Not fullscreen but hang down with this much height under cursor
            --height=10 \
            # Extra left margin to align text with my prompt
            --padding="0,0,0,2" \
            # Keep default layout with prompt and first result at bottom
            --layout="default" \
            # Show info to right end of prompt line
            --info="inline-right" \
            # Theme slightly customized from default base theme
            # NOTE: Place ANSI attributes(`bold`) before other styles
            --color="fg+:bold,gutter:-1,info:italic,info:dim,separator:dim" \
            # When other multi-selections are selected and enter is hit on a
            # unselected line, the current unselected line is not chosen and
            # only the previously selected lines are chosen. Fix that behavior
            # with enter
            --bind="enter:select+accept" \
            # Accept current line, ignoring other selections
            --bind="alt-enter:clear-selection+accept" \
            # Tab toggles selection without moving line
            --bind="tab:toggle" \
            # Shift-tab deselects without moving line
            --bind="btab:deselect" \
            # Vertical movement
            --bind="ctrl-alt-n:first,ctrl-alt-p:last" \
            --bind="ctrl-alt-j:first,ctrl-alt-k:last" \
            # NOTE: Cannot do`ctrl-alt` + up/down as it is not available
            # --bind="ctrl-alt-up:first,ctrl-alt-p:down" \
            # Offset up/down, like with `c-e`/`c-y` in vim
            --bind="ctrl-e:offset-down,ctrl-y:offset-up" \
            # Select/deselect up/down wards. (Aids consecutive selections)
            # (Currently not doing n/p+j/k just up/down)
            --bind="shift-up:select+up,shift-down:select+down" \
            --bind="alt-shift-up:deselect+up,alt-shift-down:deselect+down" \
            # TODO: Ensure this history file location exists and is
            # periodically cleared out.
            --history="$HOME/.cache/fzf-history/fzf-history-file" \
            # NOTE: When history is specified, `c-n`/`c-p` is  automatically
            # remapped to next/prev history, so explicitly rebind that
            # don't want it
            --bind="alt-up:prev-history,alt-down:next-history" \
            # Preview disabled
            # --bind="ctrl-alt-f:preview-page-up,ctrl-alt-b:preview-page-down" \
            # --preview-window="right" \
            # --preview="cat {}" \ # "head -$LINES {}"
            # Strategy to use when search scores are tied
            --tiebreak=index |
        # Split string received on null byte
        string split0 |
        # Remove blank line between "multi-selections"
        string replace "\n\n" "\n" |
        # Trim trailing/leading whitespace
        # string trim |
        # Remove end-of-file blank line in "multi-selections"
        string collect |
        # Store received string into `$result`
        read --function --null result
    # Run only if previous command succeeds,
    # replacing commandline with previous result.
    and commandline --replace -- $result
    # Repaint commandline. Necessary to avoid UI glitches.
    commandline --function repaint
end
# Trigger fzf search with `<C-r>`
bind \cr _fzf_search_history
bind \cr --mode default _fzf_search_history
bind \cr --mode insert _fzf_search_history


# DIRENV {{{1
# SEE: https://direnv.net/docs/hook.html#fish
# HOOK INTO FISH SHELL:
direnv hook fish | source
# TRIGGER DIRENV AT PROMPT ONLY (original behavior in other shells):
# set -g direnv_fish_mode disable_arrow


# VIM {{{1
alias v="vim"
alias v-config_NONE="vim --clean"
# TODO: alias v-config_BASIC="vim --clean -S ~/basic.vim"
alias v-session="vim -S ./Session.vim" # WARN: Hardcoded session file name
alias v-readonly='view'
alias v-HORIZONTAL='vim -o' # Horizontal splits
alias v-VERTICAL='vim -O' # Vertical splits
alias v-TABS='vim -p'


# NVIM {{{1
# TODO: Add alias for opening with a plugin-free minimal configuration.
# TODO: Add alias for opening with `neotree` open (regular/readonly variants).
# TODO: Add alias for opening with a git commit log open.
alias n="nvim"
alias n-readonly="nvim -R"
alias n-config_NONE="nvim --clean"
alias n-session="nvim -S ./Session.vim" # WARN: Hardcoded session file name
alias n-HORIZONTAL='nvim -o' # Horizontal splits
alias n-VERTICAL='nvim -O' # Vertical splits
alias n-TABS='nvim -p'
function n-man --description "Open man page for given command name in neovim"
    if test 1 -ne (count $argv)
        # ENSURE SINGLE ARGUMENT:
        echo-ERROR "takes one argument"
    else if not man $argv &>/dev/null
        # ENSURE MAN PAGE EXISTS FOR GIVEN COMMAND
        echo-ERROR "no man page for: $argv"
    else
        # LOAD NVIM WITH MAN PAGE OF GIVEN COMMAND
        nvim \
            # Open man page for given command
            -c "Man $argv" \
            # Move that opened man page to it's own tabpage
            -c "execute \"normal! \<c-w>T\"" \
            # Make that the only tabpage open
            -c "execute \"tabonly\"" \
            # Delete initial blank buffer
            -c "execute \"bd 1\""
    end
end


# TMUX/TMUXINATOR {{{1
alias t="tmux"
alias t-list_sessions="tmux list-sessions"
function t-attach \
    --description "Attach tmux to a running session with name provided as arg"
    tmux attach -t $argv
end
alias t-start_tmuxinator_config="tmuxinator start ./.tmuxinator.yml"


# MIX/PHOENIX(ELIXIR) {{{1
# MIX {{{2
alias x="mix"
alias x-version="mix --version"
alias x-build="mix build"
alias x-compile="mix compile"
alias x-new="mix new"
function x-new_cd \
    --wraps "mix new" \
    --description "Does `mix new` and `cd`s into the new dir"
    if mix new $argv
        cd $argv
    end
end

# DEPS {{{2
alias x-deps_get="mix deps.get"
alias x-deps_clean="mix deps.clean"
alias x-deps_clean_ECTO="mix deps.clean ecto"
alias x-deps_clean_ALL="mix deps.clean --all"
alias x-deps_clean_UNUSED="mix deps.clean --unused"
alias x-deps_clean_COMPILED_ONLY="mix deps.clean --build"
alias x-deps_compile="mix deps.compile"
alias x-deps_compile_ECTO="mix deps.compile ecto"
alias x-deps_tree="mix deps.tree"
alias x-deps_update="mix deps.update"
alias x-deps_update_ALL="mix deps.update --all"

# TEST {{{2
alias x-test="mix test"
alias x-test_SYNC="mix test --max-cases=1"
alias x-test_VERBOSE="mix test --trace" # Also forces running tests in sync
alias x-test-COVERAGE="mix test --cover"
alias x-test_FAILED_PREVIOUS="mix test --failed"

# IEX {{{2
alias x-iex="iex"
alias x-iex_MIX="iex -S mix"

# ECTO {{{2
alias x-ecto_setup="mix ecto.setup"
alias x-ecto_create="mix ecto.create"
alias x-ecto_migrate="mix ecto.migrate"
alias x-ecto_reset="mix ecto.reset"

# PHOENIX {{{2
alias x-phx_new="mix phx.new"
alias x-phx_server="mix phx.server"
alias x-phx_version="mix phx.new --version"
alias x-phx_update="mix archive.install hex phx_new"
function x-phx_new_cd \
    --wraps "mix phx.new" \
    --description "Does `mix phx.new` and `cd`s into the new dir"
    if mix phx.new $argv
        cd $argv
    end
end
# TODO: Update with relevant `echo` variants
function x-phx_new_cd_setup \
    --wraps "mix phx.new" \
    --description "Does `mix phx.new` and sets up new project"
    set --function app_name $argv
    # PROJECT INIT
    echo-HEADER "CREATING NEW PHOENIX PROJECT: "$app_name
    if mix phx.new $argv --install # Create new phoenix project and install deps
        echo "DONE: "$app_name" created"
        cd $argv # `cd` into new project
        mix setup
        # GIT INIT
        echo "INIT: SETTING UP GIT"
        git init
        git add --all
        git commit --message "mix phx.new"
        echo "DONE: SETTING UP GIT"
        # SERVER RUN
        echo "INIT: STARTING PHOENIX SERVER ..."
        mix phx.server --open # Run server and open hosted site in browser
    end
end


# FLY {{{1
set --export FLYCTL_INSTALL "$HOME/.fly"
fish_add_path $FLYCTL_INSTALL/bin/


# PYTHON {{{1
# VIRTUAL ENVIRONMENT UTILITIES {{{2
# TODO: Accept a virtual environment name (other than "venv").
# CREATE VIRTUAL ENVIRONMENT {{{3
function v-create \
    --description "Create python virtual environment in `./venv/`"
    # TODO: Check for proper python version
    if test -e "./venv"
        echo-ERROR "`./venv/` exists"
    else
        python3 -m venv ./venv
    end
end

# ACTIVATE VIRTUAL ENVIRONMENT {{{3
function v-activate \
    --description "Activate python virtual environment from `./venv/`"
    # TODO: Accept virtual environment name other than just hard-coded `venv`
    if test -e "./venv/bin/activate.fish"
        source ./venv/bin/activate.fish
    else
        echo -e "./venv/bin/activate.fish" |
            echo-ERROR "Fish file to activate python environment not found:"
    end
end

# DEACTIVATE VIRTUAL ENVIRONMENT {{{3
function v-deactivate \
    --description "Deactivate python virtual environment from `./venv/`"
    # NOTE: Consider replacing the "deactivate" command (should be set somwhere
    # in `v-activate` function perhaps).
    if test -n "$VIRTUAL_ENV"
        set --function virtual_env_name $VIRTUAL_ENV
        deactivate
        # TODO: Make this report only the relative name of the virtual
        # environment not the entire path i.e. relative to current directory
        # e.g. "./venv" and not "~/code/project/venv".
        set --function dir_separator / # NOTE: Assuming *nix OS
        and echo -s "Deactivated python virtual environment: " \
            (set_color --dim) \
            (path dirname $virtual_env_name)$dir_separator \
            (set_color --bold) \
            (path basename $virtual_env_name)
    else
        echo-ERROR "Not in active python environment"
    end
end

# CREATE AND ACTIVATE VIRTUAL ENVIRONMENT {{{3
function v-create_activate \
    --description "Create and activate python virtual environment `./venv/`"
    v-create and v-activate
end

# EXIT IF VIRTUAL ENVIRONMENT NOT ACTIVE {{{3
function _exit_if_not_in_active_python_virtual_env \
    --description "Exit with failure if python virtual environment not active"
    if ! test -n "$VIRTUAL_ENV"
        echo-ERROR "Not in active python environment"
    end
end


# DJANGO {{{1
# MANAGE.PY ALIASES {{{2
# TODO: Print all `manage.py` aliases with a cmd such as `m-aliases`
# TODO: Use a generator function to generate these aliases in order to do the
# `_exit_if_not_in_active_python_virtual_env` automatically.
function m \
    --description "./manage.py"
    _exit_if_not_in_active_python_virtual_env
    and ./manage.py $argv
end
function m-runserver \
    --description "./manage.py runserver"
    _exit_if_not_in_active_python_virtual_env
    and ./manage.py runserver
end
function m-collect_static \
    --description "./manage.py collectstatic"
    _exit_if_not_in_active_python_virtual_env
    and ./manage.py collectstatic
end
function m-create_superuser \
    --description "./manage.py createsuperuser"
    _exit_if_not_in_active_python_virtual_env
    and ./manage.py createsuperuser
end
function m-migrate \
    --description "./manage.py migrate"
    _exit_if_not_in_active_python_virtual_env
    and ./manage.py migrate $argv
end
function m-make_migrations \
    --description "./manage.py makemigrations"
    _exit_if_not_in_active_python_virtual_env
    and ./manage.py makemigrations $argv
end
function m-shell \
    --description "./manage.py shell"
    _exit_if_not_in_active_python_virtual_env
    and ./manage.py shell
end
function m-startapp \
    --description "./manage.py startapp"
    _exit_if_not_in_active_python_virtual_env
    and ./manage.py startapp $argv
end
function m-sqlmigrate \
    --description "./manage.py sqlmigrate"
    _exit_if_not_in_active_python_virtual_env
    and ./manage.py sqlmigrate $argv
end
function m-test \
    --description "./manage.py test"
    _exit_if_not_in_active_python_virtual_env
    and ./manage.py test $argv
end
# TODO: Check whether `testserver` flag is valid
function m-test_server \
    --description "./manage.py testserver"
    _exit_if_not_in_active_python_virtual_env
    and ./manage.py testserver
end
# [django-extension](https://github.com/django-extensions/django-extensions):
function m-show_urls \
    --description "./manage.py show_urls"
    _exit_if_not_in_active_python_virtual_env
    and ./manage.py show_urls $argv
end
function m-validate_templates \
    --description "./manage.py validate_templates"
    _exit_if_not_in_active_python_virtual_env
    and ./manage.py validate_templates
end
function m-shell_PLUS \
    --description "./manage.py shell_plus"
    _exit_if_not_in_active_python_virtual_env
    and ./manage.py shell_plus
end
function m-runserver_PLUS \
    --description "./manage.py runserver_plus"
    _exit_if_not_in_active_python_virtual_env
    and ./manage.py runserver_plus
end


# RUST/CARGO {{{1
fish_add_path $HOME/.cargo/bin/
function c-new_cd \
    --description "Does `cargo new` and `cd`s into the new dir"
    if cargo new $argv
        cd $argv[1]
    end
end
alias c="cargo"
alias c-add="cargo add"
alias c-build="cargo build"
alias c-build_QUIET="cargo build --quiet"
alias c-check="cargo check"
alias c-clippy="cargo clippy"
alias c-doc_open="cargo doc --open"
alias c-doc_open_STD="rustup doc --std"
alias c-fix="cargo fix"
alias c-format="cargo fmt"
alias c-new="cargo new"
alias c-run="cargo run"
alias c-run_QUIET="cargo run --quiet"
alias c-test="cargo test"
alias c-test_QUIET="cargo test --quiet"
alias c-tree_DEPTH1="cargo tree --depth 1"
alias c-watch="cargo watch"
alias c-watch_QUIET="cargo watch --quiet"

# HASKELL {{{1
# GHCUP {{{2
# NOTE: Converted to fish from  `ghcup`'s zsh init script
fish_add_path $HOME/.ghcup/bin

# CABAL {{{2
fish_add_path $HOME/.cabal/bin

#TODO: `cabal init` with lib/exe/both
alias b-init="cabal init"
alias b-init_interactive_ON="cabal init --interactive"
alias b-init_interactive_OFF="cabal init --non-interactive"
alias b-build_dryrun="cabal build --dry-run"
alias b-build_reinstall_OFF="cabal build --avoid-reinstalls"
alias b-build_reinstall_ON="cabal build --reinstall"
alias b-build_reinstall_ON_FORCED="cabal build --force-reinstalls"
alias b-build_dependencies_ONLY="cabal build --only-dependencies"
alias b-build_dependencies_UPGRADE="cabal build --upgrade-dependencies"
alias b-run="cabal run"
alias b-exec="cabal exec"
alias b-check="cabal check"
alias b-clean="cabal clean"
alias b-test="cabal test"
alias b-update="cabal update"
function b-init_cd \
    --description "Creates new dir and runs `cabal init` inside" \
    --argument-names project_name
    # TODO: Make template customizable and with a default
    # NOTE: Uses stack template `kadimisetty/basic`
    # Assert path with given `$project_name` doesn't exists in `cwd`
    if test -e $project_name
        echo-ERROR "path with given name already exists"
    else
        mkdir $project_name
        and cd $project_name
        and cabal init --non-interactive
    end
end

# STACK {{{2
# NOTE: stack now uses `~/local/bin`, so not adding `~/.stack/bin` to $PATH
alias s-build="stack build"
alias s-build_FAST="stack build --fast"
alias s-clean="stack clean"
alias s-exec="stack exec"
alias s-ghci="stack ghci"
alias s-new="stack new"
alias s-run="stack run"
alias s-test='stack test'
function s-new_cd \
    --description "Runs `stack new` and `cd`s into the reated dir" \
    --argument-names project_name
    # TODO: Make template customizable and with a default
    # NOTE: Uses stack template `kadimisetty/basic`
    # Assert path with given `$project_name` doesn't exists in `cwd`
    if test -e $project_name
        echo-ERROR "path with given name already exists"
    else
        # Run `stack new` using the `kadimisetty/basic` stack template
        stack new $project_name kadimisetty/basic
        # `cd` into the newly created directory
        and cd $project_name
    end
end


# GO {{{1
fish_add_path $HOME/go/bin
alias go-build='go build'
alias go-build_ALL='go build .'
alias go-format='go fmt'
alias go-mod="go mod"
alias go-mod_tidy="go mod tidy"
alias go-run='go run'
alias go-run_ALL='go run .'
alias go-test='go test'
function go-mod_init \
    --description "Run `go mod init` with given arg (default: \$PWD)" \
    --argument-names module_path
    # If no `module_path` argument passed in, use current directory name.
    if not test -n "$module_path"
        set module_path (basename $PWD)
    end
    go mod init $module_path
end
function go-new_cd \
    --description "`mcd`s into given dir name and runs `go mod init` there" \
    --argument-names module_path
    # Exit if no `module_path` argument passed in
    if test -z "$module_path"
        echo-ERROR "no module path given"
        # Exit if path with given name exists in current dir
    else if test -e "$module_path"
        echo-ERROR "path with given name exists"
    else
        # Create a new directory with the name, move into it and run `go mod
        # init` there
        mcd "$module_path"
        and go-mod_init "$module_path"
    end
end


# LUA/LUAROCKS {{{1
fish_add_path $HOME/.luarocks/bin/
set --export luarocks "luarocks --local"


# GREP {{{1
alias grep-IGNORECASE="grep --ignore-case"


# GIT {{{1
# GIT STASH {{{2
# TODO: Insist on an explicit stash number (i.e. do not assume 0 by default):
#         1. Make user specify stash number explicitly, even for the latest one.
#         2. Make convenience variant `gstash-pop_LATEST`(or RECENT).
# TODO: Insist on user confirmation for destructive operations like `clear` etc.
# STASH OPERATIONS {{{3
# FIXME: Interactive stashing?
alias gstash-wip='git stash' # NOTE: `WIP` indicates unstaged work
alias gstash-apply='git stash apply'
alias gstash-apply_WITH_STAGED='git stash apply --index'
alias gstash-delete='git stash drop' # TODO: CONSIDER: Provide `gstash-drop`?
alias gstash-delete_ALL='git stash clear' # TODO: Insist on user confirmation
alias gstash-pop='git stash pop'

# STASH PUSH {{{3
# TODO: Ensure all aliases have interactive versions
alias gstash-push='git stash push'
alias gstash-push_with_message='git stash push --message'
alias gstash-push_INTERACTIVE='git stash push --patch'
alias gstash-push_with_message_INTERACTIVE='git stash push --patch --message'
alias gstash-push_PRESERVE_STAGING_STATUS='git stash push --keep-index' # TODO: VERIFY
alias gstash-push_STAGED='git stash push --staged'
alias gstash-push_STAGED_with_message='git stash push --staged --message'
function gstash-push_UNSTAGED_with_message \
    --description 'Run `git stash push` for unstaged changes' \
    --wraps 'git stash push' \
    --argument-names stash_name
    if test -z "$stash_name" # Insist on `$stash_name`
        echo-ERROR "Stash name not supplied"
    else
        # Create temporary commit of STAGED changes and bypass commit hooks
        git commit --quiet --no-verify \
            --message "DELETEME: TEMPORARY STASH OPERATION ARTIFACT"
        # Push UNSTAGED changes onto stash with given `$stash_name`
        and git stash push --message $argv # `$stash_name` is first in `$argv`
        # Reset to previous HEAD state and restore the committed STAGED changes
        # TODO: Assert temporary commit has been removed here at the end since
        # it might remain if there is an error with above stash operation.
        and git reset --quiet --soft HEAD~1
    end
end
# TODO: `function gstash-push_UNSTAGED_with_message_INTERACTIVE`
# TODO: `function gstash-push_UNSTAGED`: Similar to
# `gstash-push_UNSTAGED_with_message` but will not be receiving a stash name,
# so make a decision on the stash name since by default unnamed stashes will
# derive a name from the latest commit which in this case would be the
# temporary commit which would be unwanted as nothing should remain of the
# temporary commit once this whole operation completes.


# STASH SHOW {{{3
alias gstash-show_NAMES='git stash show --name-status'
alias gstash-show_STAT='git stash show --stat'
alias gstash-show_PATCH='git stash show --patch'
alias gstash-show_PATCH_WITH_STAT='git stash show --patch-with-stat'

# STASH CONVERT {{{3
# TODO: gstash-into_commit
alias gstash-into_BRANCH='git stash branch' # expects: `<branch> [<stash>]`

# STASH LIST {{{3
# NOTE: Time duration variants: (LAST/THIS) (DAY/WEEK/MONTH)
# UNBOUND {{{4
alias gstash-list='git stash list'
alias gstash-list_NAMES='git stash list --name-status'
alias gstash-list_STAT='git stash list --stat'
# LAST DAY {{{4
alias gstash-list_LAST_DAY='git stash list --since=1.day'
alias gstash-list_NAMES_LAST_DAY='git stash list --name-status --since=1.day'
alias gstash-list_STAT_LAST_DAY='git stash list --stat --since=1.day'
# LAST WEEK {{{4
alias gstash-list_LAST_WEEK='git stash list --since=1.week'
alias gstash-list_NAMES_LAST_WEEK='git stash list --name-status --since=1.week'
alias gstash-list_STAT_LAST_WEEK='git stash list --stat --since=1.week'
# LAST MONTH {{{4
alias gstash-list_LAST_MONTH='git stash list --since=1.month'
alias gstash-list_NAMES_LAST_MONTH='git stash list --name-status --since=1.month'
alias gstash-list_STAT_LAST_MONTH='git stash list --stat --since=1.month'
# TODO: THIS DAY {{{4
# TODO: THIS WEEK {{{4
# TODO: THIS MONTH {{{4

# GIT BRANCH {{{2
# BRANCH LISTINGS {{{3
alias gbranch-list_MERGED='git branch --merged'
alias gbranch-list_UNMERGED='git branch --no-merged'
alias gbranch-list_CONTAINS_COMMIT_HASH='git branch --all --contains commit_hash'
# QUIET {{{4
alias gbranch-list_LOCAL='git branch'
alias gbranch-list_REMOTE='git branch --remotes'
alias gbranch-list_ALL='git branch --all'
# VERBOSE {{{4
alias gbranch-list_LOCAL_VERBOSE='git branch --verbose'
alias gbranch-list_REMOTE_VERBOSE='git branch --remotes --verbose'
alias gbranch-list_ALL_VERBOSE='git branch --all --verbose'

# BRANCH SWITCHINGS {{{3
alias gbranch-switch_to='git switch'
alias gbranch-switch_to_MAIN='git switch main'
alias gbranch-switch_to_NEW='git switch --create'
alias gbranch-switch_to_PREVIOUS='git switch -'

# BRANCH DELETIONS {{{3
alias gbranch-delete_LOCAL='git branch --delete'
alias gbranch-delete_LOCAL_FORCE='git branch --delete --force'
alias gbranch-delete_REMOTE_COUNTERPART='git push origin --delete'
alias gbranch-delete_REMOTE_WITH_NAME='git push remote_name --delete remote_branch'
alias gbranch-delete_REMOTE_ALL_WITHOUT_LOCAL_COUNTERPARTS='git push --prune remote_name'

# BRANCH DESCRIPTIONS {{{3
alias gbranch-description_EDIT='git branch --edit-description'
function gbranch-description_SHOW \
    --argument-names branch_name \
    --wraps "git branch" # NOTE: Wrapping `git branch` only for completion sake
    # FIXME: Use current branch name if the branch_name argument is not
    # supplied. Consider `git symbolic-ref --short HEAD` to get that name.
    begin
        git config branch.$branch_name.description # NOTE: prints desc if OK
        if test $status -ne 0
            echo-ERROR "No description available for git branch: $branch_name"
        end
    end
end

# BRANCH RENAMING {{{3
alias gbranch-rename_LOCAL='git branch --move'
# TODO: `alias gbranch-rename_LOCAL_AND_REMOTE=?`. FOR REMOTE CONSIDER:
#           [`git push --force --mirror`]
#           (https://stackoverflow.com/questions/6591213/how-can-i-rename-a-local-git-branch#comment11232312_6591218)


# RG {{{1
alias rg-IGNORECASE="rg --ignore-case"
alias rg-SMARTCASE="rg --smart-case"


# EMACS {{{1
# GUI {{{2
alias emacs-gui="emacs"
alias emacs-gui_FRESH="emacs --no-init-file"
alias emacs-gui_QUICK="emacs --quick"
# TERMINAL {{{2
alias emacs-term="emacs --no-window-system"
alias emacs-term_FRESH="emacs --no-window-system --no-init-file"
alias emacs-term_QUICK="emacs --no-window-system --quick"


# WC {{{1
# NOTE: Using short form flags because macos coreutils by default do not have
# the long flags available (as of macOS Sonoma).
# NOTE: Even though `wc` uses `-m` for `--chars` and `-c` for bytes by default,
# I still want to use distinct names for `--chars` and `--bytes` in the for
# mnemonic sake.
alias wc-WORDS="wc -w" # words
alias wc-LINES="wc -l" # lines
alias wc-CHARS="wc -m" # characters
alias wc-BYTES="wc -c" # bytes


# CURL {{{1
# [-s|--silent]: Silent mode
alias curl-SILENT="curl --silent"
# [-O|--remote-name]: Write output to a file named as the remote file
alias curl-write_to_file_with_name_same_as_REMOTE="curl --remote-name"
# [[-o|--output] <file>]: Write to <file> instead of stdout
alias curl-write_to_file_NOT_STDOUT="curl --output"
# [-i|--include]: Include protocol response headers in the output
alias curl-show_protocol_headers="curl --include"


# BAT {{{1
# [[-l|--language] <language>]:
#   Explicitly set the language for syntax highlighting.
alias bat-language-list="bat --list-languages"
alias bat-language="bat --language" # User supplies language, example: `json`


# HOMEBREW {{{1
# INFO {{{2
alias brew-info="brew desc"
alias brew-info_VERBOSE="brew info"
alias brew-info_HOMEPAGE="brew home"

# INSTALLATION {{{2
alias brew-install="brew install"
alias brew-install_DRYRUN="brew install --dry-run"
alias brew-uninstall="brew uninstall"
alias brew-upgrade_SELF="brew update"
alias brew-upgrade_PACKAGES="brew upgrade"
alias brew-upgrade_PACKAGES_DRYRUN="brew upgrade --dry-run"
alias brew-outdated="brew outdated"
alias brew-outdated_QUIET="brew outdated --quiet"

# SEARCH {{{2
alias brew-search_ALL="brew search" # NOTE: Searches both formulae and casks
alias brew-search_FORMULAE="brew search --formulae"
alias brew-search_CASKS="brew search --casks"
alias brew-search_DESCRIPTIONS="brew search --desc"

# LIST {{{2
# TODO: Consider `-r`(reverse) which shows older at top and newer at bottom.
alias brew-list_ALL=" brew list"
alias brew-list_INSTALLED_ON_REQUEST="brew list --installed-on-request"
alias brew-list_INSTALLED_AS_DEPENDENCIES="brew list --installed-as-dependency"
alias brew-list_FORMULAE="brew list --formulae"
alias brew-list_CASKS="brew list --casks"

# SERVICES {{{2
alias brew-services_list="brew services"
alias brew-services_info="brew services info"
alias brew-services_run="brew services run"
alias brew-services_restart="brew services restart"
alias brew-services_start="brew services start"
alias brew-services_stop="brew services kill"
alias brew-services_stop_AND_REMOVE_FROM_STARTUP="brew services stop"
alias brew-services_cleanup="brew services cleanup"
# NOTE: Provide `--all` variants:
alias brew-services_list_ALL="brew services --all"
alias brew-services_info_ALL="brew services info --all"
alias brew-services_run_ALL="brew services run --all"
alias brew-services_restart_ALL="brew services restart --all"
alias brew-services_start_ALL="brew services start --all"
alias brew-services_stop_ALL="brew services kill --all"
alias brew-services_stop_AND_REMOVE_FROM_STARTUP_ALL="brew services stop --all"
alias brew-services_cleanup_ALL="brew services cleanup --all"


# SQLITE-UTILS {{{1
alias sqliteutils-memory="sqlite-utils memory"
alias sqliteutils-memory_TABLE="sqlite-utils memory --table"
alias sqliteutils-memory_SCHEMA="sqlite-utils memory --schema"


# FISH ALIASES {{{2
# OPEN PRIVATE SESSION, WHERE HISTORY IS NOT RECORDED
alias fish-PRIVATE="fish --private"
# RELOAD CONFIG
function fish-reload --description "Reload fish configuration"
    source "$__fish_config_dir/config.fish"
end


# ANYTHING BELOW THIS WAS ADDED AUTOMATICALLY AND NEEDS TO BE SORTED {{{1
# -----------------------------------------------------------------------
