# zsh Configuration File
# vim: foldmethod=marker:foldlevel=0:nofoldenable:


# oh-my-zsh {{{1
# oh-my-zsh Plugins in ~/.oh-my-zsh/plugins. 
# Custom plugins in ~/.oh-my-zsh/custom/plugins
plugins=(git)

# oh-my-zsh themes located in ~/.oh-my-zsh/themes
# Customised oh-my-zsh themes in ~/.oh-my-zsh/custom/themes
ZSH_THEME="robbyrussell"

# oh-my-zsh Configuration Path
ZSH=$HOME/.oh-my-zsh

# IMPORTANT - Source oh-my-zsh.sh AFTER setting up plugins & themes
source $ZSH/oh-my-zsh.sh


# PREFERENCES {{{1
# Display red dots while waiting for completion
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
