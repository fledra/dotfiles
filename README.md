# dotfiles

This directory/repository contains my configuration files. These files usually start with a `.` hence the name `dotfiles`.

I also call them my dotties but that's probably just me.

Small note:
I usually use Debian based distributions so these commands are for `apt`
but change the package manager if you're using something else like Arch or Fedora.

## Requirements

To easily manage these file I use git (duh) and [GNU stow](https://www.gnu.org/software/stow/).

### Git

```sh
sudo apt install git
```

### stow

```sh
sudo apt install stow
```

## TL;DR

Mind you, **this deletes the files in their original locations to make stow work without problems**

```sh
   sudo apt install -y git stow \
&& git clone git@github.com:fledra/dotfiles.git $HOME/.dotfiles \
&& find $HOME/.dotfiles -not \( -path $HOME/.dotfiles/.git -prune \) -type f -printf "$HOME/%P\0" | xargs -0 rm -f \
&& stow -d $HOME/.dotfiles -t $HOME/ -v .
```

### but I want to know what this does

So I should probably explain what this actually does:

- First line just installs `git` and `stow` without requiring user interaction
- Second line clones this repo to `~/.dotfiles`
- Third line lists the existing dotfile paths and **deletes** the original files
- As the finale, fourth line runs `stow` to link them all
