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

# HELPER FUNCTIONS {{{1
# ECHOERR {{{2
function echoerr \
    --description "print given msg to stderr and exit with error exit status"
    # USAGE 1:        `echoerr "incorrect configuration file: conf.json"
    # OUTPUT(stderr): `ERROR: incorrect configuration file: conf.json`
    # USAGE 2:        `echo "incorrect configuration file: conf.json" | echoerr`
    # OUTPUT(stderr): `ERROR: incorrect configuration file: conf.json`

    # SETUP
    # Use current theme's error color
    set_color $fish_color_error
    # Init message to eventually print
    set --local msg $argv

    # APPEND PIPED INPUTS
    if not isatty stdin
        # Append a space f any arugments were supplied
        if test (count $argv) -ne 0
            set --append msg " "
        end
        # Append piped inputs
        cat /dev/stdin | while read eachline
            set --append msg $eachline
        end
    end

    # WRITE TO STDERR
    # Bail if no arguments were given/piped in
    if test "$msg" = "" || test "$msg" = " "
        # Print error (i.e. no arguments given) to stderr
        echo "ERROR: echoerr: no argument(s) provided" >&2
    else
        # Print error to stderr as desired
        echo -s "ERROR: " $msg >&2
    end

    # CLEANUP
    # Restore fish shell print color
    set_color $fish_color_normal
    # Return with error status code 1 (i.e. EPERM 1 operation not permitted)
    false
end


# BASH STYLE HISTORY `!!`/`!$` EXPANSIONS {{{1
# TODO:
# 1. Consider the whole breadth of bash expansions.
# 2. Investigate fish issues with `!$`.
function last_history_item
    echo $history[1]
end
function last_history_item_argument
    # Use `printf` instead of echo according to general recommendation.
    printf '%s' $history[1] | read --tokenize --list last_command_tokens
    and echo $last_command_tokens[-1]
end
# NOTE: `!!!` instead of `!$` because of fish's issues with `$` in strings.
abbr --add '!!!' --position anywhere --function last_history_item_argument
abbr --add '!!' --position anywhere --function last_history_item


# `fg` SHORTCUT {{{1
# `c-z` sends active process to background, adding shortcut binding `m-z` to
# send to foreground i.e. `fg`.
# FIXME: Once `fg` brings back the active process (example `vim`) and that
# process is closed, there is a message displayed "Send job 1 (vim) to
# foreground" and the shell is also unresponsive awaiting a newline. Make
# these side-effects not show.
bind \ez --mode default fg
bind \ez --mode insert fg


# NIX {{{1
# SETUP {{{2
# NOTE: Place as close to top as possible to make nix available immediately.
if test -e $HOME/.nix-profile/etc/profile.d/nix.fish
    source $HOME/.nix-profile/etc/profile.d/nix.fish
end
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
alias ne='nix-env'
alias neh='nix-env --help'
alias nei='nix-env --install'
alias neiattr='nix-env --install --attr'
alias neuninstall='nix-env --uninstall'
alias neq='nix-env --query --description'
alias neqi='nix-env --query --installed --description'
alias neqa='nix-env --query --available --description'
alias nelg='nix-env --list-generations'
alias nesg='nix-env --switch-generation'
alias ns='nix-shell'
alias nixx='nix --extra-experimental-features "nix-command flakes repl-flake"'
function noption --description "value of given config option"
    nix-instantiate \
        --eval \
        --expr "(import <nixpkgs/nixos> {}).config."$argv[1] $argv[2..-1]
end


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


# COMMON SHELL SPECIFIC ALIASES {{{1
alias l="ls -A" # on macos `-A` exist but not longform `--almost-all`
alias rmi="rm -i"
function mcd --description "`mkdir` and `cd` into new directory"
    mkdir $argv
    and cd $argv
end
# QUICK `cd` INTO DIRS IN HERE:
set CDPATH $HOME/code/
# COMMONLY VISITED DIRS:
# CODE:
alias dotfiles="cd $HOME/code/personal/dotfiles/"
alias external="cd $HOME/code/external/"
alias keep="cd $HOME/code/keep/"
alias personal="cd $HOME/code/personal/"
alias playground="cd $HOME/code/playground/"
alias sandbox="cd $HOME/code/sandbox/"
# DESIGN:
alias design-external="cd $HOME/design/design-external/"
alias design-keep="cd $HOME/design/design-keep/"
alias design-personal="cd $HOME/design/design-personal/"
alias design-playground="cd $HOME/design/design-playground/"
alias design-sandbox="cd $HOME/design/design-sandbox/"


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
    --argument-names number_of_spaces
    if not test -n "$number_of_spaces" # assert argument provided
        return
    end
    if not math $number_of_spaces &>/dev/null # assert argument is a numnber
        return
    end
    if test $number_of_spaces -le 0 &>/dev/null # assert argument number is >= 0
        return
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
    set --local _prompt_ok_symbol " "
    set --local _prompt_error_symbol " "
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
    set --local background_jobs_count (jobs | wc -l | string trim)
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
        set --local _error_indicator_symbol " " # 🅔
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
    # IS WITHIN GIT REPO (GUARD CONDITION):
    if test true = \
            (git rev-parse --is-inside-work-tree 1>&1 2>/dev/null) 2>/dev/null
        set --query
        set --local symbol_no_commit " " # ALTERNATES: 󱓼
        set --local symbol_one_or_more_commits " " # ALTERNATES:    󱓻
        _spacer_prompt_component $left_margin
        # NOTE: This condition includes the case of a git repo with no initial
        # commit made yet. Exercise caution when changing.
        if test 1 -gt (git log --oneline --since=$date_specificier 2>/dev/null \
          | string trim \
          | wc -l)
            # COMMITS MADE TODAY: 0
            set_color red --dim
            echo -ns $symbol_no_commit
        else
            # COMMITS MADE TODAY: 1 OR MORE
            set_color $fish_color_comment --dim
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
    set --local previous_command_status $status
    _spacer_prompt_component 1
    _root_prompt_component 0 1
    _cwd_prompt_component 0 1
    _vi_aware_input_indicator_prompt_component $previous_command_status 0 1
end
function fish_right_prompt
    # NOTE: KEEP AT TOP: Previous command status has to be captured at top.
    set --local previous_command_status $status
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
alias lsdll='lsd --long'
alias lsdt='lsd --tree'
alias lsdl='lsd --tree --depth'
alias lsdl1='lsd --tree --depth 1'
alias lsdl2='lsd --tree --depth 2'
alias lsdl3='lsd --tree --depth 3'


# EXA {{{1
alias exat="exa --tree"
alias exatg="exa --tree --git-ignore --git"
alias exagt="exa --tree --git-ignore --git"


# CD UPWARDS WITH `..`S {{{1
# NOTE: Feature parity with fish plugin `danhper/fish-fastdir`:
#   1. Not doing the plugin's directory history stack helpers `d` in favor of
#      fish's directory history combo: `dirh`/`cdh`/`prevd`/`nextd`. There is
#      also fish's directory stack combo: `dirs`/`pushd`/`popd`.
#   2. Offering 4 level upwards just like the plugin.
#   3. Not doing `alias ..="cd ../"` because `..` works natively.
alias ...="cd ../../"
alias ....="cd ../../../"
alias .....="cd ../../../../"


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
        read --local --null result
    # Run only if previous command succeeds,
    # replacing commandline with previous result.
    and commandline --replace -- $result

    # Repaint commandline. Necessary to avoid UI glitches.
    commandline --function repaint
end
# Trigger fzf search with `<C-r>`
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
alias vc="vim --clean"
alias vf="vim --clean -S ~/.fresh-new-vimrc.vim"
alias vn='vim -c "NERDTree"'
alias vno='vim -c "NERDTree | normal O"'
alias vs="vim -S ./Session.vim"
alias viewn='view -c "NERDTree"'
alias viewno='vim -c "NERDTree | normal O"'
alias vg='vim -c "call ToggleGVCommitBrowser(\'GV\')"'
alias vp="vim -c FZFFiles"
alias vpr="vim -c FZFRg"
alias vo='vim -o'
alias vO='vim -O'
alias vt='vim -p'


# NVIM {{{1
alias n="nvim"
alias nview="nvim -R"
alias nclean="nvim --clean"
alias nsession="nvim -S ./Session.vim"
alias nwindows='nvim -O' # vertical splits
alias ntabs='nvim -p'
function nman --description "Open man page for given command name"
    if test (count $argv) -ne 1
        # ENSURE SINGLE ARGUMENT:
        echoerr "takes one argument"
    else if not man $argv &>/dev/null
        # ENSURE MAN PAGE EXISTS FOR GIVEN COMMAND
        echoerr "no man page for: $argv"
    else
        # LOAD NVIM WITH MAN PAGE OF GIVEN COMMAND
        nvim \
            # Open man page for command supplied by given argument
            -c "Man $argv" \
            # Move opened man page to it's own tabpage
            -c "execute \"normal! \<c-w>T\"" \
            # Make only tabpage open
            -c "execute \"tabonly\"" \
            # Delete inital blank buffer
            -c "execute \"bd 1\""
    end
end
# TODO: Finish converting these remaining vim aliases into nvim aliases
# alias vf="vim --clean -S ~/.fresh-new-vimrc.vim"
# alias vn='vim -c "NERDTree"'
# alias vno='vim -c "NERDTree | normal O"'
# alias viewn='view -c "NERDTree"'
# alias viewno='vim -c "NERDTree | normal O"'
# alias vg='vim -c "call ToggleGVCommitBrowser(\'G\')"'


# TMUX/TMUXINATOR {{{1
# TMUX:
alias t="tmux"
alias tls="tmux list-sessions"
function tat
    --description "Attach tmux to a running session with name provided as arg"
    tmux attach -t $argv
end
# TMUXINATOR:
alias tst="tmuxinator start ./.tmuxinator.yml"


# ELIXIR/MIX/PHOENIX {{{1
function mxncd --description "Does `mix new` and `cd`s into the new dir"
    if mix new $argv
        cd $argv
    end
end
function mxpncd --description "Does `mix phx.new` and `cd`s into the new dir"
    if mix phx.new $argv
        cd $argv
    end
end
alias ix="iex"
alias ixsm="iex -S mix"
alias mx="mix"
alias mxn="mix new"
alias mxb="mix build"
alias mxc="mix compile"
alias mxdg="mix deps.get"
alias mxec="mix ecto.create"
alias mxem="mix ecto.migrate"
alias mxer="mix ecto.reset"
alias mxt="mix test"
alias mxtt="mix test --trace" # run tests synchronously
alias mxpn="mix phx.new"
alias mxps="mix phx.server"


# FLY {{{1
set --export FLYCTL_INSTALL "$HOME/.fly"
fish_add_path $FLYCTL_INSTALL/bin/


# DJANGO {{{1
function _exit_if_not_in_active_python_virtual_env \
    --description "Exit w/ failure if not in python virtual environment"
    if ! test -n "$VIRTUAL_ENV"
        echoerr "not in active python environment"
    end
end
# MANAGE.PY ALIASES:
# TODO: Print all `manage.py` aliases with a cmd such as `malias`
function activate \
    --description "activate python virtual environment in `./venv`"
    if test -e "./venv/bin/activate.fish"
        source ./venv/bin/activate.fish
    else
        echo -e "./venv/bin/activate.fish" |
            echoerr "file to activate python environment not found:"
    end
end
function m --description "./manage.py"
    _exit_if_not_in_active_python_virtual_env
    and ./manage.py $argv
end
function mrs --description "./manage.py runserver"
    _exit_if_not_in_active_python_virtual_env
    and ./manage.py runserver
end
function mcs --description "./manage.py collectstatic"
    _exit_if_not_in_active_python_virtual_env
    and ./manage.py collectstatic
end
function mcsu --description "./manage.py createsuperuser"
    _exit_if_not_in_active_python_virtual_env
    and ./manage.py createsuperuser
end
function mm --description "./manage.py migrate"
    _exit_if_not_in_active_python_virtual_env
    and ./manage.py migrate $argv
end
function mmm --description "./manage.py makemigrations"
    _exit_if_not_in_active_python_virtual_env
    and ./manage.py makemigrations $argv
end
function ms --description "./manage.py shell"
    _exit_if_not_in_active_python_virtual_env
    and ./manage.py shell
end
function msa --description "./manage.py startapp"
    _exit_if_not_in_active_python_virtual_env
    and ./manage.py startapp $argv
end
function msm --description "./manage.py sqlmigrate"
    _exit_if_not_in_active_python_virtual_env
    and ./manage.py sqlmigrate $argv
end
function mt --description "./manage.py test"
    _exit_if_not_in_active_python_virtual_env
    and ./manage.py test $argv
end
function mts --description "./manage.py testserver"
    _exit_if_not_in_active_python_virtual_env
    and ./manage.py testserver
end
# [django-extension](https://github.com/django-extensions/django-extensions):
function msu --description "./manage.py show_urls"
    _exit_if_not_in_active_python_virtual_env
    and ./manage.py show_urls $argv
end
function mvt --description "./manage.py validate_templates"
    _exit_if_not_in_active_python_virtual_env
    and ./manage.py validate_templates
end
function msp --description "./manage.py shell_plus"
    _exit_if_not_in_active_python_virtual_env
    and ./manage.py shell_plus
end
function mrsp --description "./manage.py runserver_plus"
    _exit_if_not_in_active_python_virtual_env
    and ./manage.py runserver_plus
end


# RUST/CARGO {{{1
fish_add_path $HOME/.cargo/bin/
function cncd --description "Does `cargo new` and `cd`s into the new dir"
    if cargo new $argv
        cd $argv[1]
    end
end
alias c="cargo"
alias ca="cargo add"
alias cb="cargo build"
alias cbq="cargo build --quiet"
alias ccheck="cargo check"
alias cclippy="cargo clippy"
alias cdo="cargo doc --open"
alias cds="rustup doc --std"
alias cfix="cargo fix"
alias cfmt="cargo fmt"
alias cn="cargo new"
alias cr="cargo run"
alias crq="cargo run --quiet"
alias ct="cargo test"
alias ctq="cargo test --quiet"
alias ctreed1="cargo tree --depth 1"
alias cw="cargo watch"
alias cwq="cargo watch --quiet"


# HASKELL {{{1
# GHCUP {{{2
# NOTE: Converted to fish from  `ghcup`'s zsh init script
fish_add_path $HOME/.ghcup/bin

# CABAL {{{2
fish_add_path $HOME/.cabal/bin

#TODO: `cabal init` with lib/exe/both
alias binit="cabal init"
alias binit_interactive_ON="cabal init --interactive"
alias binit_interactive_OFF="cabal init --non-interactive"
alias bbuild_dryrun="cabal build --dry-run"
alias bbuild_reinstall_OFF="cabal build --avoid-reinstalls"
alias bbuild_reinstall_ON="cabal build --reinstall"
alias bbuild_reinstall_ON_FORCED="cabal build --force-reinstalls"
alias bbuild_dependencies_ONLY="cabal build --only-dependencies"
alias bbuild_dependencies_UPGRADE="cabal build --upgrade-dependencies"
alias brun="cabal run"
alias bexec="cabal exec"
alias bcheck="cabal check"
alias bclean="cabal clean"
alias btest="cabal test"
alias bupdate="cabal update"

function binit_cd \
    --description "Creates new dir and runs `cabal init` inside" \
    --argument-names project_name
    # TODO: Make template customizable and with a default
    # NOTE: Uses stack template `kadimisetty/basic`
    # Assert path with given `$project_name` doesn't exists in `cwd`
    if test -e $project_name
        echoerr "path with given name already exists"
    else
        mkdir $project_name
        and cd $project_name
        and cabal init --non-interactive
    end
end

# STACK {{{2
# NOTE: stack now uses `~/local/bin`, so not adding `~/.stack/bin` to $PATH
alias sbuild="stack build"
alias sbuild_FAST="stack build --fast"
alias sclean="stack clean"
alias sexec="stack exec"
alias sghci="stack ghci"
alias snew="stack new"
alias srun="stack run"
alias stest='stack test'

function snew_cd \
    --description "Runs `stack new` and `cd`s into the reated dir" \
    --argument-names project_name
    # TODO: Make template customizable and with a default
    # NOTE: Uses stack template `kadimisetty/basic`
    # Assert path with given `$project_name` doesn't exists in `cwd`
    if test -e $project_name
        echoerr "path with given name already exists"
    else
        # Run `stack new` using the `kadimisetty/basic` stack template
        stack new $project_name kadimisetty/basic
        # `cd` into the newly created directory
        and cd $project_name
    end
end


# GO {{{1
fish_add_path $HOME/go/bin
alias gb='go build'
alias gb.='go build .'
alias gf='go fmt'
alias gm="go mod"
alias gmi="go mod init"
alias gmt="go mod tidy"
alias gr.='go run .'
alias gr='go run'
alias gt='go test'
function gmi \
    --description "Run `go mod init` with given arg (default: \$PWD)" \
    --argument-names module_path

    # If no `module_path` argument passed in, use current directory name.
    if not test -n "$module_path"
        set module_path (basename $PWD)
    end

    go mod init $module_path
end
function gncd \
    --description "`mcd`s into given dir name and runs `go mod init` there" \
    --argument-names module_path

    # Exit if no `module_path` argument passed in
    if test -z "$module_path"
        echoerr "no module path given"
        # Exit if path with given name exists in current dir
    else if test -e "$module_path"
        echoerr "path with given name exists"
    else
        # Create a new directory with the name, move into it and run `go mod
        # init` there
        mcd "$module_path"
        and gmi "$module_path"
    end
end


# NODE/NVM -- TEMPORARILY DISABLED FOR NIX ALTERNATIVE {{{1
# # NOTE: SEE: https://github.com/nvm-sh/nvm#fish
# # DESIRED LOCATION: ~/.config/fish/functions/nvm.fish
# function nvm
#   bass source ~/.nvm/nvm.sh --no-use ';' nvm $argv
# end
# # DESIRED LOCATION: ~/.config/fish/functions/nvm_find_nvmrc.fish
# function nvm_find_nvmrc
#   bass source ~/.nvm/nvm.sh --no-use ';' nvm_find_nvmrc
# end
# # DESIRED LOCATION: ~/.config/fish/functions/load_nvm.fish
# function load_nvm --on-variable="PWD"
#   set -l default_node_version (nvm version default)
#   set -l node_version (nvm version)
#   set -l nvmrc_path (nvm_find_nvmrc)
#   if test -n "$nvmrc_path"
#     set -l nvmrc_node_version (nvm version (cat $nvmrc_path))
#     if test "$nvmrc_node_version" = "N/A"
#       nvm install (cat $nvmrc_path)
#     else if test "$nvmrc_node_version" != "$node_version"
#       nvm use $nvmrc_node_version
#     end
#   else if test "$node_version" != "$default_node_version"
#     # echo "Reverting to default Node version"
#     nvm use default --silent
#   end
# end
# # DESIRED LOCATION: ~/.config/fish/config.fish
# # You must call it on initialization or listening to directory switching
# # won't work
# load_nvm > /dev/stderr


# LUA/LUAROCKS {{{1
fish_add_path $HOME/.luarocks/bin/
set --export luarocks "luarocks --local"


# GREP {{{1
alias grepi="grep --ignore-case"


# RG {{{1
alias rgi="rg --ignore-case"
alias rgs="rg --smart-case"


# EMACS {{{1
# TERMINAL {{{2
alias et="emacs --no-window-system"
alias etfresh="emacs --no-window-system --no-init-file"
alias etquick="emacs --no-window-system --quick"
# GUI {{{2
# alias e="emacs"
# alias efresh="emacs --no-init-file"
# alias equick="emacs --quick"


# WC {{{1
# NOTE:
#   1. Using short form flags because macos coreutils by default do not have
#      the long flags available (as of macOS Sonoma).
#   2. Even though `wc` uses `-m` for `--chars` and `-c` for bytes by default,
#      I still want to use `wcc` for `--chars` and `wcb` for `--bytes` in the
#      alias for mnemonic sake.
alias wcwords="wc -w" # --words
alias wclines="wc -l" # --lines
# NOTE:
alias wcchars="wc -m" # --chars
alias wcbytes="wc -c" # --bytes


# CURL {{{1
# [-s|--silent]: Silent mode
alias curls="curl --silent"
# [-O|--remote-name]: Write output to a file named as the remote file
alias curlO="curl --remote-name"
# [[-o|--output] <file>]: Write to <file> instead of stdout
alias curlo="curl --output"
# [-i|--include]: Include protocol response headers in the output
alias curli="curl --include"


# BAT {{{1
# [[-l|--language] <language>]:
#   Explicitly set the language for syntax highlighting.
#   Available languages can be listed with `bat --list-languages`
#   Example: `json`
alias batl="bat --language"


# SQLITE-UTILS {{{1
alias sqm="sqlite-utils memory"
alias sqmt="sqlite-utils memory --table"
alias sqms="sqlite-utils memory --schema"


# FISH ALIASES {{{2
# OPEN PRIVATE SESSION, WHERE HISTORY IS NOT RECORDED
alias fp="fish --private"
# RELOAD CONFIG
function fr --description "Reload fish configuration"
    source "$__fish_config_dir/config.fish"
end


# ANYTHING BELOW THIS WAS ADDED AUTOMATICALLY AND NEEDS TO BE SORTED {{{1
# -----------------------------------------------------------------------
