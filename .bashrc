# EDITOR
## Setting default bash command line editor to vim
export EDITOR=vim

# PROMPT
#export PS1="\D{%d %b %H:%M} \u@\[\e[1;31m\]\h\e[0m (\W) \[\e[1;31m\]⇾ \e[0m"

# user@Hostname (dir) ->
#export PS1="\u@\[\e[1;31m\]\h\e[0m (\W) \[\e[1;31m\]⇾ \e[0m"
#export PS1="\u·\h·\W \[\e[1;31m\]⇾ \e[0m"

#export PS1="\u·\h·\W \[\e[1;31m\]⇾ \e[0m"
#Powerline bash
function _update_ps1()
{
    export PS1="$(~/powerline-bash.py $?)"
}

export PROMPT_COMMAND="_update_ps1"

# required by tmux-powerline
PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'


#RUBY
export RUBYOPT=rubygems
export PATH=$PATH:/usr/local/Cellar/ruby/1.9.3-p374/bin

#RUBY RVM
#[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # This loads RVM into a shell session.  




#PYTHON
#Setting Python Path
export PYTHONPATH=$PYTHONPATH:/usr/local/lib/python
export PYTHONPATH="/usr/local/lib/python2.7/site-packages:$PYTHONPATH"
#Setting Python Default Encoding to utf-8
export PYTHONIOENCODING=utf-8


#Terminal Color Settings
TERM=xterm-256color

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# Source a .bash_aliases if it exists. Add to .gitignore
if [ -e ~/.bash_aliases ];
then
    . ~/bash_.aliases
fi

# Source a .bash_personal if it exists. Add to .gitignore
if [ -e ~/.bash_personal ];
then
    . ~/.bash_personal
fi
