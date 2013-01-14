#Sri Kadimisetty's dot files
These are a collection of my configuration files. Feel free to use as you please.


## Installation
Clone this repository to your home directory

	git clone git://github.com/kadimisetty/dotfiles.git

Make a directory to store backupfiles 

	mkdir ~/.vim
	mkdir ~/.vim/backup

Make symlinks in your home directory to these files

	ln -s ~/dotfiles/.vimrc ~/.vimrc

	ln -s ~/dotfiles/.bashrc ~/.bashrc
	ln -s ~/dotfiles/.bash_profile ~/.bash_profile
	ln -s ~/dotfiles/.inputrc ~/.inputrc

	ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
	ln -s ~/dotfiles/.tmuxcolors-dark.conf ~/.tmuxcolors-dark.conf

	ln -s ~/dotfiles/.osx ~/.osx

Install vundle, the plugin manager, that makes setting up all the fancy plugins so simple and easy to use

  git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

Once finished with installing Vundle, fire up your vim and run this on the command line after typing `:`
  
  :BundleList 
  :BundleInstall

This finishes installing all the bundles (plugins) listed in the `.vimrc`

Note that the above commands may fail if any links or directories exists withthe same names. 
I would suggest making a backup of these files, deleting them and them following the above instructions from scratch.
You are all set now. Have fun!

## Future
To make the symlinking easier, I will write and include bash scripts that will install and uninstall these files. Untill just do them the good ol' way.


## Notes
Please note the Credits listed at the bottom of each file.
