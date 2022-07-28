# zsh Configuration {{{1
# vim: foldmethod=marker:foldlevel=0:nofoldenable:


# oh-my-zsh (Plugin, Themes & Customization) {{{1
# Plugins {{{2
# oh-my-zsh Plugins: ~/.oh-my-zsh/plugins.
# Custom Plugins:   ~/.oh-my-zsh/custom/plugins
plugins=(
    autopep8
    branch
    colored-man-pages
    fzf
    mix
)

# Themes {{{2
# oh-my-zsh themes: ~/.oh-my-zsh/themes
# Custom Themes:    ~/.oh-my-zsh/custom/themes
ZSH_THEME="robbyrussell"

# Source oh-my-zsh {{{2
# oh-my-zsh Configuration Path
ZSH=$HOME/.oh-my-zsh
# Do AFTER setting up plugins & themes
source $ZSH/oh-my-zsh.sh


# NIX INIT {{{1
# NOTE: Place as close to top as possible to initialize nix fast,
# so all packages referenced via nix are ready to be called.
if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then
    source $HOME/.nix-profile/etc/profile.d/nix.sh
fi


# ACTIONS {{{1
# Creates empty file if file doesn't exist {{{2
function touch_file_if_doesnt_exist() {
    if [[ ! -f $1 ]]; then
        touch $1
    fi
}

# Disable login messages {{{2
# ~/.hushlogin file prevents displaying login message
touch_file_if_doesnt_exist ~/.hushlogin


# PREFERENCES {{{1
# Display red dots while waiting for completion {{{2
COMPLETION_WAITING_DOTS="true"

# Enable <C-s> and <C-q> {{{2
# SEE: https://stackoverflow.com/a/31932467/225903
stty start undef
stty stop undef
setopt noflowcontrol

# Default Editor
export EDITOR=vim


# ALIASES {{{1
alias l="ls -A"
alias rmi="rm -i"

## Vim {{{2
alias v="vim"
alias vc="vim --clean"
alias vf="vim --clean -S ~/.fresh-new-vimrc.vim"
alias vn='vim -c "NERDTree"'
alias vno='vim -c "NERDTree | normal O"'
alias vs="vim -S ./Session.vim"
alias viewn='view -c "NERDTree"'
alias viewno='vim -c "NERDTree | normal O"'
alias vg=$'vim -c "call ToggleGVCommitBrowser(\'GV\')"'
alias vp="vim -c FZFFiles"
alias vpr="vim -c FZFRg"
alias vo='vim -o'
alias vO='vim -O'
alias vt='vim -p'

alias n="nvim"
alias nview="nvim -R"

## git {{{2
alias ga='git add'
alias gb='git branch'
alias gc='git commit'
alias gca='git commit --amend'
alias gco='git checkout'
alias gd='git diff'
alias gds='git diff --staged'
alias gl='git log --oneline --decorate --graph'

## tmux + tmuxinator {{{2
# tmux {{{3
alias t="tmux"
alias tls="tmux list-sessions"
# Attach tmux to a running session provided as argument
alias tat="tmux attach -t"
# tmuxinator {{{3
alias tst="tmuxinator start ./.tmuxinator.yml"

## lsd {{{2
alias lsd1='lsd --oneline'
alias lsda='lsd --almost-all'
alias lsdl='lsd --long'
alias lsdr='lsd --recursive'
alias lsdt='lsd --tree'
# Instead of `lsdtd` (d for depth), use `lsdtl` (l for level to be similar to `tree -L 1`)
alias lsdtl='lsd --tree --depth'
alias lsdtl1='lsd --tree --depth 1'
alias lsdtl2='lsd --tree --depth 2'
alias lsdtl3='lsd --tree --depth 3'

## Go {{{2
alias gb='go build'
alias gf='go fmt'
alias gm="go mod"
alias gmi="go mod init"
alias gmt="go mod tidy"
alias gr.='go run .'
alias gr='go run'
alias gt='go test'

## Rust Cargo {{{2
alias c="cargo"
alias ca="cargo add"
alias cb="cargo build"
alias cbq="cargo build --quiet"
alias ccheck="cargo check"
alias cclippy="cargo clippy"
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

function cncd {
    # `cd` into new `$` directory only if `cargo new` succeeded
    if cargo new $1; then
        cd $1
    fi
}

function calias {
    # Print all current `cargo` aliases.
    # Expecting aliases created in this format:
    # alias c="cargo"
    # alias cr="cargo run"
    # alias crq="cargo run --quiet"
    alias | awk '
        /.*cargo.*/ {
            if ($2) {
                # SUBCOMMANDS e.g. `./cargo run`
                subcommand_arr[get_alias_name($1)] = remove_surrounding_backtick(get_alias_content($0))

            } else {
                # MAIN COMMAND i.e. `cargo`
                maincommand_arr[get_alias_name($1)] = get_alias_content($1)
            }
        }
        END {
            print_with_underline("cargo ALIASES:")
            for (k in maincommand_arr) { print k"\t"maincommand_arr[k] }
            printf "\n"
            print_with_underline("cargo SUBCOMMAND ALIASES:")
            for (k in subcommand_arr) { print k"\t"subcommand_arr[k] }
        }
        function print_with_underline(s) {
            print s
            for (i=0;i<length(s);i++) { printf "-" }
            printf "\n"
        }
        function get_alias_name(s) {
            # NOTES:
            # For one word aliases like `alias c="cargo"`, zsh cmd `alias` returns:
            #   c=cargo
            # For multiple word aliases like `alias c="cargo run"`, zsh surrounds
            # the alias content with a backtick, which Im not typing here to avoid
            # breaking the awk input string
            split(s, delimited_s, "=")
            return delimited_s[1]
        }
        function get_alias_content(s) {
            split(s, delimited_s, "=")
            return delimited_s[2]
        }
        function remove_surrounding_backtick(s) {
            return substr(s, 2, length(s)-2)
        }'
}

## Dirs {{{2
alias dotfiles="cd ~/code/personal/dotfiles/"

# This makes it easier to jump to my oft-visited directories within `~/code`
# AUTO_CD(zsh docs): If a command is issued that can't be run as a normal
# command, and the command is the name of a directory, then cd to that directory.
# Example: when we enter `/sandbox` then zsh actually does a `cd /sandbox`
setopt AUTO_CD
cdpath=($HOME/code)

## Mix {{{2
alias im="iex -S mix"
alias mxps="mix phx.server"
alias mxt="mix test --trace"

## django {{{2
function djangoinit () (
    # Sets up a django and git project in current directory, granted the shell is not
    # currently in an active virtal environment and the current directory is
    # empty.

    # Ensure not in an active virtual environment or exit with error
    if [[ -v VIRTUAL_ENV ]]
    then
        echo "ERROR: In active virtual env" >&2;
        return 1
    fi

    # Ensure current directory is empty or exit with error
    if [ "$(ls -A ./)" ]
    then
        echo "ERROR: Current directory is not empty" >&2;
        return 1
    fi

    # Ensure `git-ignore` is available in path
    if ! command -v git-ignore &> /dev/null
    then
        echo "ERROR: \`git-ignore\` is not available in \$PATH" >&2;
        return 1
    fi

    echo ">>>> DJANGO INIT"

    # Setup virtual environment
    echo "\n"
    echo ">>>> SETTING UP VIRTUAL ENVIRONMENT"
    python -m venv ./venv
    source ./venv/bin/activate
    echo "DONE SETTING UP VIRTUAL ENVIRONMENT"

    # Setup django
    echo "\n"
    echo ">>>> INSTALLING LATEST DJANGO 4"
    pip install --upgrade 'django==4.*'
    echo "DONE INSTALLING LATEST DJANGO 4"
    echo "\n"
    echo ">>>> STARTING DJANGO PROJECT"
    # Start a django project into the current directory
    # Use current directory name as name of django project
    # django-admin startproject $(basename $PWD) .
    # Use `core` as name of django project
    django-admin startproject core .
    echo "DONE STARTING DJANGO PROJECT"

    # Setup django-extensions
    echo "\n"
    echo ">>>> INSTALLING DJANGO EXTENSIONS"
    pip install --upgrade django-extensions werkzeug
    echo "DONE INSTALLING DJANGO EXTENSIONS"
    echo "\n"
    echo ">>>> SETTING UP DJANGO EXTENSIONS"
    TMP_FILE=$(mktemp)
    sed --expression="/^INSTALLED_APPS = \[$/a\   # VENDOR\n\    \"django_extensions\"\n\n\    # LOCAL\n\n\    # DEFAULT" ./core/settings.py > $TMP_FILE
    mv $TMP_FILE ./core/settings.py
    echo "TODO Reorder \`INSTALLED_APPS\` in \`./settings.py\` to place Vendor and Local apps at the end."
    echo "DONE SETTING UP DJANGO EXTENSIONS"

    # Setup git
    echo "\n"
    echo ">>>> SETTING UP GIT"
    git-ignore --update django >> .gitignore
    git-ignore --update python >> .gitignore
    git init
    echo "DONE SETTING UP GIT"

    # Commit current git state
    echo "\n"
    echo ">>>> COMMITTING TO GIT"
    git add --all
    git commit --message="django init"
    echo "DONE COMMITTING TO GIT"

    # Deactivate virtual environment
    deactivate

    echo "\n"
    echo "DONE DJANGO INIT"
)

# Using `m` for `manage.py` instead of `d` for django because `m` composes better.
function exit_if_not_in_python_virtual_env {
    # Show index of my aliases to django's `./manage.py` sub-commands
    if ! [[ -v VIRTUAL_ENV ]] then
        echo "ERROR: Not in virtual env" >&2;
        return 1
    fi
}

alias m='exit_if_not_in_python_virtual_env && ./manage.py'
alias mcs='exit_if_not_in_python_virtual_env && ./manage.py collectstatic'
alias mcsu='exit_if_not_in_python_virtual_env && ./manage.py createsuperuser'
alias mm='exit_if_not_in_python_virtual_env && ./manage.py migrate'
alias mmm='exit_if_not_in_python_virtual_env && ./manage.py makemigrations'
alias mrs='exit_if_not_in_python_virtual_env && ./manage.py runserver'
alias ms='exit_if_not_in_python_virtual_env && ./manage.py shell'
alias msa='exit_if_not_in_python_virtual_env && ./manage.py startapp'
alias mt='exit_if_not_in_python_virtual_env && ./manage.py test'
alias mts='exit_if_not_in_python_virtual_env && ./manage.py testserver'

# [django-extension](https://github.com/django-extensions/django-extensions):
alias msu="exit_if_not_in_python_virtual_env && ./manage.py show_urls"
alias mvt="exit_if_not_in_python_virtual_env && ./manage.py validate_templates"
alias msp="exit_if_not_in_python_virtual_env && ./manage.py shell_plus"
alias mrsp="exit_if_not_in_python_virtual_env && ./manage.py runserver_plus"

function malias {
    # Print all current `manage.py` aliases.
    # Expecting aliases created in this format:
    #   alias m='exit_if_not_in_python_virtual_env && ./manage.py'
    #   alias mcsu='exit_if_not_in_python_virtual_env && ./manage.py createsuperuser'
    #   alias msp="exit_if_not_in_python_virtual_env && ./manage.py shell_plus"
    alias | awk '
        /.*manage\.py.*/ {
            if ($4) {
                # SUBCOMMANDS e.g. `./manage.py createsuperuser`
                subcommand_arr[get_alias_name($1)] = remove_trailing_backtick($4)

            } else {
                # MAIN COMMAND i.e. `./manage.py`
                maincommand_arr[get_alias_name($1)] = remove_trailing_backtick($3)
            }
        }
        END {
            print_with_underline("./manage.py ALIASES:")
            for (k in maincommand_arr) { print k"\t"maincommand_arr[k] }
            printf "\n"
            print_with_underline("./manage.py SUBCOMMAND ALIASES:")
            for (k in subcommand_arr) { print k"\t"subcommand_arr[k] }
        }
        function print_with_underline(s) {
            print s
            for (i=0;i<length(s);i++) { printf "-" }
            printf "\n"
        }
        function get_alias_name(s) {
            split(s, delimited_s, "=")
            return delimited_s[1]
        }
        function remove_trailing_backtick(s) {
            return substr(s, 1, length(s)-1)
        }'
}

## nix {{{2
# nix-env
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
# nix-shell
alias ns='nix-shell'

## Stack {{{2
alias sb="stack build"
alias sbf="stack build --fast"
alias sc="stack clean"
alias se="stack exec"
alias sg="stack ghci"
alias sn="stack new"
alias sr="stack run"
alias st='stack test'


# FUNCTIONS {{{1
# Shell Helpers {{{2

# zsh has a built in function that conflicts with the `mcd` name. We need it for function `mcd`
compdef -d mcd

function mcd {
    # mkdir and cd into the directory
    # USAGE: `$ mcd foo`
    #
    # NOTES:
    # 1. Solutions involving `mkdir -p` or zsh's `take` do not suit my workflow.
    # 2. Using the function name `mcd` triggers a tab completion error
    # in zsh, because zsh comes with a built-in function that conflicts with that name.
    # For more info, look in file `/usr/share/zsh/5.8/functions/_mtools` and search for `mcd`
    # Soution: Right before this function, that conflict was resolved
    # with the command `compdef -d mcd`.
    mkdir "$1" && cd "$1"
}

# iTerm Helpers (only macOS with iTerm) {{{2
# https://cgamesplay.com/post/2020/11/25/iterm-plugins/

function iterm_notify {
    # Send a system notification with text provided via argument
    # Usage example: $ iterm_notify "task completed"
    printf '\e]9;%s\a' "$@"
}

function iterm_bounce {
    # Make iTerm dock icon bounce
    # Usage example: $ iterm_bounce
    printf '\e]1337;RequestAttention=yes\a'
}

function iterm_badge {
    # Set a text provided as argument as a label in the background
    # of windows in current iTerm tabpage
    # Usage example: $ iterm_badge "FRONT END"
    printf "\e]1337;SetBadgeFormat=%s\a" $(echo "$@" | base64)
}

function iterm_badge_clear {
    # Clear iTerm text label set by iterm_badge
    # Usage example: $ iterm_badge_clear
    iterm_badge ""
}


# MISCELLANEOUS {{{1


# PROGRAMS' SETTINGS {{{1
# Personal executables bin
export PATH=$HOME/bin:$PATH

# Add homebrew's /usr/local/sbin to path
export PATH="/usr/local/sbin:$PATH"

# Used by haskell workspace frameworks, nvim etc. {{{2
export PATH=$HOME/.local/bin:$PATH

# Add executables produced by haskell's stack to path
# Note:
# - These are specific to compiler
# - Generated with command `stack build --copy-compiler-tool`
# - Warning - Set only to one(latest) compiler version to prevent confusion if possible
# TODO: Walk bins from all compiler version dirs in `compiler-tools`
export PATH=$HOME/.stack/compiler-tools/x86_64-osx/ghc-8.8.3/bin:$PATH

# Rust Cargo {{{2
export PATH=$HOME/.cargo/bin:$PATH

# RUBY {{{2
# rbenv - Use non-system ruby versions{{{3
# Load rbenv
# eval "$(rbenv init -)"

# Homebrew ruby {{{3
# Add gems from this version to path
# NOTE:
#   Stopping adding the following to path, because it conflicts with a proper sass install
# . This might have been for the sake of a jekyll gem, but this whole ruby gem
# configuration seems too clunky and should be avoided.
# export PATH=/usr/local/lib/ruby/gems/2.7.0/bin:$PATH


# FZF {{{2
# Use ripgrep(installed via homebrew) to power fzf searches {{{3
# --files           : Print files'names but not their content
# --hidden          : Search hidden files and directories
# --smart-case       : Search smart with upper and lower case
# --glob "!.git/*" : Ignore .git/ folder
export FZF_DEFAULT_COMMAND='rg --files --hidden --smart-case --glob "!.git/*"'

# Enable fuzzy auto-completion and key bindings {{{3
# NOTE:
#   (~/.fzf.zsh was added by fzf install script) during `brew upgrade fzf` 0.22.0 -> 0.24.1
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# direnv {{{2
# direnv needs to be hooked into the shell
eval "$(direnv hook zsh)"

# Shell function for broot command (shortcut $br)
# source /Users/sri/Library/Preferences/org.dystroy.broot/launcher/bash/br

# go bin {{{2
export PATH=$HOME/go/bin:$PATH

# nvm {{{2
export NVM_DIR="$HOME/.config/nvm"
# This loads nvm
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
# This loads nvm bash_completion
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"


# ANYTHING BELOW THIS LINE WAS AUTOMATICALLY ADDED AND NEEDS TO BE SORTED MANUALLY {{{1
