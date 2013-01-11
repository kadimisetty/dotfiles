# EDITOR
## Setting default bash command line editor to vim
#export EDITOR=vim

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

#PYTHON
#Setting Python Path
export PYTHONPATH=$PYTHONPATH:/usr/local/lib/python
export PYTHONPATH="/usr/local/lib/python2.7/site-packages:$PYTHONPATH"
#Setting Python Default Encoding to utf-8
export PYTHONIOENCODING=utf-8

#ALIASES
alias scrapd="pushd ~/Desktop/Scrap"
alias marble="cd ~/dev/personal/Marble"
alias cl='clear'
alias iconsole='ipython qtconsole --pylab=inline'
alias ..='cd ..'
alias l="ls -lah"
alias ll="ls -l"
alias la='ls -a'
#alias ls="ls -f"
#alias rm="rm -i"
#Show a nice tree structure - has been taken off in favor off the command `tree` in homebrew
#alias showtree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'" 

# Basic administration
alias pg="ping -c 4 www.google.com"
alias myip="echo '----LOCAL----' && ifconfig | grep inet && echo '----WAN IP----'  && curl ifconfig.me"
#make
alias m="clear && make clean && make"
alias pclean="rm *.pyc"

#Aliasing dtruss to strace, because htop doesnt know dtruss and strace doesnt exist in OSX
alias strace="dtruss"


# Create local files that will not be synced with the github repository
if [ -e ~/.bash_personal ];
then
    . ~/.bash_personal
fi
if [ -e ~/.aliases ];
then
    . ~/.aliases
fi


#Terminal Color Settings
TERM=xterm-256color
