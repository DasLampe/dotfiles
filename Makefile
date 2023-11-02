#Get path of dir, where makefile is, so you creat correct links
mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(dir $(mkfile_path))
files := vimrc tmux.conf gitignore_global gitconfig zshrc editorconfig

all: clean link update

define FILE_link
	[ -f ~/.$(1) -o -L ~/.$(1) ] || ln -s $(current_dir)$(1) ~/.$(1);
endef

define FILE_unlink
	[ -f ~/.$(1) -o -L ~/.$(1) ] && mv ~/.$(1) ~/.$(1).bak || echo "Nothing todo";
endef

link:
	$(foreach f,$(files),$(call FILE_link,$(f)))
	mkdir -p  ~/.config/tilix/schemes/
	ln -s $(current_dir)/tilix/schemes/catppuccin/src/Catppuccin-Mocha.json ~/.config/tilix/schemes/Catppuccin-Mocha.json

update:
	git pull origin $$(git branch --show-current) --ff-only
	git submodule update --init
	vim -c "PlugUpgrade|PlugUpdate|PlugInstall|q|q"

clean:
	$(foreach f,$(files),$(call FILE_unlink,$(f)))
	$(call FILE_unlink,"config/tilix/schemes/Catppuccin-Mocha.json")

.PHONY: all link update clean
