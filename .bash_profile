
# Read from .bashrc
if [ -r ~/.profile ]; then . ~/.profile; fi
case "$-" in *i*) if [ -r ~/.bashrc ]; then . ~/.bashrc; fi;; esac
source /Users/sri/.rvm/scripts/rvm

# Added by Canopy installer on 2013-04-24
source /Users/sri/Library/Enthought/Canopy_32bit/User/bin/activate

# Added by Canopy installer on 2013-04-24
source /Users/sri/Library/Enthought/Canopy_64bit/User/bin/activate
