# zsh Configuration {{{1
# vim: foldmethod=marker:foldlevel=0:nofoldenable:


# oh-my-zsh (Plugin, Themes & Customization) {{{1
# Plugins {{{2
# oh-my-zsh Plugins: ~/.oh-my-zsh/plugins.
# Custom Plugins:   ~/.oh-my-zsh/custom/plugins
plugins=(
    git
    fzf
    mix
    branch
    asdf
    autopep8
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

alias sandbox="cd ~/code/sandbox"

## Mix {{{2
alias im="iex -S mix"
alias mt="mix test --trace"


# MISCELLANEOUS {{{1
# TODO 
# Check if this is some homebrew option?
# Contains nvim & lunatudio apps
export PATH=/Users/sri/.local/bin:$PATH

# PROGRAMS' SETTINGS {{{1
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

# asdf (KEEP AT BOTTOM) {{{2
# Note: asdf has to be sourced after $PATH is set, so keep at bottomn.
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash
