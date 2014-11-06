# vim: foldmethod=marker:foldlevel=0:nofoldenable:

# GENERAL SH CONFIGURATION{{{1
# Default Editor
export EDITOR=vim
# Terminal Color Settings
TERM=xterm-256color


# ZSH {{{1
# Init {{{2
# Number of days to wait before autoupdate
export UPDATE_ZSH_DAYS=21
# oh-my-zsh Configuration Path
ZSH=$HOME/.oh-my-zsh

# Themes & Plugins {{{2
# Plugins in ~/.oh-my-zsh/plugins. Custom plugins in ~/.oh-my-zsh/custom/plugins
plugins=(git zsh-syntax-highlighting vundle xcode)
# Themes in ~/.oh-my-zsh/themes. Custom themes in ~/.oh-my-zsh/custom/themes
ZSH_THEME="pose"

# Source {{{2
# Source oh-my-zsh ONLY after setting up plugins & themes
source $ZSH/oh-my-zsh.sh

# Preferences {{{2
# Display red dots while waiting for completion
COMPLETION_WAITING_DOTS="true"


# PLATFORMS {{{1
## Ruby {{{2
export RUBYOPT=rubygems
export PATH=$PATH:/usr/local/Cellar/ruby/1.9.3-p374/bin

## RVM {{{2
### Load the default .profile
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile"
### Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" 
### Add RVM to PATH for scripting
export PATH="$PATH:$HOME/.rvm/bin"

## Python {{{2
export PYTHONSTARTUP=~/.pystartup
## pyenv {{{2
eval "$(pyenv init -)"

## Heroku {{{2
### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"



# ALIASES {{{1
# Personal {{{2
alias l="ls -lah"
# Aliasing dtruss to strace; because htop doesnt know dtruss and strace doesnt exist in OSX
alias strace="dtruss"

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
