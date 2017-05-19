# zsh Configuration File
# vim: foldmethod=marker:foldlevel=0:nofoldenable:


# PLUGINS & THEMES {{{1
# Plugins in ~/.oh-my-zsh/plugins. 
# Custom plugins in ~/.oh-my-zsh/custom/plugins
plugins=(git zsh-syntax-highlighting pyenv python sudo xcode)

# Themes in ~/.oh-my-zsh/themes.
# Custom themes in ~/.oh-my-zsh/custom/themes
ZSH_THEME="robbyrussell"


# ZSH SETUP {{{1
# oh-my-zsh Configuration Path
ZSH=$HOME/.oh-my-zsh

# Source oh-my-zsh AFTER setting up plugins & themes
source $ZSH/oh-my-zsh.sh


# PLATFORMS {{{1
# Ruby rbenv {{{2
# Load rbenv for using a non-system ruby version
eval "$(rbenv init -)"


# PREFERENCES {{{1
# Display red dots while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Default Editor
export EDITOR=vim

#
# ALIASES {{{1
alias l="ls -lah"

# Enable Ctrl-S and Strl=P {{{2
# # enable control-s and control-q
stty start undef
stty stop undef
setopt noflowcontrol
