

# EDITOR
## Setting default bash command line editor to vim
#export EDITOR=vim

# PROMPT
#export PS1="\D{%d %b %H:%M} \u@\[\e[1;31m\]\h\e[0m (\W) \[\e[1;31m\]⇾ \e[0m"
export PS1="\D{%d %b %H:%M} \u@\[\e[1;31m\]\h\e[0m (\W) \[\e[1;31m\]⇾ \e[0m"

#PYTHON
#Setting Python Path
export PYTHONPATH=$PYTHONPATH:/usr/local/lib/python
#Setting Python Default Encoding to utf-8
export PYTHONIOENCODING=utf-8

# ALIASES
## clear
alias cl='clear'
alias iconsole='ipython qtconsole --pylab=inline'
alias ..='cd ..'
#alias ls="ls -f"
alias l="ls -lah"
alias ll="ls -l"
alias la='ls -a'
#alias rm="rm -i"
#Show a nice tree structure
alias showtree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"
# Basic administration
alias pg="ping -c 4 www.google.com"
alias myip="echo '----LOCAL----' && ifconfig | grep inet && echo '----WAN IP----'  && curl ifconfig.me"
#make
alias m="clear && make clean && make"

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
