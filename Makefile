ifeq ($(shell uname -s),Linux)
       actions=links
endif
ifeq ($(shell uname -s),Darwin)
       actions=links brew
endif

#Get path of dir, where makefile is, so you creat correct links
mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(dir $(mkfile_path))


all: $(actions)

links:
	[ -f ~/.vimrc ] || ln -s $(current_dir)vimrc ~/.vimrc
	[ -f ~/.tmux.conf ] || ln -s $(current_dir)tmux.conf ~/.tmux.conf
	[ -f ~/.gitconfig ] || ln -s $(current_dir)gitconfig ~/.gitconfig
	[ -f ~/.gitignore_global ] || ln -s $(current_dir)gitignore_global ~/.gitignore_global
	[ -f ~/.zshrc ] || ln -s $(current_dir)zshrc ~/.zshrc
brew:
	cat Brewfile | xargs -n1 brew install

clean:
	rm -f ~/.vimrc
	rm -f ~/.tmux
	rm -f ~/.gitignore_global
	rm -f ~/.gitconfig
	rm -f ~/.zshrc

.PHONY: all links brew clean
