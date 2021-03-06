# bash_aliases

# systems' things
alias ptree='pstree -hapGU $USER'
alias wptree='watch -c pstree -hapGU $*'
alias ll='ls -l'
alias rm='rm -i'

# open commonly used files
alias bashrc="vim $HOME/.bashrc"
alias pathrc="vim $HOME/.pathrc"
alias vimrc='vim $HOME/.vimrc'

# git
alias gs='git status -uno'
alias gl='git log'
alias gd='git diff'
alias gb='git branch'
alias ne='git commit --amend --no-edit'
alias amend='git commit --amend'
alias show='git show'

# screen
alias sls='screen -ls'

# fzf
alias v='vim $(fzf)'
