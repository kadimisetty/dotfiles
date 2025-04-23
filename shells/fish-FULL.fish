# FISH SHELL CONFIGURATION {{{1
# vim: foldmethod=marker:foldlevel=0:nofoldenable:
# AUTHOR: Sri Kadimisetty
#
# SET FISH AS "SHELL" {{{2
# FIXME: Find a way to not set this manually.
set SHELL fish

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
fundle plugin decors/fish-colored-man
fundle plugin edc/bass
fundle plugin oh-my-fish/plugin-gi
fundle plugin oh-my-fish/plugin-license
fundle plugin tuvistavie/oh-my-fish-core # for oh-my-fish plugins
# fundle plugin catppuccin/fish
if test $(uname) != Darwin
    # ignore these plugins in macos
    fundle plugin oh-my-fish/plugin-pbcopy
end

# START FUNDLE (PLACE AFTER PLUGIN LIST):
fundle init

# CONFIGURE PLUGINS:
# TODO

# UTILTIES {{{1
# REPAINT COMMANDLINE {{{2
alias commandline-repaint="commandline --function repaint"

# ENSURE DIRS COMMONLY EXPECTED TO HOLD EXECUTABLES EXIST IN PATH {{{2
# NOTE: Create the dirs if not present
function _ensure_dir_exists_and_is_in_PATH \
    --argument-names dir
    # TODO: Validate argument
    if not test -e $dir
        mkdir $dir
    end
    fish_add_path $dir
end
# ASSERT PERSONAL EXECUTABLES BIN DIR
_ensure_dir_exists_and_is_in_PATH $HOME/bin/
# ASSERT COMMONLY USED BIN DIR
_ensure_dir_exists_and_is_in_PATH $HOME/.local/bin

# GIT HELPERS {{{2
# IS `pwd` INSIDE GIT REPO? {{{3
# Check if `pwd` is within a git repo by setting status code
# USAGE: ```
# if is_pwd_in_git_repo
#   echo "IN GIT REPO"
# else
#   echo "NOT IN GIT REPO"
# end```
function is_pwd_in_git_repo \
    --description "Is `pwd` within a git repo? (with status code)"
    test true = (git rev-parse --is-inside-work-tree 2>/dev/null) 2>/dev/null
end

# IS CURRENT WORKTREE THE "MAIN WORKTREE" (i.e. NOT LINKED WORKTREE) {{{3
# Check if current worktree is the "main worktree" by setting status code.
# USAGE: ```
# if is_git_main_worktree
#   echo "MAIN WORKTREE"
# else
#   echo "LINKED WORKTREE"
# end```
function is_git_main_worktree \
    --description "Check if current worktree is the main worktree"
    # NOTE: DEDUCING "MAIN WORKTREE":
    #   METHOD 1: Deduces main worktree by checking if it contains `./git` dir.
    #             Depends on worktree structure decided by user.
    #   METHOD 2: Deduces main worktree by checking if it is listed first in
    #             `git worktree list --porcelain`. Depends on output of that
    #             command.
    # FIXME: Also check if git repo?
    # METHOD 1:
    test is_pwd_in_git_repo
    and test \
        (git rev-parse --git-dir 2>/dev/null) \
        = \
        (git rev-parse --git-common-dir 2>/dev/null)
end

# DOES GIT REPO HAVE STAGED CHANGES? {{{3
# NOTE: Assume current directory as repo to check
# TODO: Make variant `has_git_unstaged_changes`
# TODO: Accept repo directory as argument
# TODO: Find better name
function has_git_staged_changes \
    --description "Check if repo has any staged changes"
    # NOTE: `--exit-code` returns:
    #             0   :No staged changes
    #             1   :There are staged changes
    #             129 :Other git error like "not a git repo" etc.
    git diff --cached --quiet --exit-code 2>/dev/null
    switch $status
        case 1 #      `--exit-code`: There are staged changes
            return 0 # Return success exit-code 0
        case 0 #      `--exit-code`: There are no staged changes
            return 1 # Return failure exit-code 1
        case 129 #     `--exit-code`: Other git error like "not git repo" etc.
            return 129 # Return failure exit-code 129
    end
end

#: CHECK IF GIT BRANCH EXISTS {{{3
# USAGE 1: `does_git_branch_exist xxx; echo "branch 'xxx' exists"`
# USAGE 2: `not does_git_branch_exist xxx; echo "branch 'xxx' does not exist"`
function does_git_branch_exist \
    --description "Check if given branch name exists"
    test (count $argv) -ne 1; and echo-USAGE_WITH_TOPMOST_FUNCTION BRANCH_NAME; and return 1
    not is_pwd_in_git_repo; and echo-ERROR "Not in git repo"; and return 1
    git show-ref --quiet --branches $argv
end

# SWITCH TO FIRST BRANCH THAT EXISTS IN GIVEN LIST {{{3
# USAGE: `_git_switch_to_first_branch_that_exists_in_given_list xxx develop aaa`
# OUTPUT: `Switched to 'develop'`
function _git_switch_to_first_branch_that_exists_in_given_list \
    --description "Switch to first branch that exists in given list"
    if test (count $argv) -eq 0
        echo-USAGE_WITH_TOPMOST_FUNCTION BRANCH_NAMES
        return 1
    end
    set --function target_branch_names $argv
    for branch in $target_branch_names
        does_git_branch_exist $branch
        and git switch $branch
        and return
    end
    set --function formatted \
        (printf '`%s` ' $target_branch_names | string trim | string split " " | string join "/")
    echo-ERROR "No exsiting branch in: $formatted"
    return 1
end

# REPO NAME FROM GIT REPO URL {{{3
# Repo name from given git url
# USAGE: `_reponame_from_git_repo_url git@github.com:USERNAME/REPONAME.git`
# OUTPUT: `REPONAME`
function _reponame_from_git_repo_url \
    --description "Repo name from given git url" \
    --argument-names repo_url
    echo $repo_url |
        tr -d '[:space:]' |
        string split / --right --field 2 |
        string split '.git' --right --field 1
end

# USER NAME FROM GIT REPO URL {{{3
# User name from given git url
# USAGE: `_username_from_git_repo_url git@github.com:USERNAME/REPONAME.git`
# OUTPUT: `USERNAME`
function _username_from_git_repo_url \
    --description "User name from given git url" \
    --argument-names repo_url
    echo $repo_url |
        tr -d "[:space:]" |
        string split / --right --field 1 |
        string split : --right --field 2
end

# ECHO HELPERS {{{2
# TODO: Validate arguments in all variants.
# TODO: Pick appropriate color to print `echo` with.
# TODO: Add `--description` and provide regular description as well.
# TODO: Handle piping in all variants. Look at `echo-ERROR` for inspiration.
# TODO: Use `argparse` as much as possible. and where not possible use
#       `echo-USAGE` to print basic usage info.
# FIXME: Some variants like `echo-INFO` are not accepting multiple arguments
# like `echo-ERROR` does.

# ECHO REFERENCE {{{3
# NOTE: Variants inspired by neovim's '`vim.log.levels.*`.
# TODO: Sync function definitions/description with this table's contents.
# -------------------+--------------------------------------------------------+
# VARIANT            | DESCRIPTION                                            |
# -------------------+--------------------------------------------------------+
# echo               | REGULAR/UNTOUCHED: Print message to `stdout`.          |
#                    |                                                        |
# LOG LEVELS: -------+--------------------------------------------------------+
# echo-INFO          | Print message for informational purposes("INFO").      |
# echo-DEBUG         | Print message for debugging purposes("DEBUG").         |
# echo-WARN          | Print message as warning("WARN") to `stdout`.          |
# echo-ERROR         | Print message as error("ERROR") with status code       |
#                    | to `stderr`.                                           |
#                    |                                                        |
# MISC: -------------+--------------------------------------------------------+
# echo-USAGE         | Print message as a function's usage info("USAGE").     |
#                    |                                                        |
# TASKS: ------------+--------------------------------------------------------+
# echo-task_INIT     | Print message when task(given functiun) is             |
#                    | initiated("INIT").                                     |
# echo-task_DONE     | Print message when task(given function) is             |
#                    | done("DONE").                                          |
# echo-task_WRAP     | Print message before and after("WRAP") task            |
#                    | (given fucntion) is executed.                          |
#                    |                                                        |
# SECTIONS: ---------+--------------------------------------------------------+
# echo-section_INIT  | Print message when section(given function) is          |
#                    | initiated("INIT").                                     |
# echo-section_DONE  | Print message when section(given function) is          |
#                    | done("DONE").                                          |
# echo-section_WRAP  | Print message before and after("WRAP") section(given   |
#                    | function) is executed.                                 |
#                    |                                                        |
# -------------------+--------------------------------------------------------+

# ECHO LIB {{{3
# TODO: Replace `$message` with `$argv` everywhere possible.

# TODO: Make `message` the last argument and consider it  "`$argv` remainder".
# TODO: Add proper docs.
# TODO: Validate arguments.
# NOTE: `should_invert` is a "fake boolean"("true"/"false" given as strings).
function _echo_with_customized_message \
    --description "Construct custom echo variant with given message" \
    --argument-names prefix_label message_color should_invert message
    if test -z $should_invert; or test $should_invert = false
        set_color $message_color --bold
        echo -ns $prefix_label": "
        set_color normal
    else # do invert
        set_color $message_color --bold --reverse
        echo -ns $prefix_label":"
        set_color normal
        echo -ns " "
    end
    set_color --italic
    echo $message
end

# ECHO LOG LEVELS {{{3
# ECHO INFO
# Print message for informational purposes("INFO").
# USAGE: `echo-INFO "Formatting files in this directory"
# OUTPUT(stdout): `INFO: Formatting files in this directory.`
function echo-INFO \
    --description "Print message for informational purposes"
    _echo_with_customized_message INFO $fish_color_quote false $argv
end

# ECHO DEBUG
# TODO: Consider `echo-DEBUG` variants for variable/message/function.
# Print message for debugging purposes("DEBUG").
# USAGE 1: `echo-DEBUG "Incrmenting counter"
# OUTPUT(stdout): `DEBUG: Incrementing counter
# USAGE 2: `ECHO_DEBUG_DISABLE=1; echo-DEBUG "Can you see me?"
# OUTPUT(stdout): ``
function echo-DEBUG \
    --description "Print message for debugging purposes"
    if not test -n "$ECHO_DEBUG_DISABLE"
        _echo_with_customized_message DEBUG $fish_color_param true $argv
    end
end

# ECHO WARN
# Print message as warning("WARN") to `stdout`.
# USAGE: `echo-WARN "This will be deprecated soon."
# OUTPUT(stdout): `WARN: This will be deprecated soon.`
# NOTE: Printing to`stdout`(i.e. not `stderr`) on purpose because this is
# a warning and not an error.
function echo-WARN \
    --description "Print message as warning to `stdout`"
    _echo_with_customized_message WARN $fish_color_operator false $argv
end

# ECHO ERROR
# Print message as error("ERROR") with status code to `stderr`.
# NOTE: Writes to stderr
# NOTE: Intentionally not returning error status (i.e. `return 1`).
# TODO: CONSIDER: A similar variant that will also return failure or accept
# a "return status code" as argument.
# TODO: Update `echo_builder` to handle printing to `stderr` on demand and
# replace this printing section with it.
# USAGE 1: `echo-ERROR "incorrect configuration file: conf.json"
# OUTPUT(stderr): `ERROR: incorrect configuration file: conf.json`
# USAGE 2: `echo "incorrect configuration file: conf.json" | echo-ERROR`
# OUTPUT(stderr): `ERROR: incorrect configuration file: conf.json`
function echo-ERROR \
    --description "Print message as error with status code to `stderr`"
    set --function message $argv
    # Append piped inputs if getting value from pipe
    if not isatty stdin
        # Add space if any arguments at all were supplied
        if test (count $argv) -ne 0
            set --append message " "
        end
        # Add piped inputs
        cat /dev/stdin | while read each_line
            set --append message $each_line
        end
    end
    # Assert message was provided
    if test -z "$message" # For non-blank add check `(string trim "$message")`
        # TODO: Use `echo-USAGE` here.
        set --function message "echo-ERROR: No argument(s) provided"
    end
    set_color $fish_color_error --bold --reverse
    echo -s "ERROR:" \
        (set_color normal) \
        (set_color $fish_color_error --italic) \
        " $message"
    set_color normal
end

# ECHO MISC {{{3
# ECHO USAGE
# Print message as a function's usage info("USAGE").
# USAGE: `echo-USAGE "xxx (REQ:option1) (OPT:flag)"
# OUTPUT(stdout): `USAGE: xxx (REQ:option1) (OPT:flag)`
function echo-USAGE \
    --description "Print message as a function's usage info"
    _echo_with_customized_message USAGE $fish_color_quote false "`$argv`"
end

# ECHO USAGE PREFIXED WITH TOPMOST FUNCTION NAME
# Print message as a function's usage info("USAGE") with topmost fucntion name.
# USAGE 1: `echo-USAGE_WITH_TOPMOST_FUNCTION name`
# OUTPUT(stdout): `USAGE: `echo-USAGE_WITH_TOPMOST_FUNCTION name``
# USAGE 2: `function xxx; echo-USAGE_WITH_TOPMOST_FUNCTION "name"; end; xxx`
# OUTPUT(stdout): `USAGE: `xxx name``
# USAGE 3: `function aaa; function get_name; echo-USAGE_WITH_TOPMOST_FUNCTION name ; end; xxx; end; aaa`
# OUTPUT(stdout): `USAGE: `aaa name``
function echo-USAGE_WITH_TOPMOST_FUNCTION \
    --description "Print message as a function's usage info with topmost fucntion name"
    set --function stack_trace (status print-stack-trace  \
       | gawk 'END { gsub(/^'\''|'\''$/, "", $3); print $3" " }' \
    )
    # NOTE: `$stack_trace` will include it's own trailing space.
    set --function message "`$stack_trace$argv`"
    _echo_with_customized_message USAGE $fish_color_quote false $message
end

# ECHO TASKS {{{3
# ECHO TASK INIT
# Print message when task(given functiun) is initiated("INIT").
# USAGE: `echo-task_INIT "Started task"
# OUTPUT(stdout): `INIT: Started task`
function echo-task_INIT \
    --description "Print message when task(given function) is initiated" \
    --argument-names message
    _echo_with_customized_message INIT $fish_color_operator false $message
end

# ECHO TASK DONE
# Print message when task(given function) is done("DONE").
# USAGE: `echo-task_DONE "Completed task"
# OUTPUT(stdout): `DONE: Completed task`
function echo-task_DONE \
    --description "Print message when task(given function) is done" \
    --argument-names message
    _echo_with_customized_message DONE $fish_color_operator false $message
end

# ECHO TASK WRAP
# Print message before and after("WRAP") task(given fucntion) is executed.
# TODO: Include task function name in message output?
# TODO: Don't just limit to passing in `$message`, use the entire `$argv` here.
# USAGE: `echo-task_WRAP function_that_prints_abc "Running task"
# OUTPUT(stdout): ```
# INIT: Running task
# abc
# DONE: Running task```
function echo-task_WRAP \
    --description "Print message before and after task(given function) is executed" \
    --argument-names task_function message
    if not test -n "$task_function"
        echo-USAGE "$(status current-function) (REQ:task_function) (OPT:message)"
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
# Print message when section(given function) is initiated("INIT").
# TODO: Add indention hierarchy for child sections?
# USAGE: `echo-section_INIT "Configuration Section"
# OUTPUT(stdout): ```\n>>> INIT: Configuration Section`
function echo-section_INIT \
    --description "Print message when section(given function) is initiated" \
    --argument-names message
    echo # Blank line intended
    _echo_with_customized_message ">>> INIT" $fish_color_operator false $message
end

# ECHO SECTION DONE
# Print message when section(given function) is done("DONE").
# USAGE: `echo-section_DONE "Configuration Section"
# OUTPUT(stdout): ```<<< DONE: Configuration Section\n`
function echo-section_DONE \
    --description "Print message when section(given function) is done" \
    --argument-names message
    _echo_with_customized_message "<<< DONE" $fish_color_operator false $message
    echo # Blank line intended
end

# ECHO SECTION WRAP
# Print message before and after("WRAP") section(given  function) is executed.                                 |
# TODO: Don't just limit to passing in `$message`, use the entire `$argv` here.
# USAGE: `echo-SECTION_WRAP function_that_prints_abc "SECTION"
# OUTPUT(stdout): ```
# \n>>> INIT:
# abc
# <<< DONE: SECTION\n```
function echo-section_WRAP \
    --description "Print message before and after section(given function) is executed" \
    --argument-names section_function message
    if not test -n "$section_function"
        echo-USAGE "$(status current-function) (REQ:section_function) (OPT:message)`"
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

# CHECK IF INSIDE ACTIVE PYTHON VIRTUAL ENVIRONMENT {{{2
function is_inside_virtual_environment \
    --description "Check if inside an active python virtual environment"
    test -n "$VIRTUAL_ENV"
end

# CHECK IF CURRENT DIRECTORY IS EMPTY {{{2
function is_cwd_empty \
    --description "Check if current directory is empty"
    # NOTE: `-A` instead of `--almost-all` for macos
    test -z "$(ls -A ./)"
end

# CHECK IF CURRENT DIRECTORY IS EMPTY {{{2
# TODO: Make another variant that accepts multiple binaries?
# TODO: This particular variant should only accept 1 binary, so verify that?
function is_binary_on_path \
    --description "Chek if given binary exists" \
    --argument-names binary
    type --query $binary
end

# CHECK IF GIVEN NUMBER IS POSITIVE {{{2
function is_positive_number \
    --description "Chek if given number is positive(`>0`)" \
    --argument-names num
    test $num -gt 0 2>/dev/null
end

# PATH RELATIONSHIP HELPERS {{{2
# IS PATH INSIDE ANOTHER PATH? {{{3
# USAGE 1: `_is_path_inside_path ~/parent/ ~/parent/child/`
# OUTPUT: None, but `$status` is `0` when true
# USAGE 2: `_is_path_inside_path ~/parent/ ~/child/`
# OUTPUT: None, but `$status` is `1` when false
function _is_path_inside_path \
    --description "Is given path inside another given path?" \
    --argument-names given_parent_path given_child_path
    set --function child (path resolve $given_child_path)
    set --function parent (path resolve $given_parent_path)
    # NOTE: It's acceptable if '`$child` and `$parent` paths are the same.
    set --function pattern "^$parent(/.*)?\$"
    string match --regex --entire "$pattern" "$child" &>/dev/null
end

# IS CURRENT DIRECTORY INSIDE PATH? {{{3
# USAGE 1: `_is_cwd_inside_path ~/parent/`
# OUTPUT: None, but `$status` is `0` when true
# USAGE 2: `_is_cwd_inside_path ~/not_parent/`
# OUTPUT: None, but `$status` is `1` when false
function _is_cwd_inside_path \
    --description "Is current directory inside given path?" \
    --argument-names given_parent_path
    _is_path_inside_path $given_parent_path .
end

# IS CURRENT DIRECTORY INSIDE ANY PATHS? {{{3
# USAGE 1: `_is_cwd_inside_any_paths ~/parent1/ ~/parent2/`
# OUTPUT: None, but `$status` is `0` when true
# USAGE 2: `_is_cwd_inside_path ~/not_parent1/ ~/not_parent2/`
# OUTPUT: None, but `$status` is `1` when false
function _is_cwd_inside_any_paths \
    --description "Is current directory inside given path?"
    set --function parent_paths $argv
    set --function result 1
    for parent_path in $parent_paths
        if _is_cwd_inside_path $parent_path
            return 0 # NOTE: SUCCESS: Inside atleast one of the `$parent_paths`
        end
    end
    return 1 # NOTE: FAILURE: Inside none of the `$parent_paths`
end

# BEGIN COMPLETION WITH SEARCH {{{2
# NOTE: Using "meta-tab" seems like a better fit to open completion with search
# enabled i.e. `complete-and-search`, rather than default "shift tab"(`btab`).
bind alt-tab complete-and-search
bind alt-tab --mode default complete-and-search
bind alt-tab --mode insert complete-and-search

# SEND JOB TO FOREGROUND WITH KEYBIND {{{2
# NOTE: `c-z` sends active process to background, so choosing `m-z` as a binding
# to send to foreground(`fg`).
bind alt-z 'fg; commandline-repaint'
bind alt-z --mode default 'fg; commandline-repaint'
bind alt-z --mode insert 'fg; commandline-repaint'

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

# OPEN FISH CONFIG IN EDITOR {{{2
function _open_dotfiles_and_edit_fish_config \
    --description "`cd` to `dotfiles` and open fish config"
    # NOTE: `Hardcoding dotfiles` dir and fish configuration file for now.
    cd /Users/sri/code/personal/dotfiles
    echo # Necessary because the prompts still shows the previous location.
    commandline-repaint
    if test -z "$EDITOR"
        if command --query vim
            echo-WARN "`EDITOR` not set, attempting to use `vim`"
            vim ./shells/fish-FULL.fish
        else
            echo-ERROR "Please set `EDITOR` to use."
        end
    else
        $EDITOR ./shells/fish-FULL.fish
    end
end
bind alt-comma _open_dotfiles_and_edit_fish_config
bind alt-comma --mode default _open_dotfiles_and_edit_fish_config
bind alt-comma --mode insert _open_dotfiles_and_edit_fish_config

# OPEN NEOVIM CONFIG IN EDITOR {{{2
function _open_dotfiles_and_edit_neovim_config \
    --description "`cd` to `dotfiles` and open neovim config"
    # NOTE: `Hardcoding dotfiles` dir and neovim configuration file for now.
    cd /Users/sri/code/personal/dotfiles
    echo # Necessary because the prompts still shows the previous location.
    commandline-repaint
    if test -z "$EDITOR"
        if command --query vim
            echo-WARN "`EDITOR` not set, attempting to use `vim`"
            vim ./editors/nvim-FULL.lua
        else
            echo-ERROR "Please set `EDITOR` to use."
        end
    else
        $EDITOR ./editors/nvim-FULL.lua
    end
end
# FIXME: I prefer `alt-shift-comma` to using `ctrl` here. Remap these
# "shell/editor preference bindings".
bind ctrl-alt-comma _open_dotfiles_and_edit_neovim_config
bind ctrl-alt-comma --mode default _open_dotfiles_and_edit_neovim_config
bind ctrl-alt-comma --mode insert _open_dotfiles_and_edit_neovim_config

# CREATE NEW DIRECTORY AND CD INTO IT {{{2
function mcd --description "`mkdir` and `cd` into new directory"
    mkdir $argv
    and cd $argv
end

# SHORTCUTS TO COMMON DIRECTORIES LOCATED WITHIN GIVEN PARENT DIRS {{{2
# HELPERS {{{3
# ADD SHORTCUTS TO DIRS WITHIN PARENT DIR {{{3
# TODO: Include direct alias to "bare" parent directory itself?
# USAGE 1: `~/parent` contains 2 subdirectories `aaa` and `bbb`,
# `_add_shortcuts_to_dirs_within_parent_dir ~/parent/` will create:
#   - `alias parent-AAA="cd ~/parent/aaa"`
#   - `alias parent-BBB="cd ~/parent/bbb"`
# USAGE 2: `~/parent` contains 2 subdirectories `aaa` and `bbb`,
#`_add_shortcuts_to_dirs_within_parent_dir ~/parent/ foo` will create:
#   - `alias foo-AAA="cd ~/parent/aaa"`
#   - `alias foo-BBB="cd ~/parent/bbb"`
function _add_shortcuts_to_dirs_within_parent_dir \
    --argument-names parent_dir parent_dir_prefix # TODO: Use `argparse`
    # CHECKS AND VALIDATIONS:
    if test -z "$parent_dir"
        echo-ERROR "Provide parent directory"; and return 1
    end
    if path is --invert $parent_dir
        echo-ERROR "Invalid parent directory"; and return 1
    end
    if test -z "$parent_dir_prefix"
        set --function parent_dir_prefix \
            (path resolve $parent_dir | path basename )
    end
    # LOOK THROUGH ALL SUBDIRECTORIES AND CREATE SHORTCUT ALIASES:
    for dir in (find \
    (path resolve $parent_dir) \
    -mindepth 1 \
    -maxdepth 1 \
    -type d \
    -not -path '*/.*'\
    )
        eval (echo -s "alias " \
      $parent_dir_prefix \
      - \
      (path basename $dir | string upper) \
      '="' \
      "cd $dir" \
      '"' \
      )
    end
end

# GENERATE SHORTCUTS TO LOCATIONS IN THESE PARENT DIRS {{{3
test -e ~/code/
and _add_shortcuts_to_dirs_within_parent_dir \
    ~/code/
test -e ~/code/playground/
and _add_shortcuts_to_dirs_within_parent_dir \
    ~/code/playground/ \
    play
test -e ~/design/
and _add_shortcuts_to_dirs_within_parent_dir \
    ~/design/
test -e ~/design/design-playground/
and _add_shortcuts_to_dirs_within_parent_dir \
    ~/design/design-playground/ \
    design_play

# MANUAL SHORTCUTS TO EXTREMELY COMMON LOCATIONS {{{3
# FIXME: Find an appropriate location in this file for this sub-section.
# NOTE: Prefer auto generations, so keep this very minimal
alias dotfiles="cd ~/code/personal/dotfiles/"
alias sandbox="cd ~/code/sandbox/"

# LOOKUP WORD UNDER CURSOR (`type --all`) {{{2
function _lookup_word_under_cursor \
    --description "Lookup word under cursor using `type --all`"
    set --function word_under_cursor (commandline --current-token)
    if test -n "$word_under_cursor"
        # FIXME: Avoid running `type --all` twice.
        type --all $word_under_cursor &>/dev/null
        if test $status -eq 0
            echo
            type --all $word_under_cursor 2>/dev/null
            commandline-repaint
        end
    end
end
bind alt-k _lookup_word_under_cursor
bind alt-k --mode default _lookup_word_under_cursor
bind alt-k --mode insert _lookup_word_under_cursor

# HANDLE "COMMAND NOT FOUND" {{{2
function fish_command_not_found
    echo-ERROR "Command not found: `$argv[1]`"
end

# SHORTCUTS WORKFLOW {{{2
# Alias/functions grouped together in purpose and have a common prefix.
# FIXME: Describe/Document this section better
#
# TODO: Add completions?

# SHORTCUTS LIB {{{3
function _shortcut_prefix_from_string \
    --description "Extracts shortcut prefix from given string" \
    --argument-names value
    # VALIDATE:
    test -z "$value"; and return 1
    # LOGIC
    if string match --quiet "*-*" $value # Is `-` present in given string?
        # Return first part of string split by `-`
        # NOTE: This particular `string split` command will also return
        # an error status when `-` isn't present and that is why that
        # particular case will be handled in else block where the error status
        # is not returned.
        string split - $value --fields 1
    else
        # Return value whole if `-` no present
        echo $value
        return
    end
end

function _shortcut_list_for_prefix \
    --description "Returns list of shortcuts using given shortcut prefix" \
    --argument-names shortcut_prefix
    test -z "$shortcut_prefix"; and return 1 # Assert arguments are provided.
    # ONLY ADD BARE SHORTCUT PREFIX IF IT EXISTS AS COMMAND BY ITSELF:
    if type --query $shortcut_prefix
        set --function bare_shortcut_prefix $shortcut_prefix
    else
        set --function bare_shortcut_prefix "" # Set as blank to be ignored.
    end
    # PREPEND BARE SHORTCUT PREFIX:
    functions --names \
        # NOTE: NOTES ON FOLLOWING AWK SCRIPT:
        # 1. Match only lines that start with `$shortcut_prefix-`.
        # 2. If the "bare shortcut prefix" exists, print it first.
        # 3. Only print if more than 1 shortcut exists, else exit with error.
        | gawk \
        --assign bare_shortcut_prefix=$bare_shortcut_prefix \
        --assign pattern="^$shortcut_prefix-" \
        '
        $0 ~ pattern {
          count++
          matches[count] = $0
        }
        END {
          if (count >= 1) {
            if (length(bare_shortcut_prefix)) {print bare_shortcut_prefix}
            for (i=1; i<=count; i++) { print matches[i] }
          } else {
            exit 1
          }
        }'
end

# TODO: `_shortcut_list_for_prefix_in_shortcut`(i.e. this extracts prefix from
# given shortcut)

function _shortcut_description \
    --description "Returns the given shortcut's `description`" \
    --argument-names shortcut
    # TODO: Add `--quiet` (`grep` equivalent) for use in `shortcut_index`.
    # FIXME: For aliases, strip the extraneous leading `alias xxx=` parts.
    set --function desc (functions --details --verbose $shortcut | tail -n -1)
    if test "$desc" = n/a
        return 1
    else
        echo $desc
    end
end

# FIXME: When only one potential "shortcut" value is given, glitches by
# appending that "shortcut" value at cursor.
# TODO: Provide option that doesn't go beyond first/last when inc/decrementing?
function _shortcut_variant \
    --description "Returns shortcut variant(next/prev/first/last/prefix)" \
    --argument-names variant shortcut
    # SETUP:
    set --function shortcut_prefix (_shortcut_prefix_from_string $shortcut)
    set --function shortcuts (_shortcut_list_for_prefix $shortcut_prefix)
    set --function variant (string lower $variant)
    set --function shortcuts_length (count $shortcuts)
    # VALIDATE:
    test -z "$variant"
    or test -z "$shortcut"
    or test $shortcuts_length -eq 0
    or not contains $variant (string split " " "next prev first last prefix")
    and return 1
    test $shortcuts_length -eq 0; and return # If only 1 value, just stop early
    # LOGIC:
    # NOTE: Failing to set `index` here will blow up `math` Computations later.
    set --function index (contains --index $shortcut $shortcuts)
    switch $variant
        case next
            echo -n $shortcuts[(math "$index % $shortcuts_length + 1")]
        case prev
            set --local new_index (math "$index - 1")
            if test $new_index -eq 0
                echo -n $shortcuts[-1]
            else
                echo -n $shortcuts[$new_index]
            end
        case first
            echo -n $shortcuts[1]
        case last
            echo -n $shortcuts[$shortcuts_length]
        case prefix
            echo -n $shortcut_prefix
        case '*'
            return 1 # Unreachable because of validation check
    end
end

# REPLACE CURRENT WORD WITH SHORTCUT VARIANT {{{3
# TODO: Save cursor position as much as possible.
# FIXME: Handle `math` parsing errors on unexpected inputs.
# FIXME: Handle duplication error on non-shortcut words.
function _replace_current_word_with_shortcut_variant \
    --description "Replace current word with desired shortcut variant" \
    --argument-names variant
    # VALIDATION:
    test -z "$variant"; and echo-USAGE_WITH_TOPMOST_FUNCTION "<variant>"; and return 1
    # FIXME: HANDLE SINGLE WORD WITH TRAILING SPACE FISH COMPLETION:
    # NOTE: When a fish completion is triggered, it adds a trailing space when
    # completing which prevents this function because it cannot act on
    # whitespace by design. One way to handle this is to go back one word, but
    # for now just trimming the new word trailing space. This solution also is
    # only being implemented for single word commandline content which is 99%
    # when I see it. Will have to handle a proper fix later.
    set --function current_commandline commandline
    test 1 -eq ($current_commandline | wc -l) # SINGLE LINE
    and test 1 -eq ($current_commandline | string trim | wc -l) # SINGLE WORD
    and commandline --replace ($current_commandline | string trim)
    # MAIN LOGIC:
    # NOTE: Ensure cursor is top of a non-whitespace character.
    test -n "$(commandline --current-token)"
    and commandline --current-token \
        (_shortcut_variant $variant (commandline --current-token))
end

# NEXT:
bind alt-a "_replace_current_word_with_shortcut_variant next"
bind alt-a --mode default "_replace_current_word_with_shortcut_variant next"
bind alt-a --mode insert "_replace_current_word_with_shortcut_variant next"
# PREV:
bind alt-x "_replace_current_word_with_shortcut_variant prev"
bind alt-x --mode default "_replace_current_word_with_shortcut_variant prev"
bind alt-x --mode insert "_replace_current_word_with_shortcut_variant prev"
# FIRST:
bind alt-shift-x "_replace_current_word_with_shortcut_variant first"
bind alt-shift-x --mode default "_replace_current_word_with_shortcut_variant first"
bind alt-shift-x --mode insert "_replace_current_word_with_shortcut_variant first"
# LAST:
bind alt-shift-a "_replace_current_word_with_shortcut_variant last"
bind alt-shift-a --mode default "_replace_current_word_with_shortcut_variant last"
bind alt-shift-a --mode insert "_replace_current_word_with_shortcut_variant last"
# TODO: INDEX:
# PREFIX:
bind alt-p "_replace_current_word_with_shortcut_variant prefix"
bind alt-p --mode default "_replace_current_word_with_shortcut_variant prefix"
bind alt-p --mode insert "_replace_current_word_with_shortcut_variant prefix"

# PRINT SHORTCUT INDEX FOR PREFIX {{{3
# TODO: Convert into API function to be for keybinds?
function shortcut_index \
    --description "Print shortcut index for prefix" \
    --argument-names prefix
    test -z "$prefix"; and echo-USAGE_WITH_TOPMOST_FUNCTION prefix; and return 1
    set --function shortcut_list (_shortcut_list_for_prefix $prefix 2>/dev/null)
    if test $status -ne 0 # Quit early if no shortcut list found for prefix.
        echo-ERROR "No shortcuts found for prefix: $prefix"
        return 1
    else # Construct shortcut list using a separator(`|`) and display in columns.
        begin
            echo "SHORTCUT|DESCRIPTION"
            for shortcut in $shortcut_list
                set raw_description (_shortcut_description $shortcut)
                set description \
                    (string replace --regex '^alias \S+=(.*)' '`\1`' \
                      $raw_description)
                echo "$shortcut|$description"
            end
        end | column -t -s"|"
    end
end

# CD UPWARDS INCREMENTALLY WITH `..`S {{{2
# NOTE: Feature parity with fish plugin `danhper/fish-fastdir`:
#   1. Not doing the plugin's directory history stack helpers `d` in favor of
#      fish's directory history combo: `dirh`/`cdh`/`prevd`/`nextd`. There is
#      also fish's directory stack combo: `dirs`/`pushd`/`popd`.
#   2. Offering 4 level upwards just like the plugin.
#   3. Not doing `alias ..="cd ../"` because `..` works natively.
alias ...="cd ../../"
alias ....="cd ../../../"

# CD UPWARDS TO A CONTAINING DIRECTORY(ala `Markcial/upto`) {{{2
# NOTE: Functionally similar to `Markcial/upto`.
# TODO: CONFIGURE: Set `CD_UP_LIMIT_AT_HOME` to not go up above the home
# directory.
# TODO: CONFIGURE: Set `CD_UP_LIMIT_DIR` as a path to not go up that path.
function _parent_directories \
    --argument-names dir
    set --function containing_dirs
    set dir (path normalize $dir)
    if not test -d "$dir"
        echo-ERROR "Invalid directory: $dir"
        return 1
    end
    while test "$dir" != "$HOME" -a -n "$dir" -a "$dir" != /
        set --append containing_dirs (path dirname $dir)
        set dir (path normalize (path dirname $dir))
    end
    for containing_dir in $containing_dirs
        echo $containing_dir
    end
end
function cd-up \
    --description "`cd` upwards to a containing directory" \
    --argument-names dir
    if contains (path normalize $dir) (_parent_directories (pwd))
        cd $dir
    else
        echo-ERROR "Invalid containing directory: $dir"
        return 1
    end
end
complete --command cd-up \
    --no-files \
    --keep-order \
    --arguments "(_parent_directories (pwd))"

# PRIVATE FISH SESSION, WHERE HISTORY IS NOT RECORDED {{{2
# NOTE: `--private` doesn't record history.
alias fish-PRIVATE="fish --private"

# RELOAD FISH CONFIGURATION {{{2
# FIXME: Reset $status command line indicator with explicit `true`?
function fish-reload \
    --description "Reload fish configuration"
    echo
    set --function fish_config_file_to_source "$__fish_config_dir/config.fish"
    source $fish_config_file_to_source
    and echo-INFO "Reloaded shell configuration: `$fish_config_file_to_source`"
end
bind alt-r 'fish-reload; commandline-repaint'
bind alt-r --mode default 'fish-reload; commandline-repaint'
bind alt-r --mode insert 'fish-reload; commandline-repaint'

# HISTORY {{{1
# NOTE: Main variants are `--exact`/`--prefix`/`--contains` but history
# provides another dimension of variants with `--max`, `--show-time` and
# `--case-sensitive`, but currently mostly implementing just `--show-time` in
# order to keep the number of aliases manageable.
# HISTORY LIST {{{2
# NOTE: "list" aliases include "search".
# NOTE: I prefer to use `--reverse` on "list" results.
# WITHOUT TIME {{{3
alias history-list-ALL="history"
alias history-list-LAST_1="history --max=1 --reverse"
alias history-list-LAST_5="history --max=5 --reverse"
alias history-list-LAST_10="history --max=10 --reverse"
alias history-list_EXACT_MATCH="history search --exact"
alias history-list_PREFIX_MATCH="history search --prefix"
alias history-list_CONTAINS="history search --contains"
# WITH TIME {{{3
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

# TODO: function nix-profile_install \
#     --description "Install packages with `nix profile`"
#   # Install all packages in args. Prepend `nixpkgs#` if necessary.
#   nix profile install XXX
# end
function nix-profile_list_INSTALLED \
    --description "List packages installed with `nix profile`"
    nix profile list \
        # Keep lines starting with `Name:` and strip any ANSI escape characters
        | gawk '/^Name:/ { gsub("\033[][0-9;]*m", "", $0); print $2 }'
end
function nix-profile_list_INSTALLED__INDEXED \
    --description "List packages installed with `nix profile` with count"
    nix profile list \
        # Keep lines starting with `Name:`
        # Strip any ANSI escape characters
        # Print index of each package(using `i` to track count).
        | gawk '/^Name:/ { gsub("\033[][0-9;]*m", "", $0); print ++i".", $2 }'
end
alias nix-profile_list_INSTALLED__VERBOSE="nix profile list"
alias nix-profile_remove="nix profile remove"
complete --command nix-profile_remove \
    --no-files \
    --keep-order \
    --arguments "(nix-profile_list_INSTALLED)"

# COMMON FISH SPECIFIC PREFERENCES {{{1
# DISABLE WELCOME GREETING {{{2
set fish_greeting ""

# THEMES {{{2
# DRACULA {{{3
fish_config theme choose Dracula

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
# fish_config theme choose "Catppuccin Mocha"

# SET VIM AS DEFAULT EDITOR {{{2
set --export EDITOR nvim
set --export VISUAL nvim
set fish_cursor_default block # `default` includes normal and visual modes
set fish_cursor_insert line
set fish_cursor_replace_one underscore

# LS {{{1
alias l="ls -A" # On macos `-A` exist but not longform `--almost-all`
alias ls-ALL="ls -A" # Same as my earlier `l` alias; just for clarity's sake.
alias rm-confirm="rm -i" # Request confirmation

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
bind ctrl-a --mode default beginning-of-line
bind ctrl-a --mode insert beginning-of-line
bind ctrl-e --mode default end-of-line
bind ctrl-e --mode insert end-of-line
bind ctrl-b --mode default backward-char
bind ctrl-b --mode insert backward-char
bind ctrl-f --mode default forward-char
bind ctrl-f --mode insert forward-char
bind alt-b --mode default backward-word
bind alt-b --mode insert backward-word
bind alt-f --mode default forward-word
bind alt-f --mode insert forward-word

# EDITING {{{3
bind ctrl-t --mode default transpose-chars
bind ctrl-t --mode insert transpose-chars
bind alt-t --mode default transpose-words
bind alt-t --mode insert transpose-words
bind alt-u --mode default upcase-word
bind alt-u --mode insert upcase-word
bind alt-l --mode default downcase-word
bind alt-l --mode insert downcase-word
bind alt-c --mode default capitalize-word
bind alt-c --mode insert capitalize-word

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
    echo -ns (string repeat --count $space_count " ")
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

# GIT WORKTREE PROMPT COMPONENT {{{3
# Show worktree indicator if not in primary worktree
function _git_worktree_prompt_component \
    --argument-names left_margin right_margin
    if not is_git_main_worktree
        _spacer_prompt_component $left_margin
        set_color $fish_color_cwd
        echo -ns "󰐅"
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

# GIT BISECT PROMPT COMPONENT {{{3
# Show if a `git bisect` operation is in progress
function _git_bisect_prompt_component \
    --argument-names left_margin right_margin
    _spacer_prompt_component $left_margin
    if is_git_bisect_in_progress
        set_color $fish_color_quote --bold
        echo -ns "󱈆 BISECT" # ICON ALTERNATIVES: 󱈆 󰡦 󱎸 󱡴 󱉶 󱈄 
        set_color $fish_color_normal
        _spacer_prompt_component $right_margin
    end
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
    # NOTE: GUARD: Restrict to a child of atleast one path in $`parent_paths`.
    set --function parent_paths $argv[4..] # NOTE: Tweak if arguments change.
    if not _is_cwd_inside_any_paths $parent_paths
        return
    end
    # NOTE: GUARD: Restrict to git repos only
    if is_pwd_in_git_repo
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
    _git_commit_count_indicator_prompt_component 1 0 midnight ~/code/personal/
    _private_mode_component 1 0
    _background_jon_prompt_component 1 0
    _git_bisect_prompt_component 1 0
    _git_worktree_prompt_component 1 0
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

# EZA {{{1
# NOTE: Switched to `eza` because previous choice `exa` is abandoned.
# TODO: Add variants to show `level` depth.
# TODO: Add variant to show minimal/verbose information.
# TODO: Add aliases to show only one of files/dirs/symbolic-links.
# TODO: Add aliases to sort by name/"dates"/extensions/size/type.
alias eza-tree="eza --tree --group-directories-first"
alias eza-tree_GIT="eza --tree --group-directories-first --git-ignore --git"

# MAKE COMMAND KEYBINDINGS {{{1
# NOTE: Keep keybindings in tandem with equivalents in my neovim config.
#
#  +---------------+------------------------+
#  |  MAKE         + KEYBIDING SUFFIX       |
#  |  COMMAND      + (PREFIX: `alt-m,alt-`) |
#  +---------------+------------------------+
#  | `make`        | m                      |
#  | `make build`  | b                      |
#  | `make run`    | r                      |
#  | `make clean`  | c                      |
#  | `make fmt`    | f                      |
#  | `make test`   | t                      |
#  +---------------+------------------------+

# TODO: Use `argparse`, so the make command can be passed in cleanly.
# TODO: Parse from a table and iterate through them.
# USAGE:  `_generate_make_keybindings m make clean` will generate keybindings
# `bind alt-m,alt-c "echo; echo-USAGE \"make clean\"; make clean; ..."` for all
# three fish command line modes.
function _generate_make_keybindings
    # VALIDATIONS:
    test (count $argv) -lt 2
    and echo-USAGE "$(status current-function) KEY CMD"
    and return 1
    # SETUP:
    set --function key_prefix "alt-m,alt-"
    set --function key_suffix $argv[1] # first argument
    set --function command $argv[2..-1] # second to end argument
    set --function full_command_string \
        "echo; echo-DEBUG \"$command\"; $command; commandline-repaint"
    # KEYBINDINGS:
    bind $key_prefix$key_suffix $full_command_string
    bind $key_prefix$key_suffix --mode default $full_command_string
    bind $key_prefix$key_suffix --mode insert $full_command_string
end

_generate_make_keybindings m make
_generate_make_keybindings b make build
_generate_make_keybindings r make run
_generate_make_keybindings c make clean
_generate_make_keybindings f make fmt
_generate_make_keybindings t make test

# FZF {{{1
# NOTE: `ripgrep` options being used to power fzf:
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
bind ctrl-r _fzf_search_history
bind ctrl-r --mode default _fzf_search_history
bind ctrl-r --mode insert _fzf_search_history

# KILL PROCESSES BY USING FUZZY SEARCH TO FIND THEM {{{1
# FIXME: Merge with the `ps` section.
# NOTE: Required binaries: `fzf`, `gawk`.
# TODO: Assert required binaries `fzf` and `gawk` are available?

# NOTE: `kill` with `SIGTERM` (soft termination).
function kill-search_SOFT \
    --description "Search and kill processes"
    ps -ef \
        | gawk 'NR > 1' \
        | fzf --multi \
        | gawk '{print $2}' \
        | xargs kill
end

# NOTE: `kill` with `SIGKILL` (force kill).
function kill-search_FORCE \
    --description "Search and forcefully kill processes"
    ps -ef \
        | gawk 'NR > 1' \
        | fzf --multi \
        | gawk '{print $2}' \
        | xargs kill -9
end

# NOTE: `kill` with `SIGTERM` (soft termination) first and if that doesn't work
# in "n" seconds, then `kill -9` with `SIGKILL` (force kill) and report if that
# failed as well.
# TODO: Add `--quiet` to run quietly without printing running status.
# TODO: Find way to make `wait_time`  configurable.
function kill-search_SOFT_ELSE_FORCE \
    --description "Search and kill processes, forcefully if necessary"
    # STEP 1: Soft kill with `SIGTERM` on the first attempt
    set --function pids (ps -ef \
      | gawk 'NR > 1' \
      | fzf --multi \
      | gawk '{print $2}')
    for pid in $pids
        kill $pid
    end
    # STEP 2: Check if any processes were not killed
    set --function pids_not_killed
    for pid in $pids
        if ps -p $pid &>/dev/null
            set --append pids_not_killed $pid
        end
    end
    # STEP 3: Force kill with `SIGKILL` on second attempt
    set --function wait_time 4
    if test (count $pids_not_killed) -gt 0
        echo-ERROR "Following processes were not killed with `SIGTERM`"
        echo -e "PID\tCMD"
        for pid in $pids_not_killed
            set pcmd (ps -p $pid -o command) # cmd + args
            echo -e "$pid\t$pcmd"
        end
        echo-INFO \
            "Waiting $wait_time seconds to try force killing with `SIGKILL`…"
        sleep $wait_time
        for pid in $pids_not_killed
            kill -9 $pid
        end
    else
        echo-INFO "All processes successfully killed"
        return # SUCCESS
    end
    # STEP 4: On failure, give up and report processes that weren't killed
    set --function pids_not_killed_yet_again
    for pid in $pids_not_killed
        if ps -p $pid &>/dev/null
            set --append pids_not_killed_yet_again $pid
        end
    end
    sleep 0.5s # Wait a moment before checking pids
    if test (count $pids_not_killed_yet_again) -gt 0
        echo
        echo-ERROR \
            "Following processes were still not killed even with `SIGKILL`"
        echo -e "PID\tCMD"
        for pid in $pids_not_killed_yet_again
            set pcmd \
                # (ps -p $pid -o comm=) # Print "pid cmd"
                (ps -p $pid -o command) # Print "pid cmd+args"
            echo -e "$pid\t$pcmd"
        end
        return 1 # FAILURE
    else
        echo-INFO "All processes successfully killed"
        # return # SUCCESS
    end
end

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
        return 1
    else if not man $argv &>/dev/null
        # ENSURE MAN PAGE EXISTS FOR GIVEN COMMAND
        echo-ERROR "no man page for: $argv"
        return 1
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
# TODO: The `m--` binding is intended to match with the keymap used to open
# `mini.files` in neovim, which is currently just `-`, so see if there is an
# equivalent keymap in neovim.
# NOTE: Using a delay to ensure lazy has loaded the plugin.
# TODO: Set `mini.files` to start early in neovim `lazy.nvim` plugin manager.
function n-FILES \
    --description "Launch neovim with `mini.files` open"
    nvim -c \
        "lua vim.loop.new_timer():start(1, 0, vim.schedule_wrap(require('mini.files').open))"
end
bind alt-minus n-FILES
bind alt-minus --mode default n-FILES
bind alt-minus --mode insert n-FILES
# NOTE: Configured neovim `lazy.nvim` plugin manager to lazy load cmd `NeoTree`
function n-TREE \
    --description "Launch neovim with `neotree` open"
    nvim -c "Neotree action=focus source=filesystem position=left"
end
bind alt-_ n-TREE
bind alt-_ --mode default n-TREE
bind alt-_ --mode insert n-TREE

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

# PYTHON VIRTUAL ENVIRONMENT (VENV) {{{1
# TODO: Accept a virtual environment name (other than "venv").
# CREATE VIRTUAL ENVIRONMENT {{{2
function v-create \
    --description "Create python virtual environment in `./venv/`"
    # TODO: Check for proper python version
    if test -e "./venv"
        echo-ERROR "`./venv/` exists"
        return 1
    else
        python3 -m venv ./venv
    end
end

# ACTIVATE VIRTUAL ENVIRONMENT {{{2
function v-activate \
    --description "Activate python virtual environment from `./venv/`"
    # TODO: Accept virtual environment name other than just hard-coded `venv`
    if test -e "./venv/bin/activate.fish"
        source ./venv/bin/activate.fish
    else
        echo-ERROR "Unable to activate activate python virtual environment:" \
            "File not found: `./venv/bin/activate.fish`"
        return 1
    end
end

# DEACTIVATE VIRTUAL ENVIRONMENT {{{2
function v-deactivate \
    --description "Deactivate python virtual environment from `./venv/`"
    # NOTE: Consider replacing the "deactivate" command (should be set somwhere
    # in `v-activate` function perhaps).
    if test -z "$VIRTUAL_ENV"
        echo-ERROR "Not in active python environment"
        return 1
    else
        set --function virtual_env_name $VIRTUAL_ENV
        deactivate
        # FIXME: Make this report only the relative name of the virtual
        # environment not the entire path i.e. relative to current directory
        # e.g. "./venv/" and not "/Users/username/code/project/venv/".
        set --function dir_separator / # NOTE: Using `/` because assuming *nix
        set --function venv_path (path dirname $virtual_env_name)$dir_separator(path basename $virtual_env_name)$dir_separator
        echo-INFO "Deactivated python virtual environment: `$venv_path`"
    end
end

# CREATE AND ACTIVATE VIRTUAL ENVIRONMENT {{{2
# TODO: Add variant of this that will force-delete any present `./venv/`
function v-create_activate \
    --description "Create and activate python virtual environment `./venv/`"
    v-create
    and v-activate
end

# EXIT IF VIRTUAL ENVIRONMENT NOT ACTIVE {{{2
function _exit_if_not_in_active_python_virtual_env \
    --description "Exit with failure if python virtual environment not active"
    if not is_inside_virtual_environment
        echo-ERROR "Not in active python environment"
        return 1
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
    and ./manage.py runserver $argv
end
function m-collect_static \
    --description "./manage.py collectstatic"
    _exit_if_not_in_active_python_virtual_env
    and ./manage.py collectstatic $argv
end
function m-create_superuser \
    --description "./manage.py createsuperuser"
    _exit_if_not_in_active_python_virtual_env
    and ./manage.py createsuperuser $argv
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
    and ./manage.py shell $argv
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
    and ./manage.py testserver $argv
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
    and ./manage.py validate_templates $argv
end
function m-shell_PLUS \
    --description "./manage.py shell_plus"
    _exit_if_not_in_active_python_virtual_env
    and ./manage.py shell_plus $argv
end
function m-runserver_PLUS \
    --description "./manage.py runserver_plus"
    _exit_if_not_in_active_python_virtual_env
    and ./manage.py runserver_plus $argv
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
alias c-build_VERBOSE="cargo build --verbose"
alias c-check="cargo check"
alias c-clippy="cargo clippy"
alias c-doc_open="cargo doc --open"
alias c-doc_open_STD="rustup doc --std"
alias c-fix="cargo fix"
alias c-format="cargo fmt"
alias c-new="cargo new"
alias c-run="cargo run"
alias c-run_QUIET="cargo run --quiet"
alias c-run_VERBOSE="cargo run --verbose"
alias c-test="cargo test"
alias c-test_QUIET="cargo test --quiet"
alias c-test_VERBOSE="cargo test --verbose"
alias c-tree_DEPTH1="cargo tree --depth 1"
alias c-watch="cargo watch"
alias c-watch_QUIET="cargo watch --quiet"

alias c-install="cargo install" # Install by bulding from source
# Install by checking for available bin first and building from source if not.
function c-binstall \
    --wraps "cargo install" \
    --description "Use `cargo binstall` for installing crate"
    cargo binstall $argv
end

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
        return 1
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
        return 1
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
alias go-run_MAIN='go run ./main.go'
alias go-test='go test'
alias go-test_VERBOSE='go test -v'
alias go-test_MAIN='go test ./main_test.go'
alias go-test_MAIN_VERBOSE='go test -v ./main_test.go'
# General `-cover`.
alias go-test_COVERAGE_OUTPUT='go test -cover'
# Generate coverage into file `coverage.out`.
alias go-test_COVERAGE_FILE='go test -coverprofile=coverage.out'
# Generate `coverage.out`(but as a temp file) and display in browser.
function go-test_COVERAGE_BROWSER \
    --description "Display `go test -cover` output in browser" \
    --wraps="go test -cover"
    go test -coverprofile=/tmp/coverage.out
    and go tool cover -html=/tmp/coverage.out
end
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
        return 1
        # Exit if path with given name exists in current dir
    else if test -e "$module_path"
        echo-ERROR "path with given name exists"
        return 1
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

# XARGS {{{1
# TODO: Add a shortcut variant that includes `-I%`
# PARALLEL EXECUTION {{{2
alias pxargs="xargs --max-procs=0" # NOTE: `0` to use all processors
alias pxargs2="xargs --max-procs=2"
alias pxargs3="xargs --max-procs=3"
alias pxargs4="xargs --max-procs=4"

# GIT {{{1
# NOTE: FOR `git log`/`git stash`: Time duration variants: (LAST/THIS)
# (DAY/WEEK/MONTH).
# NOTE: FOR `git log`/`git stash`: "THIS" vs "LAST" example: "THIS WEEK" should
# cover commits since monday 00:00 HRS and "LAST WEEK" should cover commits
# made over the previous 7 days.

# GIT UTILITIES {{{2
# `cd` UPWARDS TO ROOT GIT DIRECTORY {{{3
# TODO: Accept argument sub directory with hierarchy calculated as beginning
# from git root directory, should work exactly like in fugitive's `Gcd`.
function gcd \
    --description "`cd` upwards to root git directory"
    set --function result (git rev-parse --show-toplevel 2>&1)
    if test $status -eq 0
        # SUCCESS: `result` is git root directory.
        cd "$result"
    else
        # FAILURE: `result` is `git rev-parse --show-toplevel`'s stderr message.
        echo-ERROR $result
        and return
    end
end

# GIT CUSTOM ALIASES {{{2
# NOTE: Some of my WIP git shortcuts are in a private scratch space.
source ~/code/personal/dotfiles-scratch/git-shortcuts.fish

# GIT PULL {{{2
# `tldr`: Download changes from default remote repository and merge it:
alias gpull='git pull' # `…pull` = fetch + merge
# `tldr`: Download changes from default remote repository and use fast-forward:
alias gpull-rebase='git pull --rebase' # `…pull --rebase` = fetch + rebase
# TODO: `tldr`: Download changes from given remote repository and branch, then
# merge them into HEAD:`git pull remote_name branch`. Note that it takes
# "remote_name" and "branch". Consider making "branch" as "main" by default.

# GIT PUSH {{{2
alias gpush='git push'
alias gpush-force_SOFT='git push --force-with-lease'
# alias gpush-force_HARD='git push --force' # TODO: Require user confirmtion

# GIT ADD {{{2
alias gadd_FILE='git add' # e.g. `git add ./filename`
alias gadd-CWD='git add .' # just changes in cwd, not same as `--all`
alias gadd-ALL='git add --all' # entire repo
alias gadd-TRACKED='git add --update'
alias gadd-TRACKED_AND_UNTRACKED='git add --all'
alias gadd-INTERACTIVE='git add --interactive'
# alias gadd-PATCH='git add --patch' -- NOTE: Removing to focus on "INTERACTIVE"

# GIT COMMIT {{{2
# BARE {{{3
# NOTE: Not doing `gcommit-message_ADD_FILE` because that would require
# two(message and files to add), so avoiding it for now to keep it simple at
# least until I figure out a strategy to get user input simply for multiples.
alias gcommit='git commit'
alias gcommit-message='git commit --message'
alias gcommit-message_ADD_ALL='git add --all; and git commit --all --message'
alias gcommit-message_ADD_ALL__TRACKED='git commit --all --message'
# AMEND {{{3
alias gcommit-amend='git commit --amend'
alias gcommit-amend__KEEP_MESSAGE='git commit --amend --no-edit'
function gcommit-amend_ADD_FILE \
    --description "`git add` given file and `git commit --amend`" \
    --wraps "git add" # NOTE: Completion purposes only.
    test -z "$argv"; and echo-USAGE_WITH_TOPMOST_FUNCTION FILE_WITH_CHANGES; and return 1
    git add $argv; and git commit --amend
end
function gcommit-amend_ADD_FILE__KEEP_MESSAGE \
    --description "`git add` given file and `git commit --amend --no-edit`" \
    --wraps "git add" # NOTE: Completion purposes only
    test -z "$argv"; and echo-USAGE_WITH_TOPMOST_FUNCTION FILE_WITH_CHANGES; and return 1
    git add $argv; and git commit --amend --no-edit
end

# GIT BISECT {{{2
# TODO: Cleanup docs and descriptions.
# BISECT LIB {{{3
# IS GIT BISECT IN PROGRESS {{{4
# Check if a git bisect operation is currently in progress.
# NOTE: An alternative is to check for existence of log file
# `:/.git/BISECT_LOG` within the primary git worktree.
function is_git_bisect_in_progress
    test (git bisect log >/dev/null 2>&1; echo $status) -eq 0
end

# RETURN GIT BISECT TERMS IF THE BISECT TERM FILE EXISTS {{{4
# NOTE: The file `.git/BISECT_TERMS` is not created when custom terms aren't
# given and git waits until either of the default terms `old`/`new` or
# `bad`/`good` are given.
function _git_bisect_custom_terms
    # FIXME: Cannot take for granted that we are ibside the main git worktree,
    # use `rev-parse` to help with that.
    test -f ./.git/BISECT_TERMS; and cat ./.git/BISECT_TERMS
end

# BISECT ESSENTIALS {{{3
alias gbisect="git bisect"
alias gbisect-log="git bisect log"
alias gbisect-log="git bisect log"
alias gbisect-replay="git bisect replay"
alias gbisect-reset="git bisect reset"
alias gbisect-run="git bisect run"
alias gbisect-skip="git bisect skip"
alias gbisect-view="git bisect view" # TODO: Same as `visualize`, use `abbr`?
# TODO: Add more 'stop' shortcut variants?
# TODO: Set no args for this particular shortcut because it resets to head
# implicitly and I want to make that explicit
alias gbisect-stop_AND_RESET_TO_HEAD="git bisect reset"

# BISECT START {{{3
alias gbisect-start="git bisect start"
alias gbisect-terms="git bisect terms" # Show what bisect terms arebeing used.
# NOTE: Reading file `.git/BISECT_TERMS` is the best way to check if an active
# `git bisect` is using user-set terms. It stores both terms, unless a default
# term pair is being used i.e. (i.e. old/new, bad/good). The defults are not
# written into the file until the user picks on of those two sets.
# NOTE: Also doing for the default terms, as it forces it to write to
# `.git/BISECT_TERMS` without waiting for user to type one of the deafult
# terms. This way I get it to show up in completion and use the same code.
function _create_git_bisect_start_shortcuts_for_custom_terms
    test (count $argv) -eq 0; and echo-USAGE_WITH_TOPMOST_FUNCTION "<term1,term2>…"; and return 1
    for terms in $argv
        set --local terms (string split "," $terms)
        test -z "$terms[1]" -o -z "$terms[2]"; and echo-ERROR "Invalid terms: $terms"; and return 1
        set --local upper_terms (string upper $terms)
        # NOTE: Using `function` and not `alias` for a proper `--description`.
        # NOTE: Using `eval` to generate and complete like this is the only
        # successful way to achieve custom "term" completion.
        eval \
            "function gbisect-start_$upper_terms[1]_$upper_terms[2] \
                  --description \"Start `git bisect` using `$terms[2]`(old) and `$terms[1]`(new)\" \
                  --wraps \"git bisect start --term-old=$terms[1] --term-new=$terms[2]\"
                  git bisect start --term-old=$terms[1] --term-new=$terms[2]
              end
              # Append the two terms into this function's completions.
              # NOTE: There is a check at runtime to depend on file `./.git/BISECT_TERMS`
              complete --command git \
                  --condition '__fish_seen_subcommand_from bisect' \
                  --arguments '(_git_bisect_custom_terms)'
        "
    end
end
_create_git_bisect_start_shortcuts_for_custom_terms \
    # REWRITING DEFAULT TERMS
    old,new \
    good,bad \
    # CUSTOM TERMS
    before,after \
    enabled,disabled \
    working,broken \
    passing,failing \
    fast,slow \
    secure,insecure \
    compatible,incompatible

# GIT CLONE {{{2
# GIT CLONE WITH REPO NAME AND THEN `cd` INTO IT {{{3
function gclone-cd \
    --description "`git clone`s given repo url and `cd` inside" \
    --argument-names repo_url target_directory_name
    if test -z $repo_url
        echo-ERROR "Git repo url not given"
        return 1
    else
        if not test -z $target_directory_name
            git clone $repo_url $target_directory_name
            and cd $target_directory_name
        else
            # NOTE: Let git handle failure cases like if a directory with name
            # of repo exists in current directory.
            git clone $repo_url
            and cd (_reponame_from_git_repo_url $repo_url)
        end
    end
end

# GIT CLONE WITH USERNAME + REPO NAME AND THEN `cd` INTO IT {{{3
function gclone-cd_USERNAME \
    --description "`git clone`s given repo url with username and `cd` inside" \
    --argument-names repo_url target_directory_name
    if test -z $repo_url
        echo-ERROR "Git repo url not given"
        return 1
    else
        if not test -z $target_directory_name
            git clone $repo_url $target_directory_name
            and cd $target_directory_name
        else
            set --local target_directory_name \
                (string join "-" \
              (_username_from_git_repo_url $repo_url) \
              (_reponame_from_git_repo_url $repo_url ) \
              )
            git clone $repo_url $target_directory_name
            and cd $target_directory_name
        end
    end
end

# GIT DIFF {{{2
# TODO: Add `difftool` support
alias gdiff="git diff"
# UNSTAGED CHANGES {{{3
alias gdiff-UNSTAGED='git diff --compact-summary'
alias gdiff-UNSTAGED_VERBOSE='git diff --patch-with-stat'
# STAGED  CHANGES {{{3
alias gdiff-STAGED='git diff --staged --compact-summary'
alias gdiff-STAGED_VERBOSE='git diff --staged --patch-with-stat'
# ALL CHANGES (STAGED AND UNSTAGED) {{{3
alias gdiff-ALL='git diff --compact-summary HEAD'
alias gdiff-ALL_VERBOSE='git diff --patch-with-stat HEAD'

# GIT LOG {{{2
# TODO: Rewrite all `date` uses here to use gnu date (`gdate` in coreutils) for
# simplicity, readability and cross-compatibility sake.

# BY SEARCH {{{3
alias glog-search='git log --oneline --regexp-ignore-case --grep'
alias glog-search_VERBOSE='git log --regexp-ignore-case --grep'

# BY COUNT {{{3
# COMPACT {{{4
alias glog-ALL='git log --oneline --decorate --graph' # all commits
function _glog-FIRST_n \
    --argument-names n \
    --wraps "git show"
    if not is_positive_number "$n"
        echo-ERROR "Requires positive number of commits"
        echo-USAGE "$(status current-function) (REQ:commit count > 0) (OPT:git log opts)"
        return
    end
    git log --no-walk (git rev-list HEAD | tail -n $n) \
        --oneline --decorate $argv[2..]
end
alias glog-FIRST_1="_glog-FIRST_n 1"
alias glog-FIRST_5="_glog-FIRST_n 5"
alias glog-FIRST_10="_glog-FIRST_n 10"
alias glog-FIRST_20="_glog-FIRST_n 20"
alias glog-LAST_1='git log HEAD --oneline --max-count=1'
alias glog-LAST_5='git log --oneline --decorate --graph --max-count=5'
alias glog-LAST_10='git log --oneline --decorate --graph --max-count=10'
alias glog-LAST_20='git log --oneline --decorate --graph --max-count=20'
# VERBOSE {{{4
alias glog-FIRST_1_VERBOSE="glog-FIRST_1 --compact-summary"
alias glog-FIRST_5_VERBOSE="glog-FIRST_5 --compact-summary"
alias glog-FIRST_10_VERBOSE="glog-FIRST_10 --compact-summary"
alias glog-FIRST_20_VERBOSE="glog-FIRST_20 --compact-summary"
alias glog-LAST_1_VERBOSE='glog-LAST_1 --compact-summary'
alias glog-LAST_5_VERBOSE='glog-LAST_5 --compact-summary'
alias glog-LAST_10_VERBOSE='glog-LAST_10 --compact-summary'
alias glog-LAST_20_VERBOSE='glog-LAST_20 --compact-summary'

# BY PERIOD {{{3
# COMPACT {{{3
alias glog-TODAY='git log --oneline --decorate --graph --since=midnight'
alias glog-YESTERDAY='git log --oneline --decorate --graph --since=yesterday.midnight --before=midnight'
alias glog-THIS_DAY='git log --oneline --decorate --graph --since=midnight'
alias glog-THIS_WEEK='git log --oneline --decorate --graph --since=last.sunday.midnight'
alias glog-THIS_MONTH='git log --oneline --decorate --graph --since="$(date -v1d +%Y-%m-%d)T00:00:00"'
function glog-THIS_QUARTER \
    --description "Show commits made in the current quarter" \
    --wraps 'git log'
    set --function current_month (date +%m)
    set --function current_year (date +%Y)
    if test $current_month -le 3
        set --function since "$current_year-01-01T00:00:00"
    else if test $current_month -le 6
        set --function since "$current_year-04-01T00:00:00"
    else if test $current_month -le 9
        set --function since "$current_year-07-01T00:00:00"
    else
        set --function since "$current_year-10-01T00:00:00"
    end
    git log --oneline --decorate --graph --since="$since" $argv
end
alias glog-THIS_YEAR='git log --oneline --decorate --graph --since="$(date -v1m -v1d +%Y-01-01)T00:00:00"'
alias glog-LAST_WEEK='git log --oneline --decorate --graph --since=1.week'
alias glog-LAST_MONTH='git log --oneline --decorate --graph --since=1.month'
alias glog-LAST_QUARTER='git log --oneline --decorate --graph --since=4.month'
alias glog-LAST_YEAR='git log --oneline --decorate --graph --since=1.year'
# VERBOSE {{{3
alias glog-TODAY_VERBOSE='glog-TODAY --compact-summary'
alias glog-YESTERDAY_VERBOSE='glog-YESTERDAY --compact-summary'
alias glog-THIS_DAY_VERBOSE='glog-THIS_DAY --compact-summary'
alias glog-THIS_WEEK_VERBOSE='glog-THIS_WEEK --compact-summary'
alias glog-THIS_MONTH_VERBOSE='glog-THIS_MONTH --compact-summary'
alias glog-THIS_QUARTER_VERBOSE='glog-THIS_QUARTER --compact-summary'
alias glog-THIS_YEAR_VERBOSE='glog-THIS_YEAR --compact-summary'
alias glog-LAST_WEEK_VERBOSE='glog-LAST_WEEK --compact-summary'
alias glog-LAST_MONTH_VERBOSE='glog-LAST_MONTH --compact-summary'
alias glog-LAST_QUARTER_VERBOSE='glog-LAST_QUARTER --compact-summary'
alias glog-LAST_YEAR_VERBOSE='glog-LAST_YEAR --compact-summary'

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
# FIXME: Using "INTERACTIVE" despite using `--patch` for similicity sake, so
# print a short note sying that.
alias gstash-push_INTERACTIVE='git stash push --patch'
alias gstash-push_INTERACTIVE_with_message='git stash push --patch --message'
alias gstash-push_PRESERVE_STAGING_STATUS='git stash push --keep-index' # TODO: VERIFY
alias gstash-push_STAGED='git stash push --staged'
alias gstash-push_STAGED_with_message='git stash push --staged --message'
function gstash-push_UNSTAGED_with_message \
    --description 'Run `git stash push` for unstaged changes' \
    --wraps 'git stash push --message'
    if test (count $argv) -eq 0
        echo-ERROR "Argument(s) required for `git stash push --message`"
        return 1
    end
    if not has_git_staged_changes
        # NOTE: CURRENT STAGED CHANGES? NO: Do `gstash-push_with_message`.
        git stash push --message $argv
    else
        # NOTE: CURRENT STAGED CHANGES? YES: There is no `--not-staged` flag to
        # restrict any currently present staged changes from also being
        # stashed, so doing following 3-step work-around:
        # 1. PUT CURRENT STAGED CHANGES INTO A TEMPORARY COMMIT: Create
        #    temporary commit of STAGED changes.
        # NOTE: IMPORTANT: Bypass commit hooks
        git commit --quiet --no-verify \
            --message "TEMPORARY(FROM STAGED CHANGES): CUSTOM STASH OPERATION ARTIFACT"
        # 2. EXECUTE REGULAR GIT STASH: Push only UNSTAGED changes onto stash.
        and git stash push --message $argv
        # 3. RETURN THOSE TEMPORARILY COMMITTED CHANGES BACK AS STAGED CHANGES:
        #    Reset to previous HEAD state and restore those temporarily
        #    committed STAGED changes.
        # TODO: Assert temporary commit has been removed here at the end since
        # it is isn't removed when there is an error with the stash operation.
        # If that did happen, report the error and quit with failure.
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
alias gstash-show='git stash show --compact-summary'
alias gstash-show_VERBOSE='git stash show --patch-with-stat --compact-summary'

# STASH CONVERT {{{3
# TODO: gstash-into_commit
alias gstash-into_BRANCH='git stash branch' # expects: `<branch> [<stash>]`

# STASH LIST {{{3
# REGULAR {{{4
alias gstash-list='git stash list'
alias gstash-list_VERBOSE='git stash list --compact-summary'
# WIP {{{4
alias gstash-list_WIP_ONLY='git stash list | rg --color=never WIP'
alias gstash-list_WIP_EXCLUDED='git stash list | rg --invert-match WIP'
# SEARCH {{{4
alias gstash-search='git stash list --regexp-ignore-case --grep'
alias gstash-search_VERBOSE='git stash list --stat --regexp-ignore-case --grep'
# PERIOD {{{4
# REGULAR {{{5
alias gstash-list_TODAY='git stash list --since=midnight'
alias gstash-list_YESTERDAY='git stash list --since=yesterday.midnight'
alias gstash-list_THIS_DAY='git stash list --since=midnight'
alias gstash-list_THIS_WEEK='git stash list --since=last.sunday.midnight'
alias gstash-list_THIS_MONTH='git stash list --since="$(date -v1d +%Y-%m-%d)T00:00:00"'
alias gstash-list_LAST_DAY='git stash list --since=1.day'
alias gstash-list_LAST_WEEK='git stash list --since=1.week'
alias gstash-list_LAST_MONTH='git stash list --since=1.month'
# VERBOSE {{{5
alias gstash-list_TODAY_VERBOSE='gstash-list_TODAY --compact-summary'
alias gstash-list_YESTERDAY_VERBOSE='gstash-list_YESTERDAY --compact-summary'
alias gstash-list_THIS_DAY_VERBOSE='gstash-list_THIS_DAY --compact-summary'
alias gstash-list_THIS_WEEK_VERBOSE='gstash-list_THIS_WEEK -compact-summary'
alias gstash-list_THIS_MONTH_VERBOSE='gstash-list_THIS_MONTH --compact-summary'
alias gstash-list_LAST_DAY_VERBOSE='gstash-list_LAST_DAY --compact-summary'
alias gstash-list_LAST_WEEK_VERBOSE='gstash-list_LAST_WEEK --compact-summary'
alias gstash-list_LAST_MONTH_VERBOSE='gstash-list_LAST_MONTH --compact-summary'

# GIT SHOW {{{2
alias gshow='git show --compact-summary'
alias gshow-VERBOSE='git show --patch-with-stat --compact-summary'
# TODO: Make the commit information part like `--oneline` including colors.
alias gshow-DATE='git show --no-patch --format="%h %s%nCommited %cr (%cd local time) %ch" --date=local'

# GIT STATUS {{{2
alias gstatus='git status'
alias gstatus-VERBOSE='git status --branch --long --verbose --show-stash'

# GIT TAG {{{2
alias gtags-list="git tag --list"
alias gtags-push_ALL_to_ORIGIN="git push origin --tags" # WARN: Excludes some tags
alias gtags-push_TO_REMOTE ="git push --tags"
alias gtags-delete_LOCALLY="git tag --delete"
# alias gtags-delete_REMOTE="git push origin --delete" # FIXME: Restrict to tags
# TODO: `alias gtags-fetch_FROM_REMOTE="git fetch --tags" - "fetch" here
# fetches everything, not just the tags, so look for a solution that gets only
# tags. If that is possible, make 2 variants - one that will "fetch the tags
# and everything else" and bother that will "fetch only the tags" if possible.
function gtags-show_TAG \
    --description "git show <tag>" \
    --argument-names tags
    if not test -n "$tag"
        # TODO:  Check if given argument is an existing git tag
        echo-ERROR "Provide 1 git tag"
        return 1
    else
        git show $tags
    end
end
# NOTE: Requires `tac` from gnu coreutils. using `tac` to show most recent git
# tags first.
complete --command gtags-show_TAG \
    --no-files \
    --keep-order \
    --arguments "(git tag --list | tac)"

# GIT BRANCH {{{2
# BRANCH LISTINGS {{{3
alias gbranch-list_MERGED='git branch --merged'
alias gbranch-list_UNMERGED='git branch --no-merged'
alias gbranch-list_CONTAINS_COMMIT_HASH='git branch --all --contains commit_hash'
# COMPACT {{{4
alias gbranch-list_LOCAL='git branch'
alias gbranch-list_REMOTE='git branch --remotes'
alias gbranch-list_ALL='git branch --all'
# VERBOSE {{{4
alias gbranch-list_LOCAL_VERBOSE='git branch --verbose'
alias gbranch-list_REMOTE_VERBOSE='git branch --remotes --verbose'
alias gbranch-list_ALL_VERBOSE='git branch --all --verbose'

# BRANCH SWITCHINGS {{{3
alias gbranch-switch_to_BRANCH='git switch'
alias gbranch-switch_to_NEW='git switch --create'
alias gbranch-switch_to_PREVIOUS='git switch -'
alias gbranch-switch_to_MAIN='git switch main'
function gbranch-switch_to_MAIN_ELSE_MASTER \
    --description "Switch to `main`, or if it doesn't exist, to '`master`"
    _git_switch_to_first_branch_that_exists_in_given_list main master
end
function gbranch-switch_to_DEVELOP \
    --description "Switch to a develop branch"
    _git_switch_to_first_branch_that_exists_in_given_list \
        dev devel develop development
end

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
    --wraps "git branch" # NOTE: Completion purposes only.
    begin
        if not is_pwd_in_git_repo
            echo-ERROR "Not in git repo"
            return 1
        else
            if test -z $branch_name
                # NOTE: Use current branch name if branch_name not supplied.
                set --function branch_name (git symbolic-ref --short HEAD)
            end
            # NOTE: Print description if reading description is successful
            git config branch.$branch_name.description
            if test $status -ne 0
                echo-ERROR "No description available for branch: $branch_name"
                return 1
            end
        end
    end
end

# BRANCH RENAMING {{{3
alias gbranch-rename_LOCAL='git branch --move'
# TODO: `alias gbranch-rename_LOCAL_AND_REMOTE=?`. FOR REMOTE CONSIDER:
#           [`git push --force --mirror`]
#           (https://stackoverflow.com/questions/6591213/how-can-i-rename-a-local-git-branch#comment11232312_6591218)

# GIT RM(REMOVE) {{{2
# REMOVE FROM INDEX AND WORKING TREE {{{3
alias gremove-FILE='git rm'
alias gremove-DIR='git rm -r'
alias gremove-DIR__DRYRUN='git rm -r --dry-run'
# REMOVE FROM INDEX BUT KEEP UNTOUCHED ON FILESYSTEM {{{3
alias gremove-FILE_FROM_INDEX='git rm --cached'
alias gremove-DIR_FROM_INDEX='git rm -r --cached'
alias gremove-DIR_FROM_INDEX__DRYRUN='git rm --cached -r --dry-run'
# REMOVE FROM INDEX IF NO LONGER PRESENT IN WORKING TREE {{{3
alias gremove-FROM_INDEX_IF_NO_LONGER_IN_WORKING_TREE="git diff --name-only --diff-filter=D -z | xargs -0 git rm --cached"
alias gremove-FROM_INDEX_IF_NO_LONGER_IN_WORKING_TREE__DRYRUN="git diff --name-only --diff-filter=D"

# GIT CLEAN(REMOVE UNTRACKED/GITIGNORED) {{{2
# BARE {{{3
alias gclean='git clean'
# GITIGNORED {{{3
alias gclean-GITIGNORED='git clean -X -d'
alias gclean-GITIGNORED__FORCE='git clean -X -d --force'
alias gclean-GITIGNORED__DRY_RUN='git clean -X -d --dry-run'
alias gclean-GITIGNORED__INTERACTIVE='git clean -X -d --interactive'
# UNTRACKED {{{3
alias gclean-UNTRACKED='git clean -d'
alias gclean-UNTRACKED__FORCE='git clean -d --force'
alias gclean-UNTRACKED__DRY_RUN='git clean --dry-run -d'
alias gclean-UNTRACKED__INTERACTIVE='git clean --interactive -d'
# GITIGNORED AND UNTRACKED {{{3
alias gclean-GITIGNORED_AND_UNTRACKED='git clean -x'
alias gclean-GITIGNORED_AND_UNTRACKED__FORCE='git clean -x -d --force'
alias gclean-GITIGNORED_AND_UNTRACKED__DRY_RUN='git clean -x -d --dry-run'
alias gclean-GITIGNORED_AND_UNTRACKED__INTERACTIVE='git clean -x -d --interactive'

# GIT WORKTREE {{{2
# LIB {{{3
# Returns list of worktrees, can be used for completions.
function _gworktree-paths
    git worktree list --porcelain \
        | gawk '/worktree/ {print $2}' \
        | xargs -I% fish --command "path normalize %" # NOTE: Don't parallelize
end

# Constructs preferred target worktree name from given branch name.
# NOTE: Implements presonal preference of placing worktrees in parent directory
# containing "main worktree".
function _gworktree-target_worktree_name_from_branch_name \
    --argument-names branchname
    set --function reponame (basename (pwd))
    set --function target_worktree_name "$reponame-$branchname"
    echo $target_worktree_name
end

# BARE {{{3
alias gworktree="git worktree"

# TODO: ADD(NEW) {{{3
function gworktree-new \
    --description "Constructs git worktree and branch with given name" \
    --argument-names branch_name
    # TODO: Validate required arguments.
    set --function target_worktree_name \
        (_gworktree-target_worktree_name_from_branch_name $branch_name)
    git worktree add "../$target_worktree_name" -b $branch_name
end

function gworktree-new_cd \
    --description "Constructs git worktree and branch with given name" \
    --argument-names branch_name
    # TODO: Validate required arguments.
    set --function target_worktree_name \
        (_gworktree-target_worktree_name_from_branch_name $branch_name)
    git worktree add "../$target_worktree_name" -b $branch_name
    and cd ../$target_worktree_name
end

# LIST {{{3
# NOTE: Simply grepping for `locked` wouldn't work, as if a worktree is
# locked with a reason, the "locked" label is shown on a separate line.
alias gworktree-list="git worktree list --verbose"
function gworktree-list_LOCKED \
    --description "`git worktree list` for locked worktrees"
    git worktree list --porcelain \
        | gawk 'BEGIN {RS=""; FS="\n"}
                {split($0, array1, "\n");
                lastline = array1[length(array1)];
                if (lastline ~ /^locked/) {
                  split($1, array2, " ");
                  print array2[2]}
                }'
end
function gworktree-list_UNLOCKED \
    --description "`git worktree list` for unlocked worktrees"
    git worktree list --porcelain \
        | gawk 'BEGIN {RS=""; FS="\n"}
                {split($0, array1, "\n");
                lastline = array1[length(array1)];
                if (lastline !~ /^locked/) {
                  split($1, array2, " ");
                  print array2[2]}
                }'
end

# LOCK/UNLOCK {{{3
# TODO: Restrict completions to locked/unlocked worktrees appropriately only?
# LOCK:
alias gworktree-lock="git worktree lock"
alias gworktree-lock_WITH_REASON="git worktree lock --reason"
# UNLOCK:
alias gworktree-unlock="git worktree unlock"

# DELETE(REMOVE) {{{3
# NOTE: NOMENCLATURE: Use `delete` instead of `remove`.
alias gworktree-delete="git worktree remove"
alias gworktree-delete__FORCE="git worktree remove --force"
# TODO: When removing linked worktrees while inside them, finish removing and
# then immediately switch to the main worktree (or use a nicer method).
alias gworktree-delete_CuRRENT="git worktree remove ./"
alias gworktree-delete_CURRENT__FORCE="git worktree remove --force ./"

# SWITCH {{{3
# TODO: Keep this section similar to the `gbranch-switch_to_*` section.
# TODO: `gworktree-switch_TO_NEW` just like `gbranch-switch_TO_NEW`?
# TODO: Assert inside a git repo.
function gworktree-switch_to_MAIN
    cd (git worktree list | gawk '/\[main\]/ {print $1}')
end
function gworktree-switch_to_WORKTREE \
    --argument-names worktree \
    --wraps "git worktree unlock" # NOTE: Completion purposes only.
    # TODO: Assert an argument is given
    if test (count $argv) -eq 0
        echo-ERROR "Argument required"
        return 1
    end
    if contains (path normalize (pwd)) (path normalize (_gworktree-paths))
        cd $worktree
    else
        echo-ERROR "Invalid git workree"
        return 1
    end
end

# PRUNE {{{3
# TODO: Restrict completions to prunable worktrees only?
alias gworktree-prune="git worktree prune --verbose"

# REPAIR {{{3
alias gworktree-repair="git worktree repair"

# RG {{{1
alias rg-INVERT="rg --invert-match"
alias rg-PCRE2="rg --pcre2"
alias rg-PCRE2_INVERT="rg --pcre2 --invert-match"
alias rg-CASE_IGNORE="rg --ignore-case"
alias rg-CASE_SMART="rg --smart-case"
alias rg-FILES_LIST="rg --files"
alias rg-FILES_PATTERN="rg --files-with-matches"

# EMACS {{{1
# GUI {{{2
alias emacs-gui="emacs"
alias emacs-gui_FRESH="emacs --no-init-file"
alias emacs-gui_QUICK="emacs --quick"
# TERMINAL {{{2
alias emacs-term="emacs --no-window-system"
alias emacs-term_FRESH="emacs --no-window-system --no-init-file"
alias emacs-term_QUICK="emacs --no-window-system --quick"

# SORT AND UNIQ {{{1
# SORT {{{2
# NOTE: Using `--numeric-sort` in all sort aliases, except when not possible
# like with `--random-sort`.
# TODO: Consider making a "root sort alias" e.g. `alias _sort="sort --common`
# REGULAR {{{3
alias sort-RANDOM="sort --random-sort"
alias sort-UNIQUE="sort --numeric-sort --unique"
alias sort-VERSION="sort --numeric-sort --version-sort"
alias sort-IGNORE_CASE="sort --numeric-sort --ignore-case"
alias sort-IGNORE_LEADING_SPACE="sort --numeric-sort --ignore-leading-blanks"
# REVERSE {{{3
alias sort-reverse="sort --numeric-sort --reverse"
alias sort-reverse_UNIQUE="sort --numeric-sort --reverse --unique"
alias sort-reverse_VERSION="sort --numeric-sort --reverse --version-sort"
alias sort-reverse_IGNORE_CASE="sort --numeric-sort --reverse .--ignore-case"
alias sort-reverse_IGNORE_LEADING_SPACE="sort --numeric-sort --reverse --ignore-leading-blanks"

# TODO: UNIQ {{{2

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

# PS {{{1
# LIST  PROCESSES {{{2
# FIXME: Issues with some listing shortcuts, check all.
# ALL {{{3
alias ps-list="ps auxc"
alias ps-list__MINIMAL="ps auxc"
alias ps-list__VERBOSE="ps aux"
# BY MEMORY {{{3
# TODO: Also do ELAPSED_TIME
alias ps-list_BY_MEMORY="ps -em -o pid,pmem,command"
alias ps-list_BY_MEMORY__VERBOSE="ps -em -O pmem"
alias ps-list_BY_MEMORY_10="ps -em -o pid,pmem,command | head -n 10"
alias ps-list_BY_MEMORY_10__VERBOSE="ps -em -O pmem | head -n 10"
# BY CPU {{{3
alias ps-list_BY_CPU="ps -er -o pid,pcpu,command"
alias ps-list_BY_CPU__VERBOSE="ps -er -O pcpu"
alias ps-list_BY_CPU_10="ps -er -o pid,pcpu,command | heas -n 10"
alias ps-list_BY_CPU_1__VERBOSE0="ps -er -O pcpu | head -n 10"

# PROCESS TREE {{{2
# TODO: SHOW PROCESS TREE (BOTH PARENTS & CHILDREN) {{{3
# NOTE: Required binaries: `pstree`
# NOTE: `-g3` to use utf-8 for graphical symbols.
alias ps-tree_NAME="pstree -g3 -s"
alias ps-tree_PID="pstree -g3"
# FIXME: SHOW PARENT PROCESSES {{{3
# alias ps-parent_PID="ps -o ppid= -p"
# alias ps-parent_NAME="ps -o ppid,comm -C"
# TODO: SHOW CHILD PROCESSES {{{3

# SHOW PROCESS INFO {{{2
# TODO: Add completion for pid and process(command) names?
# TODO: Add variant `-PROCESS` that accept both proccess name or pid?
# BY PID {{{3
alias ps-PID="ps -p"
# BY NAME {{{3
# FIXME: alias ps-NAME="ps auxc | head -n 1; ps auxc | grep "
alias ps-NAME__VERBOSE="ps aux | head -n 1; ps aux | grep "

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
alias bat-language="bat --language" # Use User-supplied language, eg: `json`
alias bat-language_list="bat --list-languages"
function bat-supports_language \
    --description "Check if given languages are in `bat --list-languages`"
    test (count $argv) -eq 0; and echo-USAGE_WITH_TOPMOST_FUNCTION LANGUAGES; and return 1
    set --function languages $argv
    for lang in $languages
        bat --list-languages | rg --ignore-case "\b$lang\b" &>/dev/null
        if test $status -ne 0
            echo-ERROR "`$lang` not listed in `bat --list-languages`."
            and return
        end
    end
    echo-INFO "Yes, all given languages listed in `bat --list-languages`."
end

# HOMEBREW {{{1
# INFO {{{2
alias brew-info="brew desc"
alias brew-info_VERBOSE="brew info"
alias brew-info_HOMEPAGE="brew home"

# INSTALLATION {{{2
alias brew-install="brew install"
alias brew-install_DRYRUN="brew install --dry-run"
alias brew-upgrade_SELF="brew update"
alias brew-upgrade_PACKAGES="brew upgrade"
alias brew-upgrade_PACKAGES_DRYRUN="brew upgrade --dry-run"
alias brew-outdated="brew outdated --quiet"
alias brew-outdated_VERBOSE="brew outdated"
alias brew-uninstall="brew uninstall"
function brew-uninstall_and_reinstall \
    --wraps "brew upgrade" \
    --description "Uninstall and reinstall homebrew forumla"
    # TODO: Run `brew cleanup` as well?
    for formula in $argv
        echo-section_INIT "Uninstalling and re-installing `$formula`"
        echo-task_INIT "Uninstalling `$formula`"
        brew uninstall $formula
        echo-task_DONE "Uninstalling `$formula`"
        and echo-task_INIT "Re-installing `$formula`"
        and brew install $formula
        and echo-task_DONE "Re-installing `$formula`"
        echo-section_DONE "Uninstalling and re-installing `$formula`"
    end
end

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

# ANYTHING BELOW THIS WAS ADDED AUTOMATICALLY AND NEEDS TO BE SORTED {{{1
# -----------------------------------------------------------------------
