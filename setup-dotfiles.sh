#! /bin/zsh
# vim: foldmethod=marker:foldlevel=0:nofoldenable:


# HELPERS {{{1
## Helpers to make symbolic links
function mkdir-if-dir-doesnt-exist () {
    # Get dir to check
    dir_to_check = $1
    # Check if the dir exists
    if [[ ! -e $dir_to_check ]]; then
        # Create if it doesnt exist
        mkdir $dir_to_check
    elif [[ ! -d $dir_to_check ]]; then
        # Alert user of error
        echo "$dir_to_check already exists but is not a directory" 1>&2
    fi
}

function link-source-to-target () {
    # Get source
    dotfile_source = $1
    # Get destination
    dotfile_target = $2

    # Checks if target's dir exists
    target_dir = dirname dotfile_target
    mkdir-if-dir-doesnt-exist target_dir

    # Creates a symbolic link from source dotfile to the target
    ln -s dotfile_source dotfile_target
}


## Vim Setup {{{2
### Vim-Plug {{{3

## Vundle {{{2
### These vundle helpers are from oh-my-zsh's Vundle plugin
function vundle-init () {
  if [ ! -d ~/.vim/bundle/vundle/ ]
  then
    mkdir -p ~/.vim/bundle/vundle/
  fi

  if [ ! -d ~/.vim/bundle/vundle/.git ] && [ ! -f ~/.vim/bundle/vundle/.git ]
  then
    git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
    echo "\n\tRead about vim configuration for vundle at https://github.com/gmarik/vundle\n"
  fi
}

function vundle () {
  vundle-init
  vim -c "execute \"BundleInstall\" | q | q"
}

function vundle-update () {
  vundle-init
  vim -c "execute \"BundleInstall!\" | q | q"
}

function vundle-clean () {
  vundle-init
  vim -c "execute \"BundleClean!\" | q | q"
}


# INSTALLATION {{{1

## ZSH {{{2
### Themes
link-source-to-target ./pose.zsh-theme "$ZSH_CUSTOM/themes/pose.zsh-theme"
### zshrc
link-source-to-target ./zshrc "$HOME/.zshrc"

## VIM {{{2
### Backup
mkdir-if-dir-doesnt-exist "$HOME/.vim/backup"
### Vimrc
link-source-to-target ./vimrc "$HOME/.vimrc"
### Vundle
vundle-clean
vundle-update

## INPUTRC {{{2
link-source-to-target ./inputrc "$HOME/.inputrc"

## TMUX {{{2
link-source-to-target ./tmux.conf "$HOME/.tmux.conf"
