#!/usr/bin/env sh
# shellcheck disable=SC2155

# add all directories in `~/.local/bin` to $PATH
export PATH="$PATH:$(find ~/.local/bin -type d | paste -sd ':' -)"

# where dotfiles reside
export DOTFILES="~/.dotfiles"

# default programs
export EDITOR="nvim"
export CODEEDITOR="code"
export BROWSER="vivaldi"

# home clean-up
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export HISTFILE="$XDG_DATA_HOME/history"
