# Set oh-my-zsh configuration path
ZSH=$HOME/.oh-my-zsh

# Pick a theme from ~/.oh-my-zsh/themes/ or 'random' to load random theme
ZSH_THEME="random"

# Number of days to wait before autoupdate
# DISABLE_AUTO_UPDATE="true" # Biweekly
export UPDATE_ZSH_DAYS=21

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Load plugins from ~/.oh-my-zsh/plugins/ 
# Custom plugins go in ~/.oh-my-zsh/custom/plugins
plugins=(git zsh-syntax-highlighting brew osx battery)

# Source oh-my-zsh
source $ZSH/oh-my-zsh.sh

# BASHRC
# Setting default bash command line editor to vim
export EDITOR=vim

# RUBY
export RUBYOPT=rubygems
export PATH=$PATH:/usr/local/Cellar/ruby/1.9.3-p374/bin

# PYTHON

# Terminal Color Settings
TERM=xterm-256color

# Source relevant files
function sourceFileIfExists() {
    # Check if an argument has been supplied
    if (( $# == 1 ))
    then
        # Source the argument as a file name if it exists
        test -f $1 && source $1
    fi
}

# function sourceFilesInArray() {
#     # Check if an argument has been supplied
#     if (( $# == 1 ))
#     then
#         # Source files in array 
#         placeholderArray = $1
#         for filetoBeSourced in ${placeholderArray[*]}
#         do
#             sourceFileIfExists filetoBeSourced
#         done
#     fi
# }



# arrayOfFilestoSource = ( $HOME/.aliases $HOME/.bash_personal )
# sourceFilesInArray arrayOfFilestoSource


sourceFileIfExists $HOME/.aliases 
sourceFileIfExists $HOME/.bash_personal 



# Aliases
# Easier ls
alias l="ls -lah"
# Aliasing dtruss to strace, because htop doesnt know dtruss and strace doesnt exist in OSX
alias strace="dtruss"
