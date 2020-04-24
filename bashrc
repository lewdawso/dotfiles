# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
fi

# source bash_aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

export PAGER=less
export EDITOR=vim

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# set vim bindings for command line editing
set -o vi

export GOPATH="$HOME/golang"
export GOBIN="$GOPATH/bin"
GOPATH="$HOME/code/golang"

############################################
 
# Modified from emilis bash prompt script
 
# from https://github.com/emilis/emilis-config/blob/master/.bash_ps1
 
#
 
# Modified for Mac OS X by
 
# @corndogcomputer
 
###########################################
# Fill with minuses
 
# (this is recalculated every time the prompt is shown in function
# prompt_command):
 
fill="--- "
 
 
reset_style='\[\033[00m\]'
 
status_style=$reset_style'\[\033[0;37m\]' # gray color; use 0;37m for lighter color
 
prompt_style=$reset_style
 
command_style=$reset_style'\[\033[1;29m\]' # bold black
 
# Prompt variable:
 
 
PS1="$status_style"'$fill
\t\n'"$prompt_style"'${debian_chroot:+($debian_chroot)}\u@\h:\w\$'"$command_style
"
 
 
# Reset color for command output
 
# (this one is invoked every time before a command is executed):
 
trap 'echo -ne "\033[00m"' DEBUG

set bell-style none
 
 
function prompt_command {
 
 
# create a $fill of all screen width minus the time string and a space:
 
let fillsize=${COLUMNS}-9
 
fill=""
 
while [ "$fillsize" -gt "0" ]
 
do
 
fill="-${fill}" # fill with underscores to work on
 
let fillsize=${fillsize}-1
 
done
 
 
# If this is an xterm set the title to user@host:dir
 
case "$TERM" in
 
xterm*|rxvt*)
 
bname=`basename "${PWD/$HOME/~}"`
 
echo -ne "\033]0;${bname}: ${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"
 
;;
 
*)
 
;;
 
esac
 
 
}
 
PROMPT_COMMAND=prompt_command

# screen

scill() {
    screen -X -S "$1" quit
}

############################################################

seek () {
    rg "$1" .
}

mk () {
    mkdir "$1" $$ cd "$1"
}

get () {
    find . -iname "*$1*"
}

gosrc () {
    cd $GOPATH/src
}

attach() {
    screen -r "$1"
}

if [ -f ~/.nix-profile ]; then
  export PATH="~/.nix-profile/bin:$PATH"
fi

export PATH="$PATH:$GOBIN"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export TERM=xterm-256color
