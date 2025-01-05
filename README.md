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

Mind you, **this removes the files in their original locations to make stow work without problems**

```sh
sudo apt install -y git stow && git clone git@github.com:fledra/dotfiles.git ~/.dotfiles && find ~/.dotfiles -not \( -path ~/.dotfiles/.git -prune \) -type f -printf "$HOME/%P\0" | xargs -0 rm -f && stow -d ~/.dotfiles -t ~/ -v .
```

### but I want to know what this does

So I should probably explain what this actually does:

It has 3 parts, 4 if you count piping `find` to run `rm` with `xargs`

- `sudo apt install -y git stow`
  - installs git and stow, pre-confirming package installations

- `git clone git@github.com:fledra/dotfiles.git ~/.dotfiles`
  - clones this repo to `~/.dotfiles`

- `find ~/.dotfiles -not \( -path ~/.dotfiles/.git -prune \) -type f -printf "$HOME/%P\0" | xargs -0 rm -f`
  - `find ~/.dotfiles` lists all files in `~/.dotfiles` recursively
  - `-not \( -path ~/.dotfiles/.git -prune \)` tells `find` to remove the `.git` directory and files under it from the output
  - `-type f` makes `find` only show full file paths, without their parent directories
  - `-printf "$HOME/%P\0"` instructs `find` to prepend `$HOME` and print the file's name without the starting-point (which is `~/.dotfiles` here) and end it with the null character `\0` instead of `\n`
  - then `|` pipes `find`'s output to
  - `xargs -0 rm -f`
    - `-0` tells `xargs` the input is seperated by the null character instead of whitespace
    - `rm -f` _obviously_ removes all the found files

- `stow -d ~/.dotfiles -t ~/ -v .`
  - `-d ~/.dotfiles -t ~/` instructs `stow` to use `~/.dotfiles` as it's _source_ directory and `~/` as it's target directory
  - `-v` is just for verbosity, to see which files and where those files are actually linked to
