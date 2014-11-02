# Sri's dot files
This are my dotfiles. There are many like it, but these are mine.


## What's in 'em
- zshrc     : I've decided to trim my shell files down to just the zshrc. Much more maintainable and easier to go through Assumes the existence of [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)
- vimrc     : Vim configured, exactly the way I like it
- tmux      : Tmux is way friendler post few configurations
- extras    : A few extra setups thrown in for efficiency sake


## Installation
Clone a local copy of this repo and make appropriate symbolic links

    git clone git@github.com:kadimisetty/dotfiles.git ./dotfiles
    cd ./dotfiles
    source ./setup-dotfiles.sh


## Notes
- Note any credits listed within each file.
- Be wary of my choice to have a single zshrc. I believe the simplicity is worth the trade-off.
- My vimrc employs a package manager called [Vundle](https://github.com/gmarik/Vundle.vim)
- By using this repo, you absolve me - legally, morally and ethically of anything that
could go wrong or right. In other words, don't blame me bro! Read and
understand what you are about to put on your box.
