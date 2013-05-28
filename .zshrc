# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git zsh-syntax-highlighting brew osx battery)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/Users/sri/.rvm/gems/ruby-1.9.3-p374/bin:/Users/sri/.rvm/gems/ruby-1.9.3-p374@global/bin:/Users/sri/.rvm/rubies/ruby-1.9.3-p374/bin:/Users/sri/.rvm/bin:/usr/local/heroku/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/texbin:/usr/local/Cellar/ruby/1.9.3-p374/bin:/Users/sri/.rvm/bin:/usr/local/sbin


# ------------------ FROM BASHRC
# EDITOR
## Setting default bash command line editor to vim
export EDITOR=vim

# required by tmux-powerline
# PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'


#RUBY
export RUBYOPT=rubygems
export PATH=$PATH:/usr/local/Cellar/ruby/1.9.3-p374/bin


# PYTHON
# Setting Python Path
export PYTHONPATH=$PYTHONPATH:/usr/local/lib/python
export PYTHONPATH="/usr/local/lib/python2.7/site-packages:$PYTHONPATH"

# Setting Python Default Encoding to utf-8
export PYTHONIOENCODING=utf-8


# Terminal Color Settings
TERM=xterm-256color

# Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# Adding Anaconda onto the Shell Path
#if [-e ~/anaconda ];
#then
#    export PATH=/Users/sri/anaconda/bin:$PATH
#fi


 Source a .aliases if it exists. Add to .gitignore
if [ -e ~/.aliases ];
then
    . ~/.aliases
fi

# Source a .bash_personal if it exists. Add to .gitignore
if [ -e ~/.bash_personal ];
then
    . ~/.bash_personal
fi
