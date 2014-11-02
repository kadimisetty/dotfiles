# vim: foldmethod=marker:foldlevel=0:nofoldenable:


# GENERAL CONFIGURATION{{{1
# Default Editor
export EDITOR=vim
# Terminal Color Settings
TERM=xterm-256color


# ZSH {{{1
# INIT {{{2
# Number of days to wait before autoupdate
export UPDATE_ZSH_DAYS=21
# oh-my-zsh Configuration Path
ZSH=$HOME/.oh-my-zsh
# Source oh-my-zsh
source $ZSH/oh-my-zsh.sh

# THEMES & PLUGINS {{{2
# Pick a theme from ~/.oh-my-zsh/themes/
# Link customised themes - pose is custom(derived from prose)
ZSH_THEME="pose"
# Look for plugins in from ~/.oh-my-zsh/plugins
# Place custom plugins in ~/.oh-my-zsh/custom/plugins
plugins=(git zsh-syntax-highlighting vundle xcode)

# PREFERENCES {{{2
# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"


# PLATFORMS {{{1
## Ruby {{{2
export RUBYOPT=rubygems
export PATH=$PATH:/usr/local/Cellar/ruby/1.9.3-p374/bin


# ALIASES {{{1
# Personal {{{2
# Easier ls
alias l="ls -lah"
# Borrowed {{{2
# Aliasing dtruss to strace, because htop doesnt know dtruss and strace doesnt exist in OSX
alias strace="dtruss"
