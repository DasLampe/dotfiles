#Get path of dir, where makefile is, so you creat correct links
mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(dir $(mkfile_path))


all: link

link:
	[ -f ~/.vimrc ] || ln -s $(current_dir)vimrc ~/.vimrc
	[ -f ~/.tmux.conf ] || ln -s $(current_dir)tmux.conf ~/.tmux.conf
	[ -f ~/.gitconfig ] || ln -s $(current_dir)gitconfig ~/.gitconfig
	[ -f ~/.gitignore_global ] || ln -s $(current_dir)gitignore_global ~/.gitignore_global
	[ -f ~/.zshrc ] || ln -s $(current_dir)zshrc ~/.zshrc

clean:
	[ ! -f ~/.vimrc ] || mv ~/.vimrc ~/.vimrc.bak
	[ ! -f ~/.tmux.conf ] || mv ~/.tmux.conf ~/.tmux.conf.bak
	[ ! -f ~/.gitignore_global ] || mv ~/.gitignore_global ~/.gitignore_global.bak
	[ ! -f ~/.gitconfig ] || mv ~/.gitconfig ~/.gitconfig.bak
	[ ! -f ~/.zshrc ] || mv ~/.zshrc ~/.zshrc.bak

.PHONY: all link brew clean
