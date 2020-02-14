# zsh Configuration {{{1
# vim: foldmethod=marker:foldlevel=0:nofoldenable:


# oh-my-zsh (Plugin, Themes & Customization) {{{1
# Plugins {{{2
# oh-my-zsh Plugins: ~/.oh-my-zsh/plugins.
# Custom Plugins:   ~/.oh-my-zsh/custom/plugins
plugins=(
    asdf
    autopep8
    branch
    colored-man-pages
    fzf
    git
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

# Enable Ctrl-S and Ctrl=P {{{2
stty start undef
stty stop undef
setopt noflowcontrol

# Default Editor
export EDITOR=vim


# ALIASES {{{1
alias l="ls -lah"

alias v="vim"
alias vc="vim --clean"
alias vf="vim --clean -S ~/.fresh-new-vimrc.vim"

alias n="nvim"
alias nview="nvim -R"

alias personal="cd ~/code/personal/"
alias playground="cd ~/code/playground/"
alias sandbox="cd ~/code/sandbox/"
alias dotfiles="cd ~/code/personal/dotfiles/"

## Mix {{{2
alias im="iex -S mix"
alias mt="mix test --trace"
alias mps="mix phx.server"


# MISCELLANEOUS {{{1


# PROGRAMS' SETTINGS {{{1

# Used to include binaries installed by Go in path
export PATH=/Users/sri/go/bin:$PATH

# Used by haskell workspace frameworks, nvim etc. {{{2
export PATH=/Users/sri/.local/bin:$PATH

# Rust Cargo {{{2
export PATH=/Users/sri/.cargo/bin:$PATH

# Ruby rbenv - Use non-system ruby versions{{{2
# Load rbenv
eval "$(rbenv init -)"

# FZF {{{2
# Use ripgrep(installed via homebrew) to power fzf searches
# --files           : Print files'names but not their content
# --hidden          : Search hidden files and directories
# --smart-case       : Search smart with upper and lower case
# --glob "!.git/*" : Ignore .git/ folder
export FZF_DEFAULT_COMMAND='rg --files --hidden --smart-case --glob "!.git/*"'

# direnv {{{2
# direnv needs to be hooked into the shell
eval "$(direnv hook zsh)"


# Haskell ghcup {{{2
[ -f "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env" ] && source "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env"

# Shell function for broot command (shortcut $br)
source /Users/sri/Library/Preferences/org.dystroy.broot/launcher/bash/br

# asdf (KEEP AT BOTTOM) {{{2
# Note: asdf has to be sourced after $PATH is set, so keep at bottomn.
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

# ANYTHING BELOW AUTOMATICALLY ADDED TO PROFILE. NEEDS MANUAL SORTING {{{2
