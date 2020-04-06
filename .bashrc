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
alias pj='py ~/src/misc/scripts/tools/nice_json_tool.py'
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
alias config='/usr/bin/git --git-dir=/home/usryzd/.dotcfg/ --work-tree=/home/usryzd'

# gpg is supposed to have this for some reason
GPG_TTY=$(tty)
export GPG_TTY
