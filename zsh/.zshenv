[[ -f ~/.aliasrc ]] && . ~/.aliasrc
[[ -f ~/.local.zshrc ]] && . ~/.local.zshrc
export SHELL=$(which zsh)
export KEYTIMEOUT=1
export TERM=xterm
export VISUAL=vim
export EDITOR="$VISUAL"

alias -g fzy='fzy -l 3'
alias ll='ls -lhpG'
alias la='ls -lAhpG'
alias -g stat="status"
alias -g zshrc="~/.zshrc"
alias -g zshenv="~/.zshenv"
alias -g vimrc="~/.vimrc"
alias -g bx='bundle exec'
alias tree='tree -FCA --dirsfirst'
alias seek='rg . --files -g "" | fzy'
alias sane='stty sane'
alias modded_specs="git status --porcelain | grep -E '^(M|A|R).*_spec.rb$' | sed -e 's/^.. //'"
