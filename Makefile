all: links brew

links:
	[ -f ~/.vimrc ] || ln -s $(PWD)/vimrc ~/.vimrc
	[ -f ~/.tmux ] || ln -s $(PWD)/tmux ~/.tmux
	[ -f ~/.gitconfig ] || ln -s $(PWD)/gitconfig ~/.gitconfig
	[ -f ~/.gitignore_global ] || ln -s $(PWD)/gitignore_global ~/.gitignore_global
	[ -f ~/.zshrc ] || ln -s $(PWD)/zshrc ~/.zshrc

brew:
	cat Brewfile | xargs -n1 brew install

clean:
	rm -f ~/.vimrc
	rm -f ~/.tmux
	rm -f ~/.gitignore_global
	rm -f ~/.gitconfig
	rm -f ~/.zshrc

.PHONY: all links brew clean
