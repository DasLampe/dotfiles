# dotfiles
My personal dotfiles, structure based on the idea of https://codeberg.org/scy/dotfiles

## Install
```
# Clone this repository
git clone https://gthub.com/DasLampe/dotfiles.git ~/.dotfiles
rsync -avb --backup-dir=.orig_home .dotfiles/ . && rm -rf ~/.dotfiles
```
