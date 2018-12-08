### CONNOR SETTINGS ### 
alias python=python3.5
alias python3=python3.5
alias py=python3.5
alias ipy=ipython
alias pip=pip3.5
alias pip2='python2 -m pip'
alias pj='py ~/programming/scripts/tools/nice-json-tool.py'
# dumb
alias maek=make
alias mkae=make
alias amke=make

export VIRTUALENVWRAPPER_PYTHON=/bin/python3.5
export VIRTUALENVWRAPPER_VIRTUALENV=/bin/virtualenv
alias pycharm=/home/usryzd/Downloads/pycharm-community-2018.1.1/bin/pycharm.sh

# vi mode in readline
# set -o vi
# bind '"jk":vi-movement-mode'

# plz = sudo !! = sudo prev cmd
alias plz='sudo $(fc -ln -1)'

# pipe into useful clipboard more easily
alias xclip="xclip -selection c"



# .bashrc

# makes requests bundle work
# NOTE - don't need this if /etc/profile.d/ca_bundle_environment.sh works
#export REQUESTS_CA_BUNDLE=/etc/pki/tls/certs/ca-bundle.crt

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

source /bin/virtualenvwrapper.sh


### Oracle Settings ###
ORACLE_UNQNAME=orcl
ORACLE_BASE=/u01/app/usryzd
ORACLE_HOME=$ORACLE_BASE/product/12.2.0/dbhome_1
ORACLE_SID=orcl
PATH=$PATH:$ORACLE_HOME/bin
export ORACLE_HOME
export ORACLE_SID
export PATH
alias rlsql='rlwrap sqlplus'

### Kea settings ###
#export PATH=$PATH:/etc/kea-1.3.0/sbin/
#export PATH=$PATH:/etc/kea-1.3.0/src/bin/keactrl:/etc/kea-1.3.0/src/bin/agent:/etc/kea-1.3.0/src/bin/perfdhcp
export PATH=$PATH:/opt/kea/sbin

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
# required thing for ~/.dotcfg file
alias config='/usr/bin/git --git-dir=/home/usryzd/.dotcfg/ --work-tree=/home/usryzd'
