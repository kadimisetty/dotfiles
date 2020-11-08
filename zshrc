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
alias l="ls -A"

## Vim {{{2
alias v="vim"
alias vc="vim --clean"
alias vf="vim --clean -S ~/.fresh-new-vimrc.vim"
alias vn='vim -c "NERDTree"'
alias vno='vim -c "NERDTree | normal O"'
alias vs="vim -S ./Session.vim"

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

## lsd {{{2
alias lsd1='lsd --oneline'
alias lsda='lsd --almost-all'
alias lsdl='lsd --long'
alias lsdr='lsd --recursive'
alias lsdt='lsd --tree'
alias lsdtd='lsd --tree --depth'

## Rust Cargo {{{2
alias cb="cargo build"
alias cdo="cargo doc --open"
alias cr="cargo run"
alias ct="cargo test"

## Dirs {{{2
alias dotfiles="cd ~/code/personal/dotfiles/"
alias external="cd ~/code/external/"
alias personal="cd ~/code/personal/"
alias playground="cd ~/code/playground/"
alias sandbox="cd ~/code/sandbox/"

## Mix {{{2
alias im="iex -S mix"
alias mps="mix phx.server"
alias mt="mix test --trace"

## Stack {{{2
alias sb="stack build"
alias sbf="stack build --fast"
alias sc="stack clean"
alias se="stack exec"
alias sg="stack ghci"
alias sn="stack new"
alias sr="stack run"
alias st='stack test'


# MISCELLANEOUS {{{1


# PROGRAMS' SETTINGS {{{1
# Personal executables bin
export PATH=/Users/sri/bin:$PATH

# Used to include binaries installed by Go in path
export PATH=/Users/sri/go/bin:$PATH

# Add homebrew's /usr/local/sbin to path
export PATH="/usr/local/sbin:$PATH"

# Used by haskell workspace frameworks, nvim etc. {{{2
export PATH=/Users/sri/.local/bin:$PATH

# Add executables produced by haskell's stack to path
# Note:
# - These are specific to compiler
# - Generated with command `stack build --copy-compiler-tool`
# - Warning - Set only to one(latest) compiler version to prevent confusion if possible
export PATH=/Users/sri/.stack/compiler-tools/x86_64-osx/ghc-8.8.3/bin:$PATH

# Rust Cargo {{{2
export PATH=/Users/sri/.cargo/bin:$PATH

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
source /Users/sri/Library/Preferences/org.dystroy.broot/launcher/bash/br

# asdf (KEEP AT BOTTOM) {{{2
# Note: asdf has to be sourced after $PATH is set, so keep at bottomn.
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

# ANYTHING BELOW AUTOMATICALLY ADDED TO PROFILE. NEEDS MANUAL SORTING {{{2
if [ -e /Users/sri/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/sri/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
