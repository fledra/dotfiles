#!/usr/bin/env sh

# general
alias q="exit"
alias sa="cat ~/.bash_aliases"
alias ea="$EDITOR ~/.bash_aliases"
alias rea="sif ~/.bash_aliases"
alias res="stow -d $DOTFILES -t ~/ -v ."

# system shortcuts
alias SS="sudo systemctl"
alias sus="systemctl suspend"
alias sdn="sudo shutdown -h now"
alias j="journalctl -xf"
alias ka="killall"
alias mkd="mkdir -pv"
alias ls="ls --color=auto --group-directories-first"
alias lsde="ls -lah --color=auto --group-directories-first"
alias grep="grep --color=auto"
alias diff="diff --color=auto"
alias sns="sensors"
alias io="sudo iotop"
alias ift="sudo iftop"

# package managers
alias a="sudo apt"
alias p="sudo pacman"

# editors

## use neovim for vim if present
command -v nvim > /dev/null && alias vim="nvim" vimdiff="nvim -d"

## make nano use 2 space tabs
alias nano="nano -T 2"

alias e="$EDITOR"
alias c="$CODEEDITOR"
alias v="vim"
alias sv="sudo vim"
alias n="nano"
alias sn="sudo nano"

# git
alias g="git"
alias gs="git status"
alias gc="git commit"
alias gca="git commit --amend"
alias gcm="git commit -m"
alias gcma="git commit --amend --no-edit"
alias gl="git log"
alias gp="git push"
alias ga="git add"
alias gaa="git add ."

## remove local branches that do not exist on remote
alias gprg="git for-each-ref --format '%(refname:short)' --merged HEAD refs/heads | grep -v 'master\|main' | xargs git branch -D"

# docker
alias d="docker"
alias dc="docker compose"
alias dcu="docker compose up"
alias dcd="docker compose down"
alias dcb="docker compose build && docker-compose up"

# advanced

## source a file if it exists
source_if_exists() {
  if [ -f $1 ]; then
    source $1
    return 0
  fi

  echo "Could not find file $1" >&2
  return 1
}
alias sif="source_if_exists"

## get random bytes
rb() {
  local len

  if [ $# -gt 0 ]; then
    case $1 in
      '' | *[!0-9]*) len=128 ;;
      *) len=$1 ;;
    esac
  else
    len=128
  fi

  (tr -dc A-Za-z0-9 < /dev/urandom | head -c $len) && echo
}

luksopen() {
  if [ $# -lt 2 ]; then
    echo "USAGE: luksopen [device-path] [mapped-name]"
    return 1
  fi

  sudo cryptsetup luksOpen $1 $2

  if [ $? -eq 0 ]; then
    echo "$1 opened and mapped to /dev/mapper/$2"
    return 0
  fi

  echo "Failed to open $1"
  return 2
}
