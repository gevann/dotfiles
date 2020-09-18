[[ -f ~/.aliasrc ]] && . ~/.aliasrc
[[ -f ~/.local.zshrc ]] && . ~/.local.zshrc
export SHELL=$(which zsh)
export KEYTIMEOUT=1
export TERM=xterm
export VISUAL=vim
export EDITOR="$VISUAL"

alias e='vim `rg . --files -g "" | fzf`'
alias la='ls -lAhpG'
alias ll='ls -lhpG'
alias modded_specs="git status --porcelain | grep -E ' *(M|A|R).*_spec.rb$' | sed -e 's/^.. //'"
alias sane='stty sane'
alias seek='rg . --files -g "" | fzy'
alias tree='tree -FCA --dirsfirst'
alias gco='git checkout'
alias glog='git log --oneline --show-linear-break'

alias -g bx='bundle exec'
alias -g fbranch='`git --no-pager branch | fzf`'
alias -g fmf='`git status --porcelain | grep -E "^ +(M|A|R)" | sed -e "s/^.. //" | fzy -l 10`'
alias -g fsha='`git --no-pager log -n 20 --oneline | fzf | cut -d" " -f 1`'
alias -g fzy='fzy -l 3'
alias -g stat="status"
alias -g vimrc="~/.vimrc"
alias -g zshenv="~/.zshenv"
alias -g zshrc="~/.zshrc"
