### FROM WINDOWS ###
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
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
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
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

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



### BEGIN CONNOR STUFF ###

### convenience aliases ###
# python versions
alias python3=python3.5
alias python=python3.5
alias py=python3.5
alias ipy=ipython
alias pip='python3.5 -m pip'
alias pip2='python2 -m pip'
# plz = sudo !! = sudo prev cmd
alias plz='sudo $(fc -ln -1)'
# pipe into useful clipboard more easily
alias xclipc="xclip -selection c"
alias xclipp="xclip -o"
# ag global ignore file
alias ag='ag --path-to-ignore ~/.ignore'
# tmux attach
alias tm='tmux a -t'
# dumb
alias maek=make
alias mkae=make
alias amke=make
# black
alias black='python3.6 -m black'
# my own tools
alias pyj='python -m json.tool'  # python json
alias pj='py ~/src/misc/scripts/tools/nice_json_tool.py'  # pretty print json
alias macformat='py ~/src/misc/scripts/tools/fmt_mac.py'

# virtualenvwrapper
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3.5
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/src
source /home/usryzd/.local/bin/virtualenvwrapper.sh
alias editvenvvars='vi -O $VIRTUAL_ENV/bin/postactivate $VIRTUAL_ENV/bin/postdeactivate'


### useful binaries ###
# bat is better cat
alias bat='/usr/local/bat/bat'
# couchbase cli
alias cb='/opt/couchbase/bin/couchbase-cli'
alias cbq='/opt/couchbase/bin/cbq -u Administrator -p password'
# docsis encoder
alias docsis='/home/usryzd/src/bxe-docsis-encoder/deployed/docsis-install-exec/bin/docsis'

### useful history settings ###
# Make Bash append rather than overwrite the history on disk:
shopt -s histappend
# Don't put duplicate lines in the history.
export HISTCONTROL=ignoredups
export HISTSIZE=100000
export HISTFILESIZE=100000

# better prompt:
STARTCOLOR='\e[1;31m';
ENDCOLOR="\e[0m"
PROMPT='\u@\h \W \$ '
# this has problems with colors
# export PS1="$STARTCOLOR$PROMPT$ENDCOLOR"
# export PS1="[\u@\h \W]\$ "

# reset DISPLAY easily: (doesn't work...)
# from https://goosebearingbashshell.github.io/2017/12/07/reset-display-variable-in-tmux.html
# and the cmd does work in shell
# alias display-reset=eval `export DISPLAY="`tmux show-env | sed -n 's/^DISPLAY=//p'`"`


# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

### Oracle Settings ###
ORACLE_UNQNAME=orcl
ORACLE_SID=orcl
ORACLE_BASE=/u01/app/oracle
ORACLE_HOME=$ORACLE_BASE/product/12.1.2/dbhome_1
PATH=$PATH:$ORACLE_HOME/bin
export ORACLE_HOME
export ORACLE_SID
export PATH
export LD_LIBRARY_PATH='/usr/lib/oracle/19.3/client64/lib'
alias rlsql='rlwrap sqlplus'

### Kea settings ###
#export PATH=$PATH:/etc/kea-1.3.0/sbin/
#export PATH=$PATH:/etc/kea-1.3.0/src/bin/keactrl:/etc/kea-1.3.0/src/bin/agent:/etc/kea-1.3.0/src/bin/perfdhcp
export PATH=$PATH:/opt/kea/sbin

# required for fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[ -f ~/.git.bash ] && . ~/.git.bash
bind -x '"\C-e": fzf-file-widget'
# export FZF_COMPLETION_TRIGGER='**'  # previously '**'
# bind -x '"\C-e": fzf-completion'
# alias ='fzf-completion'

# required thing for ~/.dotcfg file
alias config='/usr/bin/git --git-dir=$HOME/.dotcfg/ --work-tree=$HOME'

# gpg is supposed to have this for some reason
GPG_TTY=$(tty)
export GPG_TTY
