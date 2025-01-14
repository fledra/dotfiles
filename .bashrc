#!/usr/bin/env bash
#   _               _
#  | |             | |
#  | |__   __ _ ___| |__  _ __ ___
#  | '_ \ / _` / __| '_ \| '__/ __|
#  | |_) | (_| \__ \ | | | | | (__
#  |_.__/ \__,_|___/_| |_|_|  \___|
#
#
#  because who doesn't like some ascii art
#

# If not running interactively, don't do anything
case $- in
  *i*) ;;
  *) return ;;
esac

# bash opts
shopt -s autocd
shopt -s histappend
shopt -s checkwinsize
shopt -s globstar

# command history
HISTSIZE=2000
HISTFILESIZE=5000
HISTCONTROL=ignoreboth

# make GPG work with remote terminals
export GPG_TTY=$(tty)

# make less more friendly for non-text input files
command -v lesspipe >/dev/null && eval "$(SHELL=/bin/sh lesspipe)"

# load aliases
if [ -f ~/.bash_aliases ]; then
  source ~/.bash_aliases
fi

# setup tab completion
if ! shopt -oq posix; then
  source_if_exists /usr/share/bash-completion/bash_completion

  if [ $? -eq 1 ]; then
    source_if_exists /etc/bash_completion
  fi
fi

# setup prompt
function color_my_prompt {
  local __user_and_host="\[\033[01;32m\]\u@\h"
  local __cur_location="\[\033[01;34m\]\w"
  local __git_branch_color="\[\033[31m\]"
  local __git_branch='`git branch 2> /dev/null | grep -e ^* | sed -E  s/^\\\\\*\ \(.+\)$/\(\\\\\1\)\ /`'
  local __prompt_tail="\[\033[35m\]$"
  local __last_color="\[\033[00m\]"
  local __git_dirty='`git rev-parse --abbrev-ref HEAD 2> /dev/null && (git diff --no-ext-diff --quiet --exit-code 2> /dev/null || echo -e \*)`'
  export PS1="$__user_and_host $__cur_location $__git_branch_color$__git_branch$__prompt_tail$__last_color "
}
color_my_prompt

# node version manager
export NVM_DIR="$XDG_CONFIG_HOME/nvm"
source_if_exists "$NVM_DIR/nvm.sh"  # This loads nvm
source_if_exists "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# pnpm
export PNPM_HOME="$XDG_DATA_HOME/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
