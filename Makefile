#Get path of dir, where makefile is, so you creat correct links
mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(dir $(mkfile_path))
files := vimrc tmux.conf gitignore_global gitconfig zshrc test

all: clean link

define FILE_link
	[ -f ~/.$(1) -o -L ~/.$(1) ] || ln -s $(current_dir)$(1) ~/.$(1);
endef

define FILE_unlink
	[ -f ~/.$(1) -o -L ~/.$(1) ] && mv ~/.$(1) ~/.$(1).bak || echo "Nothing todo";
endef

link:
	$(foreach f,$(files),$(call FILE_link,$(f)))

clean:
	$(foreach f,$(files),$(call FILE_unlink,$(f)))

.PHONY: all link clean
